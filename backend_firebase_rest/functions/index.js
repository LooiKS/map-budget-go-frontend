const functions = require("firebase-functions");
const express = require("express");
const app = express();
const todosRouter = require("./api/controllers/todos_controller");
const schedulesRouter = require("./api/controllers/schedules_controller");
const usersRouter = require("./api/controllers/users_controller");
const tripsRouter = require("./api/controllers/trips_controller");
const users_model = require("./api/models/users_model");
const db = require("./api/database");
// var bodyParser = require("body-parser");
// app.use(bodyParser.json()); // to support JSON-encoded bodies
// app.use(
//   bodyParser.urlencoded({
//     // to support URL-encoded bodies
//     extended: false,
//   })
// );
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

exports.uploadimg = functions.https.onRequest(function () {
  //-
  // It's not always that easy. You will likely want to specify the filename
  // used when your new file lands in your bucket.
  //
  // You may also want to set metadata or customize other options.
  //-
  const options = {
    destination: "new-image.png",
    // resumable: true,
    // validation: "crc32c",
    metadata: {
      metadata: {
        event: "Fall trip to the zoo",
      },
    },
  };
  const { Storage } = require("@google-cloud/storage");
  const storage = new Storage();
  const bucket = storage.bucket("albums");

  // return db.admin
  bucket.upload("local-image.jpg", function (err, file, apiResponse) {
    // Your bucket now contains:
    // - "image.png" (with the contents of `/local/path/image.png')
    // `file` is an instance of a File object that refers to your new file.
  });

  // return db.admin.storage().bucket().upload("local-image.jpg", options);
});
exports.setupdb = functions.https.onRequest(require("./setup_database"));
