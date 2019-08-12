import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest",
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIForm();
  }
}

class _SIForm extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  final minpadding = 5.0;
  var _currencies = ["Naira", "Dollars", "Ponds"];
  var _currentSelectedItem = '';
  TextEditingController principalController = TextEditingController();
  TextEditingController termsController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  String InvesmentResult = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentSelectedItem = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest"),
      ),
      // resizeToAvoidBottomPadding: false,
      body: Form(
         key: _formkey,
          child: Padding(
              padding: EdgeInsets.all(minpadding * 2),
              child: ListView(
                children: <Widget>[
                  getImageAsset(),
                  getPrincipalField(),
                  getRateField(),
                  Padding(
                      padding:
                          EdgeInsets.only(top: minpadding, bottom: minpadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                            style: textStyle,
                            controller: termsController,
                            keyboardType: TextInputType.number,
                                validator: (String rateValue){
                                  if(rateValue.isEmpty)
                                  {
                                    return "kindly input valid Rate value i.e 1-100";
                                  }
                                },
                            decoration: InputDecoration(
                                labelText: "Term",
                                labelStyle: textStyle,
                                hintText: "Term in Years",
                                errorStyle: TextStyle(color: Colors.yellowAccent),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                          Container(
                            width: minpadding * 5,
                          ),
                          Expanded(
                              child: DropdownButton<String>(
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _currentSelectedItem,
                            onChanged: (String newValueSelected) {
                              _onDropDown(newValueSelected);
                            },
                          )),
                        ],
                      )),
                  Padding(
                    padding:
                        EdgeInsets.only(top: minpadding, bottom: minpadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                "Calculate",
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  if(_formkey.currentState.validate()) {
                                    this.InvesmentResult = _onCalculate();
                                  }
                                });
                              }),
                        ),
                        Container(width: minpadding),
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                "Reset",
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _resetFunction();
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                  Text(InvesmentResult),
                ],
              ))),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/simpleinterest.png");
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
        child: image,
        padding: EdgeInsets.all(
          minpadding * 10,
        ));
  }

  Widget getPrincipalField() {
    return Padding(
      padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (String principalValue){
          if(principalValue.isEmpty)
            {
              return "kindly input principal amount";
            }
        },
        controller: principalController,
        decoration: InputDecoration(
            labelText: "Principal",
            hintText: "Amount upto N20000000",
            errorStyle: TextStyle(color: Colors.yellowAccent),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      ),
    );
  }

  Widget getRateField() {
    return Padding(
      padding: EdgeInsets.only(top: minpadding, bottom: minpadding),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (String rateValue){
          if(rateValue.isEmpty)
          {
            return "kindly input valid Rate value i.e 1-100";
          }
        },
        controller: roiController,
        decoration: InputDecoration(
            labelText: "Rate of Invesment",
            hintText: "Rate upto 1 - 100",
            errorStyle: TextStyle(color: Colors.yellowAccent),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      ),
    );
  }

  void _onDropDown(newValueSelected) {
    setState(() {
      this._currentSelectedItem = newValueSelected;
    });
  }

  String _onCalculate() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    int term = int.parse(termsController.text);

    double interest = (principal * term * roi) / 100;
    return "After $term years, you Investment will be $interest $_currentSelectedItem";
  }

  void _resetFunction() {
    roiController.text = '';
    termsController.text = '';
    principalController.text = '';
    _currentSelectedItem = _currencies[0];
    InvesmentResult = '';
  }
}
