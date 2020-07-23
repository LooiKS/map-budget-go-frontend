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
    gender: "123",
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
    gender: "123",
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
    gender: "123",
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
    gender: "123",
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
    gender: "123",
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
    gender: "123",
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
    gender: "123",
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
    gender: "123",
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
    gender: "123",
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
    gender: "123",
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
    gender: "123",
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
      id: "1",
      tripTitle: "Japan",
      tripDetail: "Honey Moon",
      owner: mockOwnUser,
      members: memberMockData,
      startDt: DateTime(2020, 10, 10),
      endDt: DateTime(2020, 10, 15),
      schedules: [],
      expenses: [],
      createdDt: DateTime.now(),
      currency: "JPY",
      status: "upcoming"),

  //Trip #2
  Trips(
      id: "2",
      tripTitle: "Canada",
      tripDetail: "See polar bear",
      owner: mockOwnUser,
      members: memberMockData,
      startDt: DateTime(2020, 4, 10),
      endDt: DateTime(2020, 5, 20),
      schedules: [
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
      expenses: [
        TripExpenses(
            id: "1",
            title: "Train ticket",
            desc: "Train to Busan",
            category: "Transport",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "2",
            title: "Mc Donald",
            desc: "Lunch",
            category: "Food & Beverage",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "3",
            title: "Kindergarden Hotel",
            desc: "Day 1",
            category: "Accommodation",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "4",
            title: "DisneyLand",
            desc: "DisneyLand ticket",
            category: "Entertainment",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "5",
            title: "Souvenir",
            desc: "Key chain",
            category: "Others",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
      ],
      createdDt: DateTime.now(),
      currency: "USD",
      status: "upcoming"),
  Trips(
      id: "3",
      tripTitle: "Russia",
      tripDetail: "Eat Polar BEar",
      owner: mockOwnUser,
      members: memberMockData,
      startDt: DateTime(2020, 7, 10),
      endDt: DateTime(2020, 10, 15),
      schedules: [
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
      expenses: [
        TripExpenses(
            id: "1",
            title: "Train ticket",
            desc: "Train to Busan",
            category: "Transport",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "2",
            title: "Mc Donald",
            desc: "Lunch",
            category: "Food & Beverage",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "3",
            title: "Kindergarden Hotel",
            desc: "Day 1",
            category: "Accommodation",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "4",
            title: "DisneyLand",
            desc: "DisneyLand ticket",
            category: "Entertainment",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "5",
            title: "Souvenir",
            desc: "Key chain",
            category: "Others",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
      ],
      createdDt: DateTime.now(),
      currency: "USD",
      status: "progress"),
  //trips 4
  Trips(
      id: "4",
      tripTitle: "Singapore",
      tripDetail: "marina bayy",
      owner: mockOwnUser,
      members: memberMockData,
      startDt: DateTime(2020, 2, 10),
      endDt: DateTime(2020, 2, 20),
      schedules: [
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
      expenses: [
        TripExpenses(
            id: "1",
            title: "Train ticket",
            desc: "Train to Busan",
            category: "Transport",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "2",
            title: "Mc Donald",
            desc: "Lunch",
            category: "Food & Beverage",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "3",
            title: "Kindergarden Hotel",
            desc: "Day 1",
            category: "Accommodation",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "4",
            title: "DisneyLand",
            desc: "DisneyLand ticket",
            category: "Entertainment",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "5",
            title: "Souvenir",
            desc: "Key chain",
            category: "Others",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
      ],
      createdDt: DateTime.now(),
      currency: "USD",
      status: "upcoming"),
  Trips(
      id: "5",
      tripTitle: "USA",
      tripDetail: "NBA",
      owner: mockOwnUser,
      members: memberMockData,
      startDt: DateTime(2020, 10, 10),
      endDt: DateTime(2020, 10, 15),
      schedules: [
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
      expenses: [
        TripExpenses(
            id: "1",
            title: "Train ticket",
            desc: "Train to Busan",
            category: "Transport",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "2",
            title: "Mc Donald",
            desc: "Lunch",
            category: "Food & Beverage",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "3",
            title: "Kindergarden Hotel",
            desc: "Day 1",
            category: "Accommodation",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "4",
            title: "DisneyLand",
            desc: "DisneyLand ticket",
            category: "Entertainment",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
        TripExpenses(
            id: "5",
            title: "Souvenir",
            desc: "Key chain",
            category: "Others",
            createdDt: DateTime.now(),
            amount: 250.00,
            payBy: mockUser2,
            createdBy: mockUser2,
            sharedBy: [mockUser1, mockUser2, mockUser3]),
      ],
      createdDt: DateTime.now(),
      currency: "USD",
      status: "progress")
];

// void initMock() {
//   mockUser1.friends = [mockUser2, mockUser3, mockUser4, mockUser5];
// }

final loggedInUser = mockOwnUser;
