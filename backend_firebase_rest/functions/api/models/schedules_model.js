const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class SchedulesModel {
  constructor() {
    if (this.instance) return this.instance;
    SchedulesModel.instance = this;
  }

  get() {
    return database.getList("schedules");
  }

  getById(id) {
    return database.get("schedules", id);
  }

  create(schedule) {
    return database.create("schedules", schedule);
  }

  delete(id) {
    return database.delete("schedules", id);
  }

  update(id, schedule) {
    return database.set("schedules", id, schedule);
  }
}

module.exports = new SchedulesModel();
