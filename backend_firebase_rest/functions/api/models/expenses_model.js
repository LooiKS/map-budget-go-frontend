const database = require('../database');
const trips_model = require('./trips_model');

// Here, we are implementing the class with Singleton design pattern

class ExpensesModel {
    constructor() {
        if (this.instance) return this.instance;
        ExpensesModel.instance = this;
    }

    get() {
        return database.getList('expenses');
    }

    getById(id) {
        return database.get('expenses', id);
    }

    async create(expense) {
        var expense = await database.create("expenses", expense);
        // expense["createdBy"] = await database.get("users", expense["createdBy"]);
        // expense["payBy"] = await database.get("users", expense["payBy"]);

        // for (var i = 0; i < expense["sharedBy"].length; i++) {
        //     expense["sharedBy"][i] = database.get("users", expense["sharedBy"][i]);
        // }
        return expense;
    }


    async delete(id) {
        var trip = await trips_model.getTripExpenses(id);
        if (trip != null) {
            trip.expenses.splice(trip.expenses.indexOf(id), 1);
            trips_model.update(trip["id"], trip);
        }
        return database.delete('expenses', id);
    }

    async update(id, expense) {
        var expense = await database.set("expenses", id, expense);
        expense["createdBy"] = await database.get("users", expense["createdBy"]);
        expense["payBy"] = await database.get("users", expense["payBy"]);
        for (var i = 0; i < expense["sharedBy"].length; i++) {
            expense["sharedBy"][i] = await database.get("users", expense["sharedBy"][i]);
        }
        return expense;
    }
}

module.exports = new ExpensesModel();