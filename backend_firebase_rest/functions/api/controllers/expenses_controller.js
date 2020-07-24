const expensesModel = require("../models/expenses_model");
const express = require("express");
const router = express.Router();
const userModel = require("../models/users_model");

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

        result["createdBy"] = await userModel.getById(result["createdBy"]);
        for (let i = 0; i < result["createdBy"]["friend"].length; i++) {
            const friend = result["createdBy"]["friend"][i];
            var f = await userModel.getById(friend);
            f["friend"] = [];
            result["createdBy"]["friend"][i] = f;
        }

        result["payBy"] = await userModel.getById(result["payBy"]);
        for (let i = 0; i < result["payBy"]["friend"].length; i++) {
            const friend = result["payBy"]["friend"][i];
            var f = await userModel.getById(friend);
            f["friend"] = [];
            result["payBy"]["friend"][i] = f;
        }

        for (let i = 0; i < result["sharedBy"].length; i++) {
            result["sharedBy"][i] = await userModel.getById(result["sharedBy"][i]);
            for (let j = 0; j < result["sharedBy"][i]["friend"].length; j++) {
                const friend = result["sharedBy"][i]["friend"][j];
                var f = await userModel.getById(friend);
                f["friend"] = [];
                result["sharedBy"][i]["friend"][j] = f;
            }
        }
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

        updateResult["createdBy"] = await userModel.getById(updateResult["createdBy"].id);
        for (let i = 0; i < updateResult["createdBy"]["friend"].length; i++) {
            const friend = updateResult["createdBy"]["friend"][i];
            var f = await userModel.getById(friend);
            f["friend"] = [];
            updateResult["createdBy"]["friend"][i] = f;
        }

        updateResult["payBy"] = await userModel.getById(updateResult["createdBy"].id);
        for (let i = 0; i < updateResult["payBy"]["friend"].length; i++) {
            const friend = updateResult["payBy"]["friend"][i];
            var f = await userModel.getById(friend);
            f["friend"] = [];
            updateResult["payBy"]["friend"][i] = f;
        }

        for (let i = 0; i < updateResult["sharedBy"].length; i++) {
            updateResult["sharedBy"][i] = await userModel.getById(updateResult["sharedBy"][i].id);
            for (let j = 0; j < updateResult["sharedBy"][i]["friend"].length; j++) {
                const friend = updateResult["sharedBy"][i]["friend"][j];
                var f = await userModel.getById(friend);
                f["friend"] = [];
                updateResult["sharedBy"][i]["friend"][j] = f;
            }
        }
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
