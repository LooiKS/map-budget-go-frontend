const database = require('../database');

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
        expense["createdBy"] = await database.get("users", expense["createdBy"]);
        expense["payBy"] = await database.get("users", expense["payBy"]);
        // var members = [];
        // for (var i in expense["sharedBy"]) {
        //     members.push(database.get("users", i));
        // }
        // expense["sharedBy"] = members;
        for (var i = 0; i < expense["sharedBy"].length; i++) {
            expense["sharedBy"][i] = database.get("users", expense["sharedBy"][i]);
        }
        return expense;
    }

    delete(id) {
        return database.delete('expenses', id);
    }

    async update(id, expense) {
        var expense = await database.set("expenses", id, expense);
        // TODO: call users_model method instead of calling db
        expense["createdBy"] = await database.get("users", expense["createdBy"]);
        expense["payBy"] = await database.get("users", expense["payBy"]);
        // var members = [];
        // for (var i in expense["sharedBy"]) {
        //     members.push(database.get("users", i));
        // }
        // expense["sharedBy"] = members;
        for (var i = 0; i < expense["sharedBy"].length; i++) {
            expense["sharedBy"][i] = await database.get("users", expense["sharedBy"][i]);
        }
        return expense;
    }
}

module.exports = new ExpensesModel();