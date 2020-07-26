const usersModel = require("../models/users_model");
const db = require("../database");
const express = require("express");
const router = express.Router();

router.post("/profile", function (req, res) {
  const path = require("path");
  const os = require("os");
  const fs = require("fs");
  const Busboy = require("busboy");
  const busboy = new Busboy({ headers: req.headers });
  const uploads = {};
  var bucket = db.admin.storage().bucket();
  var newFileName = "";

  busboy.on("file", (fieldname, file, filename, encoding, mimetype) => {
    newFileName = new Date().getTime() + "-" + filename;

    // Note that os.tmpdir() is an in-memory file system, so should only
    // be used for files small enough to fit in memory.
    const filepath = path.join(os.tmpdir(), newFileName);
    uploads[fieldname] = { file: filepath };
    file.pipe(fs.createWriteStream(filepath));
  });

  // This callback will be invoked after all uploaded files are saved.
  busboy.on("finish", () => {
    for (const name in uploads) {
      const upload = uploads[name];
      const file = upload.file;
      // return db.admin
      bucket.upload(file, function (err, uploadedFile, apiResponse) {
        uploadedFile.makePublic();
        fs.unlinkSync(file);
      });
      res.json({
        photoUrl: `https://storage.googleapis.com/map-budget-go.appspot.com/${newFileName}`,
      });
    }
    res.end(); //json({});
  });

  // The raw bytes of the upload will be in req.rawBody.  Send it to busboy, and get
  // a callback when it's finished.
  busboy.end(req.rawBody);
});

// Get all users
router.get("/", async (req, res, next) => {
  try {
    const result = await usersModel.get();

    if (req.query.email != null) {
      for (var i = 0; i < result.length; i++) {
        if (result[i].email == req.query.email) {
          for (var j = 0; j < result[i].friend.length; j++) {
            const friendResult = await usersModel.getById(result[i].friend[j]);
            friendResult.friend = [];
            result[i].friend[j] = friendResult;
          }
          return res.json(result[i]);
        }
      }
      return res.json(null);
    }

    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

// Get one user by id
router.get("/:id", async (req, res, next) => {
  try {
    const result = await usersModel.getById(req.params.id);
    if (!result) return res.sendStatus(404);

    for (var i = 0; i < result.friend.length; i++) {
      const friendResult = await usersModel.getById(result.friend[i]);
      friendResult.friend = [];
      result.friend[i] = friendResult;
    }

    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

// Create a new user
router.post("/", async (req, res, next) => {
  try {
    const result = await usersModel.create(req.body);
    if (!result) return res.sendStatus(409);
    return res.status(201).json(result);
  } catch (e) {
    return next(e);
  }
});

// Delete a user
router.delete("/:id", async (req, res, next) => {
  try {
    const result = await usersModel.delete(req.params.id);
    if (!result) return res.sendStatus(404);
    return res.sendStatus(200);
  } catch (e) {
    return next(e);
  }
});

// Update a user
router.patch("/:id", async (req, res, next) => {
  try {
    const id = req.params.id;
    const data = req.body;

    const doc = await usersModel.getById(id);
    if (!doc) return res.sendStatus(404);

    // Merge existing fields with the ones to be updated
    Object.keys(data).forEach((key) => (doc[key] = data[key]));

    const updateResult = await usersModel.update(id, doc);
    if (!updateResult) return res.sendStatus(404);

    for (var i = 0; i < doc.friend.length; i++) {
      const friendResult = await usersModel.getById(doc.friend[i]);
      friendResult.friend = [];
      doc.friend[i] = friendResult;
    }

    return res.json(doc);
  } catch (e) {
    return next(e);
  }
});

// Replace a user
router.put("/:id", async (req, res, next) => {
  try {
    const updateResult = await usersModel.update(req.params.id, req.body);
    if (!updateResult) return res.sendStatus(404);

    const result = await usersModel.getById(req.params.id);
    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

module.exports = router;
