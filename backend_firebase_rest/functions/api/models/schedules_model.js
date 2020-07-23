const database = require("../database");
const tripModel = require("./trips_model");
const userModel = require("./users_model");

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
    return schedule;
  }

  async delete(id) {
    return database.delete("schedules", id);
  }

  async update(id, schedule) {
    var schedule = await database.set("schedules", id, schedule);
    return schedule;
  }
}

module.exports = new SchedulesModel();
