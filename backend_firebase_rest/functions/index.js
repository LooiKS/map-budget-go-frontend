const functions = require("firebase-functions");
const express = require("express");
const app = express();
const todosRouter = require("./api/controllers/todos_controller");
const schedulesRouter = require("./api/controllers/schedules_controller");
const usersRouter = require("./api/controllers/users_controller");
const tripsRouter = require("./api/controllers/trips_controller");
const users_model = require("./api/models/users_model");
const db = require("./api/database");

const expensesRoute = require("./api/controllers/expenses_controller");

app.use(express.json());
app.use("/todos", todosRouter);
app.use("/schedules", schedulesRouter);
app.use("/users", usersRouter);
app.use("/trips", tripsRouter);
app.use("/expenses", expensesRoute);

// create user when user is signing up
exports.register = functions.auth.user().onCreate((user, context) => {
  var firstName = "",
    lastName = "";

  var username = user.displayName ? user.displayName.split(" ") : "";
  if (username.length > 0) firstName = username[0];
  if (username.length > 1) lastName = username[1];

  users_model.createWithCustomId({
    id: user.uid,
    firstName: firstName,
    lastName: lastName,
    phoneNum: user.phoneNumber,
    email: user.email,
    profilePic: user.photoURL,
    username: user.displayName,
    friend: [],
    password: user.passwordHash,
    isChecked: false,
  });
});

exports.api = functions.https.onRequest(app);

// To handle "Function Timeout" exception
exports.functionsTimeOut = functions.runWith({
  timeoutSeconds: 300,
});

exports.setupdb = functions.https.onRequest(require("./setup_database"));
