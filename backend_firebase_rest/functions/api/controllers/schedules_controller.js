const schedulesModel = require("../models/schedules_model");
const express = require("express");
const router = express.Router();
const userModel = require("../models/users_model");

// Get all schedules
router.get("/", async (req, res, next) => {
  try {
    const result = await schedulesModel.get();
    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

// Get one todo
router.get("/:id", async (req, res, next) => {
  try {
    const result = await schedulesModel.getById(req.params.id);
    if (!result) return res.sendStatus(404);
    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

// Create a new todo
router.post("/", async (req, res, next) => {
  try {
    const schedule = await schedulesModel.create(req.body);
    if (!schedule) return res.sendStatus(409);
    console.log(schedule);
    schedule["createdBy"] = await userModel.getById(schedule["createdBy"]); //await database.get("users", schedule["createdBy"]);
    for (let i = 0; i < schedule["createdBy"]["friend"].length; i++) {
      const friend = schedule["createdBy"]["friend"][i];
      var f = await userModel.getById(friend);
      f["friend"] = [];
      schedule["createdBy"]["friend"][i] = f;
    }
    console.log(schedule);

    return res.status(201).json(schedule);
  } catch (e) {
    return next(e);
  }
});

// Delete a todo
router.delete("/:id", async (req, res, next) => {
  try {
    const result = await schedulesModel.delete(req.params.id);
    if (!result) return res.sendStatus(404);
    return res.sendStatus(200);
  } catch (e) {
    return next(e);
  }
});

// Update a todo
router.patch("/:id", async (req, res, next) => {
  try {
    // return res.sendStatus(200);
    const id = req.params.id;
    const data = req.body;

    const doc = await schedulesModel.getById(id);
    if (!doc) return res.sendStatus(404);

    // Merge existing fields with the ones to be updated
    Object.keys(data).forEach((key) => (doc[key] = data[key]));

    const schedule = await schedulesModel.update(id, doc);
    schedule["createdBy"] = await userModel.getById(schedule["createdBy"]); //await database.get("users", schedule["createdBy"]);
    for (let i = 0; i < schedule["createdBy"]["friend"].length; i++) {
      const friend = schedule["createdBy"]["friend"][i];
      var f = await userModel.getById(friend);
      f["friend"] = [];
      schedule["createdBy"]["friend"][i] = f;
    }
    if (!schedule) return res.sendStatus(404);

    return res.json(schedule);
  } catch (e) {
    return next(e);
  }
});

// Replace a todo
router.put("/:id", async (req, res, next) => {
  try {
    const updateResult = await schedulesModel.update(req.params.id, req.body);
    if (!updateResult) return res.sendStatus(404);

    const result = await schedulesModel.getById(req.params.id);
    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

module.exports = router;
