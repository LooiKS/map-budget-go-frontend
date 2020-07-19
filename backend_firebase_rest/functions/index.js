const functions = require("firebase-functions");
const express = require("express");
const app = express();
const todosRouter = require("./api/controllers/todos_controller");
const schedulesRouter = require("./api/controllers/schedules_controller");
const usersRouter = require("./api/controllers/users_controller");

app.use(express.json());
app.use("/todos", todosRouter);
app.use("/schedules", schedulesRouter);
app.use("/users", usersRouter);

// exports.register = functions.onCallauth.user().onCreate((user, context) => {
//   admin.database().ref("/users").push({ id: "randomid" });
//   console.log("user");
// });
exports.api = functions.https.onRequest(app);

// To handle "Function Timeout" exception
exports.functionsTimeOut = functions.runWith({
  timeoutSeconds: 300,
});

exports.setupdb = functions.https.onRequest(require("./setup_database"));
