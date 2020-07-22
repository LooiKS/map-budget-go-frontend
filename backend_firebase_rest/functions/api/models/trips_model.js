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
            console.log(trips);
            trips[i]["owner"] = await database.get("users", trips[i]["owner"]);
            //trips[i]["owner"]["friend"] = [];
            for (var j = 0; j < trips[i]["members"].length; j++) {
                trips[i]["members"][j] = await database.get("users", trips[i]["members"][j]);
                //    trips[i]["members"][j]["friend"] = [];

            }
            for (var k = 0; k < trips[i]["schedules"].length; k++) {
                trips[i]["schedules"][k] = await database.get("schedules", trips[i]["schedules"][k]);
                trips[i]["schedules"][k]["createdBy"] = await database.get("users", trips[i]["schedules"][k]["createdBy"]);
                //    trips[i]["schedules"][k]["createdBy"]["friend"] = [];
            }
            for (var l = 0; l < trips[i]["expenses"].length; l++) {
                trips[i]["expenses"][l] = await database.get("expenses", trips[i]["expenses"][l]);
                trips[i]["expenses"][l]["createdBy"] = await database.get("users", trips[i]["expenses"][l]["createdBy"]);
                //    trips[i]["expenses"][l]["createdBy"]["friend"] = [];
                trips[i]["expenses"][l]["payBy"] = await database.get("users", trips[i]["expenses"][l]["payBy"]);
                //    trips[i]["expenses"][l]["payBy"]["friend"] = [];
                for (var m = 0; m < trips[i]["expenses"][l]["sharedBy"].length; m++) {
                    trips[i]["expenses"][l]["sharedBy"][m] = await database.get("users", trips[i]["expenses"][l]["sharedBy"][m]);
                    //        trips[i]["expenses"][l]["sharedBy"][m]["friend"] = [];
                }
            }
        }
        return trips;
    }

    getById(id) { return database.get('trips', id) }

    create(trip) { return database.create('trips', trip) }

    delete(id) { return database.delete('trips', id) }

    update(id, trip) { return database.set('trips', id, trip) }
}

module.exports = new TripModel();