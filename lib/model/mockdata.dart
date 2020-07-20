import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';

final User mockOwnUser = User(
    id: "BG0011",
    firstName: "Barack",
    lastName: "Obama",
    phoneNum: "0123123123",
    email: "john@example.com",
    profilePic:
        "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fjvchamary%2Ffiles%2F2016%2F03%2Fman_of_steel-1200x800.jpg",
    username: "obama123",
    password: "123",
    isChecked: false,
    friend: [
      mockUser1,
      mockUser2,
      mockUser3,
      mockUser4,
      mockUser5,
      mockUser6,
      mockUser7,
      mockUser8,
      mockUser9,
      mockUser10,
    ]);

final User mockUser1 = User(
    id: "BG0001",
    firstName: "Angelababy",
    lastName: "Liss",
    phoneNum: "0123321012",
    email: "angela@example.com",
    profilePic:
        "https://img01.cp.aliimg.com/imgextra/i3/832716541/T2DkrxXg4XXXXXXXXX_!!832716541.jpg",
    username: "angela0210",
    password: "123",
    isChecked: false,
    friend: []);

final User mockUser2 = User(
    id: "BG0002",
    firstName: "Su",
    lastName: "Lin",
    phoneNum: "0123123123",
    email: "sulin@example.com",
    profilePic:
        "https://weilamanner.com/wp-content/uploads/2014/03/150164784159860977.jpg",
    username: "sulin002",
    password: "123",
    isChecked: false,
    friend: []);

final User mockUser3 = User(
    id: "BG0003",
    firstName: "Pui",
    lastName: "Nam",
    phoneNum: "0123210121",
    email: "puinam@example.com",
    profilePic:
        "https://weilamanner.com/wp-content/uploads/2014/03/IMG_4905-e1552467791516.jpg",
    username: "puinam1010",
    password: "123",
    isChecked: false,
    friend: []);

final User mockUser4 = User(
    id: "BG0004",
    firstName: "Lisa",
    lastName: "Lisa",
    phoneNum: "0123120120",
    email: "lisa@example.com",
    profilePic:
        "https://upload.wikimedia.org/wikipedia/commons/c/ce/180819_%EB%B8%94%EB%9E%99%ED%95%91%ED%81%AC_%ED%8C%AC%EC%8B%B8%EC%9D%B8%ED%9A%8C_%EC%BD%94%EC%97%91%EC%8A%A4_%EB%9D%BC%EC%9D%B4%EB%B8%8C%ED%94%84%EB%9D%BC%EC%9E%90_%EB%A6%AC%EC%82%AC.jpg",
    username: "lisa0131",
    password: "123",
    isChecked: false,
    friend: []);

final User mockUser5 = User(
    id: "BG0005",
    firstName: "Luo",
    lastName: "Zhi Hao",
    phoneNum: "0131012310",
    email: "abdul@example.com",
    profilePic:
        "https://weilamanner.com/wp-content/uploads/2017/03/Sixtycents.jpg",
    username: "sixtycent",
    password: "123",
    isChecked: false,
    friend: []);

final User mockUser6 = User(
    id: "BG0006",
    firstName: "Jennie",
    lastName: "BlackPink",
    phoneNum: "014522222",
    email: "jennie@example.com",
    profilePic:
        "https://media.malaymail.com/uploads/articles/2020/2020-01/1501_jennie_image.png",
    username: "jennie520",
    password: "123",
    isChecked: false,
    friend: []);

final User mockUser7 = User(
    id: "BG0007",
    firstName: "Jeffrey",
    lastName: "Fok",
    phoneNum: "014784554",
    email: "jeffrey@example.com",
    profilePic:
        "https://weilamanner.com/wp-content/uploads/2014/03/399776249949001879.jpg",
    username: "jeffrey002",
    password: "123",
    isChecked: false,
    friend: []);

final User mockUser8 = User(
    id: "BG0008",
    firstName: "Hou",
    lastName: "Dee",
    phoneNum: "014287855",
    email: "houdee@example.com",
    profilePic:
        "https://weilamanner.com/wp-content/uploads/2014/03/69565572756834353.jpg",
    username: "houdee11",
    password: "123",
    isChecked: false,
    friend: []);

final User mockUser9 = User(
    id: "BG0009",
    firstName: "Doris",
    lastName: "Duo",
    phoneNum: "014845554",
    email: "doris@example.com",
    profilePic:
        "https://weilamanner.com/wp-content/uploads/2014/03/770807231652212499.jpg",
    username: "doris002",
    password: "123",
    isChecked: false,
    friend: []);

final User mockUser10 = User(
    id: "BG0010",
    firstName: "Rachel",
    lastName: "Lau",
    phoneNum: "0125412214",
    email: "rachel@example.com",
    profilePic:
        "https://weilamanner.com/wp-content/uploads/2014/03/55880639554661888.jpg",
    username: "rachel",
    password: "123",
    isChecked: false,
    friend: []);

List<User> memberMockData = [
  mockUser1,
  mockUser2,
  mockUser3,
  mockUser4,
  mockUser5,
  mockUser6,
  mockUser7,
  mockUser8,
  mockUser9,
  mockUser10,
  mockOwnUser
];

List<User> loginData = [
  mockOwnUser,
  mockUser1,
  mockUser2,
  mockUser3,
  mockUser4,
  mockUser5
];
final mockdata = [
  //Trip #1
  Trips(
      1,
      "Japan",
      "Honey Moon",
      mockOwnUser,
      memberMockData,
      DateTime(2020, 10, 10),
      DateTime(2020, 10, 15),
      [],
      [],
      DateTime.now(),
      "JPY",
      "upcoming"),

  //Trip #2
  Trips(
      2,
      "Canada",
      "See polar bear",
      mockOwnUser,
      memberMockData,
      DateTime(2020, 4, 10),
      DateTime(2020, 5, 20),
      [
        Schedule(
            '1',
            DateTime(2020, 4, 10, 8),
            DateTime(2020, 4, 10, 11),
            "Rocky Mountains Summer Explorer",
            "Mountain at Vancouver",
            mockUser2,
            DateTime(2020, 3, 8, 8)),
        Schedule(
            '1',
            DateTime(2020, 4, 11, 11),
            DateTime(2020, 4, 11, 20),
            "Discover Vancouver Island",
            "The special island in Canada",
            mockUser3,
            DateTime(2020, 3, 9, 8)),
        Schedule(
            '1',
            DateTime(2020, 4, 12, 8),
            DateTime(2020, 4, 12, 23),
            "Banff National Park",
            "Chance to explore Banff at your own pace, as there are no formal activities planned. Established in 1885, Banff is the oldest national park in the country, and contains over 1600 kilometres (995 miles) of hiking trails.",
            mockUser1,
            DateTime(2020, 3, 11, 12))
      ],
      [
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Mc Donald",
            "Lunch",
            "Food & Beverage",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Kindergarden Hotel",
            "Day 1",
            "Accommodation",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "DisneyLand",
            "DisneyLand ticket",
            "Entertainment",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Souvenir",
            "Key chain",
            "Others",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
      ],
      DateTime.now(),
      "USD",
      "upcoming"),
  Trips(
      3,
      "Russia",
      "Eat Polar BEar",
      mockOwnUser,
      memberMockData,
      DateTime(2020, 7, 10),
      DateTime(2020, 10, 15),
      [
        Schedule(
            '1',
            DateTime(2020, 4, 10, 8),
            DateTime(2020, 4, 10, 11),
            "Rocky Mountains Summer Explorer",
            "Mountain at Vancouver",
            mockUser2,
            DateTime(2020, 3, 8, 8)),
        Schedule(
            '1',
            DateTime(2020, 4, 11, 11),
            DateTime(2020, 4, 11, 20),
            "Discover Vancouver Island",
            "The special island in Canada",
            mockUser3,
            DateTime(2020, 3, 9, 8)),
        Schedule(
            '1',
            DateTime(2020, 4, 12, 8),
            DateTime(2020, 4, 12, 23),
            "Banff National Park",
            "Chance to explore Banff at your own pace, as there are no formal activities planned. Established in 1885, Banff is the oldest national park in the country, and contains over 1600 kilometres (995 miles) of hiking trails.",
            mockUser1,
            DateTime(2020, 3, 11, 12))
      ],
      [
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Mc Donald",
            "Lunch",
            "Food & Beverage",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Kindergarden Hotel",
            "Day 1",
            "Accommodation",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "DisneyLand",
            "DisneyLand ticket",
            "Entertainment",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Souvenir",
            "Key chain",
            "Others",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
      ],
      DateTime.now(),
      "USD",
      "progress"),
  //trips 4
  Trips(
      4,
      "Singapore",
      "marina bayy",
      mockOwnUser,
      memberMockData,
      DateTime(2020, 2, 10),
      DateTime(2020, 2, 20),
      [
        Schedule(
            '1',
            DateTime(2020, 4, 10, 8),
            DateTime(2020, 4, 10, 11),
            "Rocky Mountains Summer Explorer",
            "Mountain at Vancouver",
            mockUser2,
            DateTime(2020, 3, 8, 8)),
        Schedule(
            '1',
            DateTime(2020, 4, 11, 11),
            DateTime(2020, 4, 11, 20),
            "Discover Vancouver Island",
            "The special island in Canada",
            mockUser3,
            DateTime(2020, 3, 9, 8)),
        Schedule(
            '1',
            DateTime(2020, 4, 12, 8),
            DateTime(2020, 4, 12, 23),
            "Banff National Park",
            "Chance to explore Banff at your own pace, as there are no formal activities planned. Established in 1885, Banff is the oldest national park in the country, and contains over 1600 kilometres (995 miles) of hiking trails.",
            mockUser1,
            DateTime(2020, 3, 11, 12))
      ],
      [
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Mc Donald",
            "Lunch",
            "Food & Beverage",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Kindergarden Hotel",
            "Day 1",
            "Accommodation",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "DisneyLand",
            "DisneyLand ticket",
            "Entertainment",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Souvenir",
            "Key chain",
            "Others",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
      ],
      DateTime.now(),
      "USD",
      "upcoming"),
  Trips(
      5,
      "USA",
      "NBA",
      mockOwnUser,
      memberMockData,
      DateTime(2020, 10, 10),
      DateTime(2020, 10, 15),
      [
        Schedule(
            '1',
            DateTime(2020, 4, 10, 8),
            DateTime(2020, 4, 10, 11),
            "Rocky Mountains Summer Explorer",
            "Mountain at Vancouver",
            mockUser2,
            DateTime(2020, 3, 8, 8)),
        Schedule(
            '1',
            DateTime(2020, 4, 11, 11),
            DateTime(2020, 4, 11, 20),
            "Discover Vancouver Island",
            "The special island in Canada",
            mockUser3,
            DateTime(2020, 3, 9, 8)),
        Schedule(
            '1',
            DateTime(2020, 4, 12, 8),
            DateTime(2020, 4, 12, 23),
            "Banff National Park",
            "Chance to explore Banff at your own pace, as there are no formal activities planned. Established in 1885, Banff is the oldest national park in the country, and contains over 1600 kilometres (995 miles) of hiking trails.",
            mockUser1,
            DateTime(2020, 3, 11, 12))
      ],
      [
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Mc Donald",
            "Lunch",
            "Food & Beverage",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Kindergarden Hotel",
            "Day 1",
            "Accommodation",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "DisneyLand",
            "DisneyLand ticket",
            "Entertainment",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Souvenir",
            "Key chain",
            "Others",
            formatDate(DateTime.now(), [yy, '-', M, '-', d]),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
      ],
      DateTime.now(),
      "USD",
      "progress")
];

// void initMock() {
//   mockUser1.friends = [mockUser2, mockUser3, mockUser4, mockUser5];
// }

final loggedInUser = mockOwnUser;
