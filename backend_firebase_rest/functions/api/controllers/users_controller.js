const usersModel = require("../models/users_model");
const express = require("express");
const router = express.Router();

// Get all users
router.get("/", async (req, res, next) => {
  try {
    const result = await usersModel.get();
    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

// Get one user
router.get("/:id", async (req, res, next) => {
  try {
    const result = await usersModel.getById(req.params.id);
    if (!result) return res.sendStatus(404);
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
