import 'package:flutter/material.dart';

class TripMemberList extends StatelessWidget {
  final Function(String) onTap;
  const TripMemberList({Key key, this.onTap}) : super(key: key);

  final List<String> members = const ["John", "Maria"];
  final List<String> image = const [
    "https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg",
    "https://cdn141.picsart.com/280218394017211.png?type=webp&to=min&r=640"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: members.length + 1,
        itemBuilder: (context, index) {
          return index != members.length
              ? buildMemberAvatar(index)
              : buildAddMemberButton();
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }

  GestureDetector buildAddMemberButton() {
    return GestureDetector(
      onTap: () {},
      child: Column(children: <Widget>[
        ClipOval(
          child: Icon(
            Icons.add_circle,
            size: 40.0,
            color: Colors.green,
          ),
        ),
      ]),
    );
  }

  GestureDetector buildMemberAvatar(int index) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          ClipOval(
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image: image[index],
              fit: BoxFit.contain,
              width: 30.0,
              height: 30.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            members[index],
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
