import 'package:budgetgo/model/user.dart';
import 'package:flutter/material.dart';

class TripMainMemberList extends StatefulWidget {
  //final Function(String) onTap;
  final List<User> members;
  final User user;
  TripMainMemberList(this.members,this.user);

  @override
  _TripMainMemberListState createState() => _TripMainMemberListState();
}

class _TripMainMemberListState extends State<TripMainMemberList> {
  List<User> memberList = <User>[];

  @override
  Widget build(BuildContext context) {
    memberList.clear(); 
    memberList.add(widget.user);
    memberList.addAll(widget.members);
    return Container(
      height: 50.0,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        scrollDirection: Axis.horizontal,
        itemCount: memberList.length + 1,
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
          index != memberList.length 
              ? ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: memberList[index].profilePic,
                    fit: BoxFit.contain,
                    width: 30.0,
                    height: 30.0,
                  ),
                )
              : ClipOval(
                  child: Icon(Icons.more_horiz,
                  size: 30.0,
                    color: Colors.black,),
                
                    //     backgroundColor:
                    //         key.currentState.brightness == Brightness.dark
                    //             ? Colors.white
                    //             : Colors.black54),
                ),
          //const SizedBox(height: 5.0),
          
        ],
      ),
    );
  }
  
}
