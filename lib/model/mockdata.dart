import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';

final User mockUser1 = User(
    "BG0001",
    "Angelababy",
    "Liss",
    "0123321012",
    "angela@example.com",
    "data:image/jpeg;base64,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",
    "angela0210", [
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

final User mockUser2 = User(
    "BG0002",
    "Su",
    "Lin",
    "0123123123",
    "sulin@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/150164784159860977.jpg",
    "sulin002", []);

final User mockUser3 = User(
    "BG0003",
    "Pui",
    "Nam",
    "0123210121",
    "puinam@example.com",
    "https://scontent-sin6-1.cdninstagram.com/v/t51.2885-19/s320x320/52268850_827504630935196_3492057558405873664_n.jpg?_nc_ht=scontent-sin6-1.cdninstagram.com&_nc_ohc=9Vw429d0VuIAX-GbUs4&oh=4809307f73461b51334eb949860d2884&oe=5EB3D031",
    "puinam1010", []);

final User mockUser4 = User(
    "BG0004",
    "Lisa",
    "Lisa",
    "0123120120",
    "lisa@example.com",
    "https://upload.wikimedia.org/wikipedia/commons/c/ce/180819_%EB%B8%94%EB%9E%99%ED%95%91%ED%81%AC_%ED%8C%AC%EC%8B%B8%EC%9D%B8%ED%9A%8C_%EC%BD%94%EC%97%91%EC%8A%A4_%EB%9D%BC%EC%9D%B4%EB%B8%8C%ED%94%84%EB%9D%BC%EC%9E%90_%EB%A6%AC%EC%82%AC.jpg",
    "lisa0131", []);

final User mockUser5 = User(
    "BG0005",
    "Luo",
    "Zhi Hao",
    "0131012310",
    "abdul@example.com",
    "https://weilamanner.com/wp-content/uploads/2017/03/Sixtycents.jpg",
    "sixtycent", []);

final User mockUser6 = User(
    "BG0006",
    "Jennie",
    "BlackPink",
    "014522222",
    "jennie@example.com",
    "https://media.malaymail.com/uploads/articles/2020/2020-01/1501_jennie_image.png",
    "jennie520", []);

final User mockUser7 = User(
    "BG0007",
    "Jeffrey",
    "Fok",
    "014784554",
    "jeffrey@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/399776249949001879.jpg",
    "jeffrey002", []);

final User mockUser8 = User(
    "BG0008",
    "Hou",
    "Dee",
    "014287855",
    "houdee@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/69565572756834353.jpg",
    "houdee11", []);

final User mockUser9 = User(
    "BG0009",
    "Doris",
    "Duo",
    "014845554",
    "doris@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/770807231652212499.jpg",
    "doris002", []);

final User mockUser10 = User(
    "BG0010",
    "Rachel",
    "Lau",
    "0125412214",
    "rachel@example.com",
    "https://weilamanner.com/wp-content/uploads/2014/03/55880639554661888.jpg",
    "rachel", []);

var mockdata = [
  //Trip #1
  Trips(
      "Japan",
      "Honey Moon",
      mockUser1,
      [mockUser2, mockUser3, mockUser4, mockUser10],
      DateTime(2020, 04, 01),
      DateTime(2020, 04, 03),
      [
        Schedule(DateTime(2020, 04, 01, 8), DateTime(2020, 04, 01, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 04, 02, 8), DateTime(2020, 04, 02, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now()),
        Schedule(DateTime(2020, 04, 03, 8), DateTime(2020, 04, 03, 11),
            "Eat Breakfast", "Search for nice food", mockUser2, DateTime.now())
      ],
      [
        TripExpenses(
          "Train ticket",
          "Train to Busan",
          "Transport",
          // DateTime.now(),
          formatDate(DateTime.now(), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
        TripExpenses(
          "Mc Donalds",
          "Lunch",
          "Food & Beverage",
          // DateTime.now(),
          formatDate(DateTime.now(), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
        TripExpenses(
          "Kindergarden Hotel",
          "Day 1",
          "Accommodation",
          // DateTime.now(),
          formatDate(DateTime.now(), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
        TripExpenses(
          "DisneyLand",
          "DisneyLand ticket",
          "Entertainment",
          // DateTime.now(),
          formatDate(DateTime.now(), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
        TripExpenses(
          "Souvenir",
          "Key chain",
          "Others",
          // DateTime.now(),
          formatDate(DateTime.now(), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
      ],
      DateTime.now(),
      "yen"),

  //Trip #2
  Trips(
      "Korea",
      "Company Trip",
      mockUser1,
      [mockUser2, mockUser3, mockUser9, mockUser6],
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
          // DateTime.now(),
          formatDate(DateTime(2020, 04, 01), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
        TripExpenses(
          "Mc Donalds",
          "Lunch",
          "Food",
          // DateTime.now(),
          formatDate(DateTime(2020, 04, 01), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
        TripExpenses(
          "Kindergarden Hotel",
          "Day 1",
          "Accommodation",
          // DateTime.now(),
          formatDate(DateTime(2020, 04, 01), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
        TripExpenses(
          "DisneyLand",
          "DisneyLand ticket",
          "Entertainment",
          // DateTime.now(),
          formatDate(DateTime(2020, 04, 02), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
        TripExpenses(
          "Souvenir",
          "Key chain",
          "Others",
          // DateTime.now(),
          formatDate(DateTime(2020, 04, 03), [yy, '-', M, '-', d]),
          250.00,
          mockUser2,
          mockUser2,
          [mockUser1, mockUser2, mockUser3],
        ),
      ],
      DateTime.now(),
      "yen")
];

// void initMock() {
//   mockUser1.friends = [mockUser2, mockUser3, mockUser4, mockUser5];
// }

final loggedInUser = mockUser2;
