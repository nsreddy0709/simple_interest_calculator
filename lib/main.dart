import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIStateForm();
  }
}

class _SIStateForm extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ["Dollars", "Rupees", "Pounds", "others"];
  final _minpadding = 5.0;
  var _currentitemselected = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentitemselected = _currencies[0];
  }

  TextEditingController principalcontroller = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController periodcontroller = TextEditingController();
  var display_result = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(_minpadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: principalcontroller,
                        validator: (String value){
                          if(value.isEmpty){
                            return 'Please enter principal amount';
                          }
                          else if(value != TextInputType.number){
                            return 'Invalid input';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Principal',
                            hintText: 'Enter Principal amount eg.12000',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )))),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roicontroller,
                      validator: (String value){
                        if(value.isEmpty)
                          {
                            return "Please enter ROI";
                          }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of interest',
                          hintText: 'In percentage eg 8',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: periodcontroller,
                          validator: (String value){
                            if(value.isEmpty){
                              return "Please enter time period";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Period',
                              hintText: 'Time in years',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                        Container(width: _minpadding * 5),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentitemselected,
                          onChanged: (String newvalue) {
                            _onDropDownItemSelected(newvalue);
                          },
                        ))
                      ],
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            'Calculate',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if(_formkey.currentState.validate()){
                                this.display_result = _calculateTotalResult();
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minpadding * 2),
                  child: Text(
                    this.display_result,
                    style: textStyle,
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.jpeg');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minpadding * 5),
    );
  }

  void _onDropDownItemSelected(newvalue) {
    setState(() {
      this._currentitemselected = newvalue;
    });
  }

  String _calculateTotalResult() {
    double principal = double.parse(principalcontroller.text);
    double roi = double.parse(roicontroller.text);
    double period = double.parse(periodcontroller.text);
    double amount = principal + (principal * roi * period) / 100;
    String result =
        "After $period , the investment will be $amount $_currentitemselected";
    return result;
  }

  void _reset() {
    principalcontroller.text = '';
    roicontroller.text = '';
    periodcontroller.text = '';
    display_result = '';
    _currentitemselected = _currencies[0];
  }
}
