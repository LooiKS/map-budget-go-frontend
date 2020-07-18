const db = require("./api/database");

const users = [
  {
    id: "BG0001",
    firstName: "Angelababy",
    lastName: "Liss",
    phoneNum: "0123321012",
    email: "angela@example.com",
    profilePic:
      "https://img01.cp.aliimg.com/imgextra/i3/832716541/T2DkrxXg4XXXXXXXXX_!!832716541.jpg",
    username: "angela0210",
    friend: ["BG0002", "BG0003", "BG0004"],
    password: "123",
    isChecked: false,
  },
  {
    id: "BG0002",
    firstName: "Su",
    lastName: "Lin",
    phoneNum: "0123123123",
    email: "sulin@example.com",
    profilePic:
      "https://weilamanner.com/wp-content/uploads/2014/03/150164784159860977.jpg",
    username: "sulin002",
    friend: ["BG0001", "BG0003", "BG0004"],
    password: "123",
    isChecked: false,
  },
  {
    id: "BG0003",
    firstName: "Pui",
    lastName: "Nam",
    phoneNum: "0123210121",
    email: "puinam@example.com",
    profilePic:
      "https://weilamanner.com/wp-content/uploads/2014/03/IMG_4905-e1552467791516.jpg",
    username: "puinam1010",
    friend: ["BG0002", "BG0005", "BG0004"],
    password: "123",
    isChecked: false,
  },
  {
    id: "BG0004",
    firstName: "Lisa",
    lastName: "Lisa",
    phoneNum: "0123120120",
    email: "lisa@example.com",
    profilePic:
      "https://upload.wikimedia.org/wikipedia/commons/c/ce/180819_%EB%B8%94%EB%9E%99%ED%95%91%ED%81%AC_%ED%8C%AC%EC%8B%B8%EC%9D%B8%ED%9A%8C_%EC%BD%94%EC%97%91%EC%8A%A4_%EB%9D%BC%EC%9D%B4%EB%B8%8C%ED%94%84%EB%9D%BC%EC%9E%90_%EB%A6%AC%EC%82%AC.jpg",
    username: "lisa0131",
    friend: ["BG0005", "BG0006", "BG0007"],
    password: "123",
    isChecked: false,
  },
  {
    id: "BG0005",
    firstName: "Luo",
    lastName: "Zhi Hao",
    phoneNum: "0131012310",
    email: "abdul@example.com",
    profilePic:
      "https://weilamanner.com/wp-content/uploads/2017/03/Sixtycents.jpg",
    username: "sixtycent",
    friend: ["BG0006", "BG0003", "BG0004"],
    password: "123",
    isChecked: false,
  },
  {
    id: "BG0009",
    firstName: "Doris",
    lastName: "Duo",
    phoneNum: "014845554",
    email: "doris@example.com",
    profilePic:
      "https://weilamanner.com/wp-content/uploads/2014/03/770807231652212499.jpg",
    username: "doris002",
    friend: ["BG0002", "BG0003", "BG0004"],
    password: "123",
    isChecked: false,
  },
  {
    id: "BG0010",
    firstName: "Rachel",
    lastName: "Lau",
    phoneNum: "0125412214",
    email: "rachel@example.com",
    profilePic:
      "https://weilamanner.com/wp-content/uploads/2014/03/55880639554661888.jpg",
    username: "rachel",
    friend: ["BG0009", "BG0007", "BG0005"],
    password: "123",
    isChecked: false,
  },
  {
    id: "BG0007",
    firstName: "Jeffrey",
    lastName: "Fok",
    phoneNum: "014784554",
    email: "jeffrey@example.com",
    profilePic:
      "https://weilamanner.com/wp-content/uploads/2014/03/399776249949001879.jpg",
    username: "jeffrey002",
    friend: ["BG0002", "BG0003", "BG0004"],
    password: "123",
    isChecked: false,
  },
  {
    id: "BG0008",
    firstName: "Hou",
    lastName: "Dee",
    phoneNum: "014287855",
    email: "houdee@example.com",
    profilePic:
      "https://weilamanner.com/wp-content/uploads/2014/03/69565572756834353.jpg",
    username: "houdee11",
    friend: ["BG0002", "BG0003", "BG0004"],
    password: "123",
    isChecked: false,
  },
  {
    id: "BG0011",
    firstName: "Barack",
    lastName: "Obama",
    phoneNum: "0123123123",
    email: "john@example.com",
    profilePic:
      "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fjvchamary%2Ffiles%2F2016%2F03%2Fman_of_steel-1200x800.jpg",
    username: "obama123",
    friend: ["BG0002", "BG0003", "BG0004"],
    password: "123",
    isChecked: false,
  },
];

const schedules = [
  {
    id: "1",
    startDt: "2020-04-10 08:00:00.000",
    endDt: "2020-04-10 11:00:00.000",
    activityTitle: "Rocky Mountains Summer Explorer",
    activityDesc: "Mountain at Vancouver",
    createdBy: "BG0002",
    createdDt: "2020-03-08 08:00:00.000",
  },
  {
    id: "2",
    startDt: "2020-04-11 11:00:00.000",
    endDt: "2020-04-11 20:00:00.000",
    activityTitle: "Discover Vancouver Island",
    activityDesc: "The special island in Canada",
    createdBy: "BG0003",
    createdDt: "2020-03-09 08:00:00.000",
  },
  {
    id: "3",
    startDt: "2020-04-12 08:00:00.000",
    endDt: "2020-04-12 23:00:00.000",
    activityTitle: "Banff National Park",
    activityDesc:
      "Chance to explore Banff at your own pace, as there are no formal activities planned. Established in 1885, Banff is the oldest national park in the country, and contains over 1600 kilometres (995 miles) of hiking trails.",
    createdBy: "BG0001",
    createdDt: "2020-03-11 12:00:00.000",
  },
];

const expenses = [
  {
    id: "1",
    title: "Train ticket",
    desc: "Train to Busan",
    category: "Transport",
    createdDt: "20-Jul-18",
    amount: 250,
    payBy: "BG0002",
    createdBy: "BG0002",
    sharedBy: ["BG0001", "BG0002", "BG0003"],
  },
  {
    id: "2",
    title: "Mc Donald",
    desc: "Lunch",
    category: "Food & Beverage",
    createdDt: "20-Jul-18",
    amount: 250,
    payBy: "BG0002",
    createdBy: "BG0002",
    sharedBy: ["BG0001", "BG0002", "BG0003"],
  },
  {
    id: "3",
    title: "Kindergarden Hotel",
    desc: "Day 1",
    category: "Accommodation",
    createdDt: "20-Jul-18",
    amount: 250,
    payBy: "BG0002",
    createdBy: "BG0002",
    sharedBy: ["BG0001", "BG0002", "BG0003"],
  },
  {
    id: "4",
    title: "DisneyLand",
    desc: "DisneyLand ticket",
    category: "Entertainment",
    createdDt: "20-Jul-18",
    amount: 250,
    payBy: "BG0002",
    createdBy: "BG0002",
    sharedBy: ["BG0001", "BG0002", "BG0003"],
  },
  {
    id: "5",
    title: "Souvenir",
    desc: "Key chain",
    category: "Others",
    createdDt: "20-Jul-18",
    amount: 250,
    payBy: "BG0002",
    createdBy: "BG0002",
    sharedBy: ["BG0001", "BG0002", "BG0003"],
  },
];

const trips = [
  {
    id: "1",
    tripTitle: "Japan",
    tripDetail: "Honey Moon",
    members: ["BG0001", "BG0002"],
    owner: "BG0001",
    startDt: "2020-04-10 00:00:00.000",
    endDt: "2020-05-20 00:00:00.000",
    schedules: ["1", "2"],
    expenses: ["1", "2"],
    createdDt: "2020-07-18 08:26:06.243592",
    currency: "JPY",
    status: "upcoming",
  },
  {
    id: "2",
    tripTitle: "Canada",
    tripDetail: "See polar bear",
    members: ["BG0001", "BG0002"],
    owner: "",
    startDt: "2020-04-10 00:00:00.000",
    endDt: "2020-05-20 00:00:00.000",
    schedules: ["1", "2"],
    expenses: ["1", "2"],
    createdDt: "2020-07-18 08:26:06.243592",
    currency: "USD",
    status: "upcoming",
  },
  {
    id: "3",
    tripTitle: "Canada",
    tripDetail: "See polar bear",
    members: ["BG0001", "BG0002"],
    owner: "",
    startDt: "2020-04-10 00:00:00.000",
    endDt: "2020-05-20 00:00:00.000",
    schedules: ["1", "2"],
    expenses: ["1", "2"],
    createdDt: "2020-07-18 08:26:06.243592",
    currency: "USD",
    status: "upcoming",
  },
  {
    id: "4",
    tripTitle: "Canada",
    tripDetail: "See polar bear",
    members: ["BG0001", "BG0002"],
    owner: "",
    startDt: "2020-04-10 00:00:00.000",
    endDt: "2020-05-20 00:00:00.000",
    schedules: ["1", "2"],
    expenses: ["1", "2"],
    createdDt: "2020-07-18 08:26:06.243592",
    currency: "USD",
    status: "upcoming",
  },
  {
    id: "5",
    tripTitle: "Canada",
    tripDetail: "See polar bear",
    members: ["BG0001", "BG0002"],
    owner: "",
    startDt: "2020-04-10 00:00:00.000",
    endDt: "2020-05-20 00:00:00.000",
    schedules: ["1", "2"],
    expenses: ["1", "2"],
    createdDt: "2020-07-18 08:26:06.243592",
    currency: "USD",
    status: "upcoming",
  },
];

async function setupDatabase(req, res, next) {
  // To delete all the collections
  const collections = ["users", "todos"];
  collections.forEach(async (collection) => await deleteCollection(collection));

  // Add documents to the todos collection
  addDocuments("users", users);
  addDocuments("trips", trips);
  addDocuments("expenses", expenses);
  addDocuments("schedules", schedules);

  res.send("Setting Up Database.... Done ");
}

async function deleteCollection(collection) {
  const cref = db.firestore.collection(collection);
  const docs = await cref.listDocuments();
  docs.forEach((doc) => doc.delete());
}

function addDocuments(collection, docs) {
  docs.forEach((doc) => {
    db.createWithID(collection, doc);
  });
}

module.exports = setupDatabase;