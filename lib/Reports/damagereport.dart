import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'StatusScreen.dart';

class DamageReport extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DamageReport',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReportForm(),
    );
  }
}

class ReportForm extends StatelessWidget {

  _button(text) => RaisedButton(
      onPressed: (){},
      textColor: Colors.white,
      color: Colors.deepPurple,
      
      child: new Text(
        text,
        style: TextStyle(fontFamily: 'RobotoMono'),
      ),
        
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(),
          child: Container(
            child: Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.1,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5.0,
                        top: 5.0, left: 10.0),
                        child: Text(
                            "Report Damages",
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*0.5,),
                      Container(
                        child: Row(children: <Widget>[
                          _button("Issued Items"),
                          SizedBox(width: 20.0,),
                          _button("log Out")
                        ],)
                      )
                    ],),
                  ),
                  )
              ),

              Form(),
            ],)
          )
        )
    );
  }
}

class Form extends StatefulWidget {
  Form({Key key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {

TextEditingController itemID = new TextEditingController();
TextEditingController condition = new TextEditingController();
TextEditingController labID = new TextEditingController();
TextEditingController date = new TextEditingController();
var msg = "";

Future _executionStatus(result, context){
  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatusScreen(text:result),
                ),
              );
}

Future _submit(context) async {
  print(itemID.text);
  print(condition.text);
  print(labID.text);
  print(date.text);
    http.Response response = await http.post("http://labheadsbase.000webhostapp.com/damageReport.php",
    body: {
      "itemID": itemID.text,
      "condition": condition.text,
      "labID": labID.text,
      "date": date.text,
    });

    var data = response.body;
    _executionStatus(data, context);

  }

  _inputBox(context, text, TextEditingController controllerName) => Container(
        width: MediaQuery.of(context).size.width*0.25,
        child:   TextFormField(
        controller: controllerName,
        decoration: InputDecoration(
          labelText: text,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(18.0),
            borderSide: new BorderSide())),
        style: TextStyle(color: Colors.blueAccent, fontSize: 14.0),
      ),
);

_button(text, context) => RaisedButton(
      onPressed: (){
        _submit(context);
      },
      textColor: Colors.white,
      color: Colors.deepPurple,
      
      child: new Text(
        text,
        style: TextStyle(fontFamily: 'RobotoMono'),
      ),
        
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.8,
      padding: EdgeInsets.only(bottom: 5.0,
                        top: 5.0, left: 20.0),
      color: Colors.black12,
      child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         
         children: [
          Container(
            child: Row(
              children:[
                Text("Item ID",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16.0),
                ),
                SizedBox(width: 45),
                _inputBox(context, "Item ID", itemID),
              ]
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children:[
                Text("Condition",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16.0),),
                SizedBox(width: 30),
                _inputBox(context, "What is the condition of the item?", condition),
              ]
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children:[
                Text("Lab ID",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16.0),),
                SizedBox(width: 55),
                _inputBox(context, "Lab ID", labID),
              ]
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children:[
                Text("Date",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16.0),),
                SizedBox(width: 65),
                _inputBox(context, "Enter the date", date),
              ]
            ),
          ),
          SizedBox(height: 10),
          _button("Submit Report", context)
         ],
       ),
    );
  }
}