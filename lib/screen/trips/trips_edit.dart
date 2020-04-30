// import 'package:budgetgo/constant/currency.dart';
import 'package:budgetgo/constant/currency.dart';
import 'package:budgetgo/model/mock_data.dart';
import 'package:budgetgo/model/trip.dart';
import 'package:budgetgo/model/trip_expenses_class.dart';
import 'package:budgetgo/model/trips_class.dart';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/screen/trips/trips_users_edit.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widget/custom_shape.dart';
import './trips_member_list.dart';
import '../../main.dart';

class TripsEdit extends StatefulWidget {
  final Trips _tripData;

  TripsEdit(this._tripData);
  
  @override
  _TripsEditState createState() => _TripsEditState();
}

class _TripsEditState extends State<TripsEdit> {
  List<Users> memberList = [];
  List<Users> tempUsers = [];
  String _inputCurrency ;
 // String _tempCurrency = _tripData.currency;
   

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
 void _navigateEditFriend() async {
   List<Users> returnData = await Navigator.push( 
      context,
      //Trips.copy(widget.tripsData[index])
      MaterialPageRoute(builder: (context) => EditUserList(usersMockData,Users.copy(widget._tripData.ownerUser))),
    );
     if (returnData != null){
       tempUsers.clear();
       for (int c = 0;c<returnData.length;c++){
          if (returnData[c].isChecked==true){
            print(returnData[c].userName);
          tempUsers.add(returnData[c]);
          }
        }

        print("tempuser");

        print(tempUsers.length); 
       setState(() =>  widget._tripData.memberUser = tempUsers);
        print("widget");
        print(widget._tripData.memberUser.length);
        memberList.clear();
        memberList.add(widget._tripData.ownerUser);
        memberList.addAll(widget._tripData.memberUser);
     }
    }
  List<Trips> dummyTrip = <Trips>[];
  List<TripExpenses> dummyExpenses = <TripExpenses>[];

  //_TripsDetailState(Trips tripData);

  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Trip",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          PopupMenuButton(
            onSelected: (value) {
              // setState(() {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             TripsDetail(Trips.copy(widget._tripData))),
              //   );
              //   print(value);
              // });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text("Edit"),
                value: "Edit",
              ),
              PopupMenuItem(
                child: Text("Delete"),
                value: "Delete",
              )
            ],
          ),
        ],
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCategoryTitle("Members"),
            tripMemberList(
                widget._tripData.memberUser, widget._tripData.ownerUser),
            buildCategoryTitle("Trip Information"),
            buildTripForm(),
          ],
        ),
      ),
    );
  }


  Padding buildCategoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }

  Widget tripMemberList(List<Users> userList, Users user) {
    print(userList.length);
    print(widget._tripData.memberUser.length);
    print("userlist");
    return Container(
      height: 70.0,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: userList.length + 2,
        itemBuilder: (context, index) {
          return buildMemberAvatar(index,userList,user,context);
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 10.0,
        ),
      ),
    );
  }
GestureDetector buildMemberAvatar(int index,List<Users> userList, Users user,BuildContext context) {
  //if (memberList.isEmpty==true){
    if (memberList.isEmpty==true){
    memberList.add(user);
    memberList.addAll(userList);
    print(memberList.length);
    print("memberlist");
    }
    print(memberList.length);
    print("memberlist");
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          index != memberList.length 
              ? ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: memberList[index].imageURL,
                    fit: BoxFit.contain,
                    width: 30.0,
                    height: 30.0,
                  ),
                )
              : GestureDetector(
                onTap: (){
                  _navigateEditFriend();
                },
                child: CircleAvatar(
                  radius: 15.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.edit,
                  size: 30.0,
                  color: Colors.green,),
                  
                  ),),
          const SizedBox(height: 5.0),
          Text(
            index != memberList.length ? memberList[index].userName : "Edit",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
}
  Container buildTripForm() {
    DateTime _dateStart = widget._tripData.startDate;
    DateTime _dateEnd = widget._tripData.endDate;
    print(_dateStart);
    print(_dateEnd);

    TextEditingController _tripName = TextEditingController(text: widget._tripData.tripName);
    TextEditingController _tripLocation = TextEditingController(text: widget._tripData.location);
    final dateInputFormat = DateFormat("dd-MM-yyyy");
    DateTime newStartDate = widget._tripData.startDate;  
    String formattedStartDate = DateFormat('dd-MM-yyyy').format(newStartDate);
    DateTime newEndDate = widget._tripData.endDate;  
    String formattedEndDate = DateFormat('dd-MM-yyyy').format(newEndDate);
    TextEditingController _startDate = TextEditingController(text: formattedStartDate);
    TextEditingController _endDate = TextEditingController(text: formattedEndDate);
    //TextEditingController _currency = TextEditingController(text:widget._tripData.currency);
    _inputCurrency = widget._tripData.currency;
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0) ,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _tripName,
              decoration: InputDecoration(labelText: "Trip Name "),
              onSaved: (value) {
              _tripName.text = value;
            },
            ),
            TextFormField(
              controller: _tripLocation,
              decoration: InputDecoration(labelText: "Trip Location "),
              onSaved: (value) {
              _tripLocation.text = value;
            },
            ),
            DateTimeField(
            format: dateInputFormat,
            controller: _startDate,
            decoration: InputDecoration(labelText: 'Start Date',hintText: ('dd-mm-yyyy')), 
            onShowPicker: (context, _dateStart) {
              return showDatePicker(
                context: context, 
                initialDate: _dateStart ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
            },
          onSaved: (value){
            setState(() {
              if (value !=null){
            _dateStart = value;
            }});
          },
          ),
          DateTimeField(
            format: dateInputFormat,
            controller: _endDate,
            decoration: InputDecoration(labelText: 'End Date',hintText: ('dd-mm-yyyy')), 
            onShowPicker: (context, _dateEnd) {
              return showDatePicker(
                context: context, 
                initialDate: _dateStart ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
            },
            onSaved: (value){
              setState(() {
                if (value !=null){
              _dateEnd = value;
              print(_dateEnd);
              print(DateTime.now());
                }
              });
          },
          ),
          DropdownButtonFormField<String>(
              value: _inputCurrency,
              decoration: InputDecoration(labelText: 'Currency',hintText: ('Currency'),contentPadding:const EdgeInsets.fromLTRB(0, 13, 0, 0)),
              elevation: 16,            
              onChanged: (String value) {
                setState(() {
                  widget._tripData.currency = value;
                  _inputCurrency = value; 
                });
              },
              items: currency.map((String cur) {
                return DropdownMenuItem<String>(
                  value: cur,
                  child: Text(cur),
                );
              }).toList(),
              
            ),
          RaisedButton(
              onPressed: (){
                if (_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  setState(() {
                    _formKey.currentState.save();
                    Trips _editTrip = new Trips(Users("najib","https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg",false), widget._tripData.memberUser, _tripName.text, _tripLocation.text, _dateStart, _dateEnd, [], [], DateTime.now(), _inputCurrency);
                    Navigator.pop(context, _editTrip);
            
                  });
                  
                }
              },
              child: Text('Submit'),)
          ],
        ),
      )
      // child: ListView.builder(
      //   shrinkWrap: true,
      //   itemBuilder: (BuildContext ctxt, int index) => Card(
      //     margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      //     child: ListTile(
      //       selected: true,
      //       leading: Container(
      //         width: 48.0,
      //         child: Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             mainAxisSize: MainAxisSize.max,
      //             children: <Widget>[
      //               Icon(
      //                 Icons.calendar_today,
      //                 size: 28.0,
      //               ),
      //               Text(
      //                 "Day ${index + 1}",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                     fontSize: 15.0, fontWeight: FontWeight.bold),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       trailing: Icon(
      //         Icons.keyboard_arrow_right,
      //         size: 30.0,
      //       ),
      //       title: Text(
      //         "asfas",
      //         style: TextStyle(
      //             fontSize: 20.0,
      //             fontWeight: FontWeight.bold,
      //             color: key.currentState.brightness == Brightness.dark
      //                 ? Colors.white
      //                 : Colors.black87),
      //       ),
      //       subtitle: Text(
      //         "sfafas",
      //         style: TextStyle(
      //             fontSize: 15.0,
      //             fontWeight: FontWeight.w300,
      //             color: key.currentState.brightness == Brightness.dark
      //                 ? Colors.white
      //                 : Colors.black54),
      //       ),
      //       onTap: () {},
      //     ),
      //   ),
      //   itemCount: dummyTrip.length,
      // ),
    );
  }

}

