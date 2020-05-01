import 'package:budgetgo/model/schedule.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';

final User mockUser1 = User(
    "BG0001",
    "John",
    "Aburqueque",
    "0123123123",
    "john@example.com",
    "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640",
    "john0102");

final User mockUser2 = User(
    "BG0002",
    "Angelababy",
    "Liss",
    "0123321012",
    "angela@example.com",
    "https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg",
    "angela0210");

final User mockUser3 = User(
    "BG0003",
    "Kenny",
    "Koo",
    "0123210121",
    "kenny@example.com",
    "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640",
    "kenny1010");

final User mockUser4 = User(
    "BG0004",
    "Lisa",
    "Mandy",
    "0123120120",
    "lisa@example.com",
    "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640",
    "lisa0131");

final User mockUser5 = User(
    "BG0005",
    "Abdul",
    "Nasir",
    "0131012310",
    "abdul@example.com",
    "https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg",
    "abdul0130");

var mockdata = [
  //Trip #1
  Trips(
      "Japan",
      "Honey Moon",
      mockUser1,
      [mockUser2, mockUser3],
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
