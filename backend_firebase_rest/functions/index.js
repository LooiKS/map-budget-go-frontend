const functions = require("firebase-functions");
const express = require("express");
const app = express();
const todosRouter = require("./api/controllers/todos_controller");
const schedulesRouter = require("./api/controllers/schedules_controller");

app.use(express.json());
app.use("/todos", todosRouter);
app.use("/schedules", schedulesRouter);

exports.api = functions.https.onRequest(app);

// To handle "Function Timeout" exception
exports.functionsTimeOut = functions.runWith({
  timeoutSeconds: 300,
});

exports.setupdb = functions.https.onRequest(require("./setup_database"));
