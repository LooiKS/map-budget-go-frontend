const tripsModel = require("../models/trips_model");
const express = require("express");
const router = express.Router();

// Get all trips
router.get("/", async (req, res, next) => {
  try {
    const result = await tripsModel.get();
    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

// Get one trip
router.get("/:id", async (req, res, next) => {
  try {
    const result = await tripsModel.getById(req.params.id);
    if (!result) return res.sendStatus(404);
    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

// Create a new trip
router.post("/", async (req, res, next) => {
  try {
    const result = await tripsModel.create(req.body);
    if (!result) return res.sendStatus(409);
    return res.status(201).json(result);
  } catch (e) {
    return next(e);
  }
});

// Delete a trip
router.delete("/:id", async (req, res, next) => {
  try {
    const result = await tripsModel.delete(req.params.id);
    if (!result) return res.sendStatus(404);
    return res.sendStatus(200);
  } catch (e) {
    return next(e);
  }
});

// Update a trip
router.patch("/:id", async (req, res, next) => {
  try {
    // return res.sendStatus(200);
    const id = req.params.id;
    const data = req.body;

    const doc = await tripsModel.getById(id);
    if (!doc) return res.sendStatus(404);

    // Merge existing fields with the ones to be updated
    Object.keys(data).forEach((key) => (doc[key] = data[key]));

    const updateResult = await tripsModel.update(id, doc);
    if (!updateResult) return res.sendStatus(404);

    return res.json(doc);
  } catch (e) {
    return next(e);
  }
});

// Replace a trip
router.put("/:id", async (req, res, next) => {
  try {
    const updateResult = await tripsModel.update(req.params.id, req.body);
    if (!updateResult) return res.sendStatus(404);

    const result = await tripsModel.getById(req.params.id);
    return res.json(result);
  } catch (e) {
    return next(e);
  }
});

module.exports = router;
