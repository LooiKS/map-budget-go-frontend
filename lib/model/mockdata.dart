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
    "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640",
    "obama123",
    "123",
    false);


final User mockUser1 = User(
    "BG0001",
    "John",
    "Aburqueque",
    "0123123123",
    "john@example.com",
    "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640",
    "john0102",
    "123",
    false);

final User mockUser2 = User(
    "BG0002",
    "Angelababy",
    "Liss",
    "0123321012",
    "angela@example.com",
    "https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg",
    "angela0210",
    "123",
    false);

final User mockUser3 = User(
    "BG0003",
    "Kenny",
    "Koo",
    "0123210121",
    "kenny@example.com",
    "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640",
    "kenny1010",
    "123",
    false);

final User mockUser4 = User(
    "BG0004",
    "Lisa",
    "Mandy",
    "0123120120",
    "lisa@example.com",
    "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640",
    "lisa0131",
    "123",
    false);

final User mockUser5 = User(
    "BG0005",
    "Abdul",
    "Nasir",
    "0131012310",
    "abdul@example.com",
    "https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg",
    "abdul0130",
    "123",
    false);
List<User> userMockData = [
  mockUser1,
  mockUser2,
  mockUser3,
  mockUser4,
  mockUser5
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
      "Japan",
      "Honey Moon",
      mockOwnUser,
      [mockUser2, mockUser3],
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
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
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
      "Canada",
      "See polar bear",
      mockOwnUser,
      [mockUser4, mockUser5],
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
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
      ],
      DateTime.now(),
      "USD",
      "upcoming"),
  Trips(
      "Russia",
      "Eat Polar BEar",
      mockOwnUser,
      [mockUser2, mockUser3],
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
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
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
      "Singapore",
      "marina bayy",
      mockOwnUser,
      [mockUser4, mockUser5],
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
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
      ],
      DateTime.now(),
      "USD",
      "upcoming"),
  Trips(
      "USA",
      "NBA",
      mockOwnUser,
      [mockUser2, mockUser3],
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
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            "Train ticket",
            "Train to Busan",
            "Transport",
            DateTime.now().toString(),
            250.00,
            mockUser2,
            mockUser2,
            [mockUser1, mockUser2, mockUser3]),
      ],
      DateTime.now(),
      "USD",
      "progress")
];
