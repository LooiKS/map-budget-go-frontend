const database = require("../database");
const tripModel = require("./trips_model");

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

  async delete(id) {
    var trip = await tripModel.getTripOfSchedule(id);
    if (trip != null) {
      trip.schedules.splice(trip.schedules.indexOf(id), 1);
      tripModel.update(trip["id"], trip);
    }
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
