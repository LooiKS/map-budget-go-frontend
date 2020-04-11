import 'package:flutter/material.dart';

class TripMemberList extends StatelessWidget {
  final Function(String) onTap;
  const TripMemberList({Key key, this.onTap}) : super(key: key);

  final List<String> dummyMembers = const ["John", "Maria"];
  final List<String> dummyImage = const [
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
        itemCount: dummyMembers.length + 1,
        itemBuilder: (context, index) {
          return buildMemberAvatar(index);
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }

  GestureDetector buildMemberAvatar(int index) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          index != 2
              ? ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: dummyImage[index],
                    fit: BoxFit.contain,
                    width: 30.0,
                    height: 30.0,
                  ),
                )
              : ClipOval(
                  child: Icon(
                    Icons.add_circle,
                    size: 30.0,
                    color: Colors.green,
                  ),
                ),
          const SizedBox(height: 5.0),
          Text(
            index != 2 ? dummyMembers[index] : "Add",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
