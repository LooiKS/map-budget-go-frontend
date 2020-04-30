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

class TripsCreatePage extends StatefulWidget {
  @override
  _TripsCreateState createState() => _TripsCreateState();
}

class _TripsCreateState extends State<TripsCreatePage> {
    String _inputCurrency ;
    String holder;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  
  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Trip",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        shape: CustomShapeBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // buildCategoryTitle("Members"),
            // tripMemberList(
            //     widget._tripData.memberUser, widget._tripData.ownerUser),
            SizedBox(height: 10.0),
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

  Container buildTripForm() {
     DateTime _dateStart ;
     DateTime _dateEnd ;
    
    TextEditingController _tripName = TextEditingController();
    TextEditingController _tripLocation = TextEditingController();
     final dateInputFormat = DateFormat("dd-MM-yyyy");
    
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0) ,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Trip Name "),
              onSaved: (value) {
              _tripName.text = value;
            },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Trip Location "),
              onSaved: (value) {
              _tripLocation.text = value;
            },
            ),
            DateTimeField(
            format: dateInputFormat,
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
            //controller: _endDate,
            decoration: InputDecoration(labelText: 'End Date',hintText: ('dd-mm-yyyy')), 
            onShowPicker: (context, _dateEnd) {
              return showDatePicker(
                context: context, 
                initialDate: _dateEnd ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
            },
            onSaved: (value){
              setState(() {
                if (value !=null){
              _dateEnd = value;
                }
              });
          },
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: "Currency",contentPadding:const EdgeInsets.fromLTRB(0, 13, 0, 0) ),
            items: currency.map((value) {
              return DropdownMenuItem<String>(
                  child: Text(value), 
                  value: value);
            }).toList(),
            value: _inputCurrency  ,
            onChanged: (newValue) {
              setState(() {
                print(newValue);
                _inputCurrency = newValue;
                print(_inputCurrency);
              });
            },
          ),
        //   FormField<String>(
        //     builder: (FormFieldState<String> state) {
        //     return InputDecorator(
        //       decoration: InputDecoration(
        //        // icon: const Icon(Icons.color_lens),
        //         labelText: 'Currency',
        //       ),
        //      // isEmpty: _color == '',
        //       child: new DropdownButtonHideUnderline(
        //         child: new DropdownButton<String>(
        //           value: _inputCurrency,
        //          // isDense: true,
        //           onChanged: (String newValue) {
        //             setState(() {
        //               //newContact.favoriteColor = newValue;
        //               _inputCurrency = newValue;
        //               state.didChange(newValue);
        //             });
        //           },
        //           items: currency.map((String value) {
        //             return new DropdownMenuItem<String>(
        //               value: value,
        //               child: new Text(value),
        //             );
        //           }).toList(),
        //         ),
        //       ),
        //     );
        //   },
        // ),
          // DropdownButtonFormField<String>(
          //     value: _inputCurrency,
          //     decoration: InputDecoration(labelText: 'Currency',hintText: ('Currency'),enabledBorder: UnderlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white))),
          //     elevation: 16,            
          //     onChanged: (String value) {
          //       setState(() => _inputCurrency = value);
          //     },
          //     items: currency.map((String cur) {
          //       return DropdownMenuItem<String>(
          //         value: cur,
          //         child: Text(cur),
          //       );
          //     }).toList(),
              
          //   ),
          RaisedButton(
              onPressed: (){
                if (_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  setState(() {
                    _formKey.currentState.save();
                    print(_inputCurrency);
                    Trips _newTrip = new Trips(Users("najib","https://i.pinimg.com/736x/5a/0c/7b/5a0c7b76e2a8bcdbe571c5ba916f93fe.jpg",false), [], _tripName.text, _tripLocation.text, _dateStart, _dateEnd, [], [], DateTime.now(), _inputCurrency);
                    print(_newTrip.currency);
                    Navigator.pop(context, _newTrip);
                  });
                  
                }
              },
              child: Text('Submit'),)
          ],
        ),
      )
    );
  }
}

