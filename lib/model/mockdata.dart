import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';

final User mockOwnUser = User(
    "01",
    "Barack",
    "Obama",
    "0123123123",
    "john@example.com",
    "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fjvchamary%2Ffiles%2F2016%2F03%2Fman_of_steel-1200x800.jpg",
    "obama123",
    "123",
    false, [
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
    "BG0001",
    "Angelababy",
    "Liss",
    "0123321012",
    "angela@example.com",
    "https://img01.cp.aliimg.com/imgextra/i3/832716541/T2DkrxXg4XXXXXXXXX_!!832716541.jpg",
    "angela0210",
    "123",
    false, []);

final User mockUser2 = User(
    "BG0002",
    "Su",
    "Lin",
    "0123123123",
    "sulin@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/150164784159860977.jpg",
    "sulin002",
    "123",
    false, []);

final User mockUser3 = User(
    "BG0003",
    "Pui",
    "Nam",
    "0123210121",
    "puinam@example.com",
    "https://scontent-sin6-1.cdninstagram.com/v/t51.2885-19/s320x320/52268850_827504630935196_3492057558405873664_n.jpg?_nc_ht=scontent-sin6-1.cdninstagram.com&_nc_ohc=9Vw429d0VuIAX-GbUs4&oh=4809307f73461b51334eb949860d2884&oe=5EB3D031",
    "puinam1010",
    "123",
    false, []);

final User mockUser4 = User(
    "BG0004",
    "Lisa",
    "Lisa",
    "0123120120",
    "lisa@example.com",
    "https://upload.wikimedia.org/wikipedia/commons/c/ce/180819_%EB%B8%94%EB%9E%99%ED%95%91%ED%81%AC_%ED%8C%AC%EC%8B%B8%EC%9D%B8%ED%9A%8C_%EC%BD%94%EC%97%91%EC%8A%A4_%EB%9D%BC%EC%9D%B4%EB%B8%8C%ED%94%84%EB%9D%BC%EC%9E%90_%EB%A6%AC%EC%82%AC.jpg",
    "lisa0131",
    "123",
    false, []);

final User mockUser5 = User(
    "BG0005",
    "Luo",
    "Zhi Hao",
    "0131012310",
    "abdul@example.com",
    "https://weilamanner.com/wp-content/uploads/2017/03/Sixtycents.jpg",
    "sixtycent",
    "123",
    false, []);

final User mockUser6 = User(
    "BG0006",
    "Jennie",
    "BlackPink",
    "014522222",
    "jennie@example.com",
    "https://media.malaymail.com/uploads/articles/2020/2020-01/1501_jennie_image.png",
    "jennie520",
    "123",
    false, []);

final User mockUser7 = User(
    "BG0007",
    "Jeffrey",
    "Fok",
    "014784554",
    "jeffrey@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/399776249949001879.jpg",
    "jeffrey002",
    "123",
    false, []);

final User mockUser8 = User(
    "BG0008",
    "Hou",
    "Dee",
    "014287855",
    "houdee@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/69565572756834353.jpg",
    "houdee11",
    "123",
    false, []);

final User mockUser9 = User(
    "BG0009",
    "Doris",
    "Duo",
    "014845554",
    "doris@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/770807231652212499.jpg",
    "doris002",
    "123",
    false, []);

final User mockUser10 = User(
    "BG0010",
    "Rachel",
    "Lau",
    "0125412214",
    "rachel@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/55880639554661888.jpg",
    "rachel",
    "123",
    false, []);

List<User> memberMockData = [
  mockUser1,
  mockUser2,
  mockUser3,
  mockUser4,
  mockUser5,
  mockUser9,
  mockUser10,
  mockUser7,
  mockUser8
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
      [
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now())
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
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now())
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
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now())
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
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now())
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
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 10, 10, 8), DateTime(2020, 10, 10, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now())
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

final loggedInUser = mockUser2;
