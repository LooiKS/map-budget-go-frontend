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

  async create(schedule) {
    var schedule = await database.create("schedules", schedule);
    schedule["createdBy"] = await database.get("users", schedule["createdBy"]);
    return schedule;
  }

  delete(id) {
    return database.delete("schedules", id);
  }

  async update(id, schedule) {
    var schedule = await database.set("schedules", id, schedule);
    // TODO: call users_model method instead of calling db
    schedule["createdBy"] = await database.get("users", schedule["createdBy"]);
    return schedule;
  }
}

module.exports = new SchedulesModel();
