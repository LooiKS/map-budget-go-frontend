const expensesModel = require("../models/expenses_model");
const express = require("express");
const router = express.Router();

// Get all expenses
router.get("/", async (req, res, next) => {
    try {
        const result = await expensesModel.get();
        return res.json(result);
    } catch (e) {
        return next(e);
    }
});

// Get one expense
router.get("/:id", async (req, res, next) => {
    try {
        const result = await expensesModel.getById(req.params.id);
        if (!result) return res.sendStatus(404);
        return res.json(result);
    } catch (e) {
        return next(e);
    }
});

// Create new expense
router.post("/", async (req, res, next) => {
    try {
        const result = await expensesModel.create(req.body);
        if (!result) return res.sendStatus(409);
        return res.status(201).json(result);
    } catch (e) {
        return next(e);
    }
});

// Delete an expense
router.delete("/:id", async (req, res, next) => {
    try {
        const result = await expensesModel.delete(req.params.id);
        if (!result) return res.sendStatus(404);
        return res.sendStatus(200);
    } catch (e) {
        return next(e);
    }
});

// Update an expense
router.patch("/:id", async (req, res, next) => {
    try {
        // return res.sendStatus(200);
        const id = req.params.id;
        const data = req.body;

        const doc = await expensesModel.getById(id);
        if (!doc) return res.sendStatus(404);

        // Merge existing fields with the ones to be updated
        Object.keys(data).forEach((key) => (doc[key] = data[key]));

        const updateResult = await expensesModel.update(id, doc);
        if (!updateResult) return res.sendStatus(404);

        return res.json(doc);
    } catch (e) {
        return next(e);
    }
});

// Replace an expense
router.put("/:id", async (req, res, next) => {
    try {
        const updateResult = await expensesModel.update(req.params.id, req.body);
        if (!updateResult) return res.sendStatus(404);

        const result = await expensesModel.getById(req.params.id);
        return res.json(result);
    } catch (e) {
        return next(e);
    }
});

module.exports = router;
