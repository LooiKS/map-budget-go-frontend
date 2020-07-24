const database = require('../database');

// Here, we are implementing the class with Singleton design pattern

class TripModel {
    constructor() {
        if (this.instance) return this.instance;
        TripModel.instance = this;
    }

    async get() {
        var trips = await database.getList('trips');
        for (var i = 0; i < trips.length; i++) {
            trips[i]["owner"] = await database.get("users", trips[i]["owner"]);
            for (var n = 0; n < trips[i]["owner"]["friend"].length; n++) {
                trips[i]["owner"]["friend"][n] = await database.get("users", trips[i]["owner"]["friend"][n]);
                trips[i]["owner"]["friend"][n]["friend"] = [];

            }
            for (var j = 0; j < trips[i]["members"].length; j++) {
                trips[i]["members"][j] = await database.get("users", trips[i]["members"][j]);
                trips[i]["members"][j]["friend"] = [];

            }
            for (var k = 0; k < trips[i]["schedules"].length; k++) {
                trips[i]["schedules"][k] = await database.get("schedules", trips[i]["schedules"][k]);
                trips[i]["schedules"][k]["createdBy"] = await database.get("users", trips[i]["schedules"][k]["createdBy"]);
                trips[i]["schedules"][k]["createdBy"]["friend"] = [];
            }
            for (var l = 0; l < trips[i]["expenses"].length; l++) {
                trips[i]["expenses"][l] = await database.get("expenses", trips[i]["expenses"][l]);
                trips[i]["expenses"][l]["createdBy"] = await database.get("users", trips[i]["expenses"][l]["createdBy"]);
                trips[i]["expenses"][l]["createdBy"]["friend"] = [];
                trips[i]["expenses"][l]["payBy"] = await database.get("users", trips[i]["expenses"][l]["payBy"]);
                trips[i]["expenses"][l]["payBy"]["friend"] = [];
                for (var m = 0; m < trips[i]["expenses"][l]["sharedBy"].length; m++) {
                    trips[i]["expenses"][l]["sharedBy"][m] = await database.get("users", trips[i]["expenses"][l]["sharedBy"][m]);
                    trips[i]["expenses"][l]["sharedBy"][m]["friend"] = [];
                }
            }
        }
        return trips;
    }

    getById(id) { return database.get('trips', id) }

    async create(trip) {
        var trip = await database.create("trips", trip);
        trip["owner"] = await database.get("users", trip["owner"]);
        for (var n = 0; n < trip["owner"]["friend"].length; n++) {
            trip["owner"]["friend"][n] = await database.get("users", trip["owner"]["friend"][n]);
            trip["owner"]["friend"][n]["friend"] = [];
        }
        for (var j = 0; j < trip["members"].length; j++) {
            trip["members"][j] = await database.get("users", trip["members"][j]);
            trip["members"][j]["friend"] = [];

        }
        for (var k = 0; k < trip["schedules"].length; k++) {
            trip["schedules"][k] = await database.get("schedules", trip["schedules"][k]);
            trip["schedules"][k]["createdBy"] = await database.get("users", trip["schedules"][k]["createdBy"]);
            trip["schedules"][k]["createdBy"]["friend"] = [];
        }
        for (var l = 0; l < trip["expenses"].length; l++) {
            trip["expenses"][l] = await database.get("expenses", trip["expenses"][l]);
            trip["expenses"][l]["createdBy"] = await database.get("users", trip["expenses"][l]["createdBy"]);
            trip["expenses"][l]["createdBy"]["friend"] = [];
            trip["expenses"][l]["payBy"] = await database.get("users", trip["expenses"][l]["payBy"]);
            trip["expenses"][l]["payBy"]["friend"] = [];
            for (var m = 0; m < trip["expenses"][l]["sharedBy"].length; m++) {
                trip["expenses"][l]["sharedBy"][m] = await database.get("users", trip["expenses"][l]["sharedBy"][m]);
                trip["expenses"][l]["sharedBy"][m]["friend"] = [];
            }
        }
        return trip;
    }

    delete(id) {
        return database.delete('trips', id)
    }

    async getTripOfSchedule(scheduleId) {
        const trips = await database.getList("trips");
        if (trips != null)
            for (var i = 0; i < trips.length; i++) {
                var trip = trips[i];
                if (trip["schedules"].indexOf(scheduleId) > -1) {
                    return trip;
                }
            }
        return null;
    }


    async update(id, trip) {
        var trip = await database.set("trips", id, trip);
        trip["owner"] = await database.get("users", trip["owner"]);
        for (var n = 0; n < trip["owner"]["friend"].length; n++) {
            trip["owner"]["friend"][n] = await database.get("users", trip["owner"]["friend"][n]);
            trip["owner"]["friend"][n]["friend"] = [];
        }
        for (var j = 0; j < trip["members"].length; j++) {
            trip["members"][j] = await database.get("users", trip["members"][j]);
            trip["members"][j]["friend"] = [];

        }
        for (var k = 0; k < trip["schedules"].length; k++) {
            trip["schedules"][k] = await database.get("schedules", trip["schedules"][k]);
            trip["schedules"][k]["createdBy"] = await database.get("users", trip["schedules"][k]["createdBy"]);
            trip["schedules"][k]["createdBy"]["friend"] = [];
        }
        for (var l = 0; l < trip["expenses"].length; l++) {
            trip["expenses"][l] = await database.get("expenses", trip["expenses"][l]);
            trip["expenses"][l]["createdBy"] = await database.get("users", trip["expenses"][l]["createdBy"]);
            trip["expenses"][l]["createdBy"]["friend"] = [];
            trip["expenses"][l]["payBy"] = await database.get("users", trip["expenses"][l]["payBy"]);
            trip["expenses"][l]["payBy"]["friend"] = [];
            for (var m = 0; m < trip["expenses"][l]["sharedBy"].length; m++) {
                trip["expenses"][l]["sharedBy"][m] = await database.get("users", trip["expenses"][l]["sharedBy"][m]);
                trip["expenses"][l]["sharedBy"][m]["friend"] = [];
            }
        }
        return trip;
    }

    async getTripExpenses(expenseID) {
        const trips = await database.getList("trips");
        if (trips != null) {
            for (var i = 0; i < trips.length; i++) {
                var trip = trips[i];
                if (trip["expenses"].indexOf(expenseID) > -1) {
                    return trip;
                }
            }
        }
        return null;
    }
}

module.exports = new TripModel();