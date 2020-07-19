const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class UsersModel {
  constructor() {
    if (this.instance) return this.instance;
    TodoModel.instance = this;
  }

  get() {
    return database.getList("users");
  }

  getById(id) {
    return database.get("users", id);
  }

  create(todo) {
    return database.create("users", user);
  }

  delete(id) {
    return database.delete("users", id);
  }

  update(id, todo) {
    return database.set("users", id, user);
  }
}

module.exports = new UsersModel();
