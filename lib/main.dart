import 'package:flutter/material.dart';
import 'dart:math';

void main(){
  runApp(EmiCalculator());
}

class EmiCalculator extends StatefulWidget {
  @override
  _EmiCalculatorState createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> {

  String emiResultValue = "";
  bool switchState = true;
  List _tenureTypes = [' Month(s)', 'Year(s)' ];
  String _tenureType = "Year(s)";

  // Text Filed Elements
  final TextEditingController principalAmount = TextEditingController();
  final TextEditingController interestRate = TextEditingController();
  final TextEditingController tenurePeriod = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: Text("Emi Calculator"),
          elevation: 1.0,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
                  child: Container(
                    child: TextField(
                      controller: principalAmount,
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Enter the Principle Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        suffixIcon: Icon(
                          Icons.account_balance,
                          color: Colors.deepPurple[400],
                        )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 20.0),
                  child: Container(
                    child: TextField(
                      controller: interestRate,
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      decoration: InputDecoration(
                        labelText: "Interest Rate",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: Icon(
                          Icons.attach_money,
                          color: Colors.deepPurple[400],
                        )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 20.0),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 10.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: TextField(
                              controller: tenurePeriod,
                              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                              decoration: InputDecoration(
                                labelText: "Tenure",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                suffixIcon: Icon(
                                  Icons.timeline,
                                  color: Colors.deepPurple[400],
                                )
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  _tenureType,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Switch(
                                  value: switchState,
                                  activeColor: Colors.deepPurple[400],
                                  onChanged: (bool value){
                                    print(value);

                                    if(value){
                                      _tenureType = _tenureTypes[1];
                                    }else{
                                      _tenureType = _tenureTypes[0];
                                    }
                                    setState(() {
                                      switchState = value;
                                    });
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: FlatButton(
                    onPressed: (){
                      calculateEmi();
                    },
                    child: Text("Calculate"),
                    color: Colors.deepPurple[400],
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
                  ),
                ),
                emiResult(emiResultValue),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emiResult(result){

    bool resultShow = false;
    String resultValue = result;
    if(resultValue.length > 0){
      resultShow = true;
    }
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: resultShow ? Column(
        children: <Widget>[
          Text("Your Monthly EMI Amount is: ",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          Container(
            child: Text(
              result,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )

        ],
      ) : Container(),
    );
  }

  void calculateEmi(){
    double A = 0.0;

    double P = double.parse(principalAmount.text);
    double r = double.parse(interestRate.text) / 12 / 100;
    int n = _tenureType == "Year(s)" ? int.parse(tenurePeriod.text) * 12  : int.parse(tenurePeriod.text);

    A = (P * r * pow((1+r), n) / ( pow((1+r),n) -1));

    emiResultValue = A.toStringAsFixed(2);

    setState(() {

    });
  }
}
