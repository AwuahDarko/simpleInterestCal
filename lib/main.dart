import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AwuahDarko',
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      brightness: Brightness.dark,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Cedis', 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currentItemSelected = "Cedis";
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var displayResults = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Yaw Awuah Darko"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: ListView(
                children: <Widget>[
                  getImageAsset(),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter principal Amount";
                        }
                      },
                      controller: principalController,
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          labelStyle: textStyle,
                          labelText: "Principal",
                          hintText: "Enter Principal e.g. 12000",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter Interest rate";
                        }
                      },
                      controller: roiController,
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          labelStyle: textStyle,
                          labelText: "Rate of Interest",
                          hintText: "In percent",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: _minimumPadding, bottom: _minimumPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter the term in years";
                              }
                            },
                            controller: termController,
                            style: textStyle,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 15.0,
                                ),
                                labelStyle: textStyle,
                                labelText: "Term",
                                hintText: "Time in years",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                          )),
                          Container(width: _minimumPadding * 5),
                          Expanded(
                              child: DropdownButton<String>(
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _currentItemSelected,
                            onChanged: (String newValueSelected) {
                              _onDropDownItemSelected(newValueSelected);
                            },
                          ))
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: _minimumPadding, top: _minimumPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: RaisedButton(
                                  color: Theme.of(context).accentColor,
                                  child: Text("Calculate"),
                                  textColor: Theme.of(context).primaryColorDark,
                                  onPressed: () {
                                    setState(() {
                                      if (_formKey.currentState.validate()) {
                                        displayResults =
                                            _calculateTotalReturns();
                                      }
                                    });
                                  })),
                          Expanded(
                              child: RaisedButton(
                                  color: Theme.of(context).primaryColorDark,
                                  textColor:
                                      Theme.of(context).primaryColorLight,
                                  child: Text("Reset"),
                                  onPressed: () {
                                    setState(() {
                                      _reset();
                                    });
                                  })),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(_minimumPadding * 2),
                    child: Text(displayResults),
                  )
                ],
              )),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 150.0,
    );
    return Container(
      child: image,
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        "After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected";
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResults = "";
    _currentItemSelected = _currencies[0];
  }
}
