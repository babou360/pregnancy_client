import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:pregnancy_tracking_app/Screens/payment/confirm.dart';

class Payment extends StatefulWidget {
  // Payment({Key key, this.title}) : super(key: key);

  // final String title;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "";

  bool isDebug = true;

  @override
  Widget build(BuildContext context) {
    this.currencyController.text = this.selectedCurrency;

    return Scaffold(
      appBar: AppBar(
          // title: Text(widget.title),
          ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: this.formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: "Amount"),
                  validator: (value) =>
                      value.isNotEmpty ? null : "Amount is required",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.currencyController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  readOnly: true,
                  onTap: this._openBottomSheet,
                  decoration: InputDecoration(
                    hintText: "Currency",
                  ),
                  validator: (value) =>
                      value.isNotEmpty ? null : "Currency is required",
                ),
              ),
              // Container(
              //   margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              //   child: TextFormField(
              //     controller: this.publicKeyController,
              //     textInputAction: TextInputAction.next,
              //     style: TextStyle(color: Colors.black),
              //     obscureText: true,
              //     decoration: InputDecoration(
              //       hintText: "Public Key",
              //     ),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              //   child: TextFormField(
              //     controller: this.encryptionKeyController,
              //     textInputAction: TextInputAction.next,
              //     style: TextStyle(color: Colors.black),
              //     obscureText: true,
              //     decoration: InputDecoration(
              //       hintText: "Encryption Key",
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.emailController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (value) =>
                      value.isNotEmpty ? null : "Email is required",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                  ),
                  validator: (value) =>
                      value.isNotEmpty ? null : "Phone Number is required",
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Use Debug"),
                    Switch(
                      onChanged: (value) => {
                        setState(() {
                          isDebug = value;
                        })
                      },
                      value: this.isDebug,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: RaisedButton(
                  onPressed: this._onPressed,
                  color: Colors.blue,
                  child: Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (this.formKey.currentState.validate()) {
      this._handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final flutterwave = Flutterwave.forUIPayment(
        amount: this.amountController.text.toString().trim(),
        currency: this.currencyController.text,
        context: this.context,
        publicKey: "FLWPUBK_TEST-eb9f26a059403bbc13ea9923669ba181-X",
        encryptionKey: "FLWSECK_TEST32a14bf17312",
        email: this.emailController.text.trim(),
        fullName: "Test User",
        txRef: DateTime.now().toIso8601String(),
        narration: "Example Project",
        isDebugMode: this.isDebug,
        phoneNumber: this.phoneNumberController.text.trim(),
        acceptAccountPayment: true,
        acceptCardPayment: true,
        acceptUSSDPayment: true);
    final response = await flutterwave.initializeForUiPayments();
    if (response != null) {
      this
          .showLoading(response.data.status)
          .then((value) => Firestore.instance.collection('payers').add({
                'name': 'Babou',
                'date': DateTime.now(),
                'amount': this.amountController.text.toString().trim(),
                'email': this.emailController.text.trim()
              }))
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Confirm())));
    } else {
      this.showLoading("No Response!");
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return this._getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = [
      FlutterwaveCurrency.UGX,
      FlutterwaveCurrency.GHS,
      FlutterwaveCurrency.NGN,
      FlutterwaveCurrency.RWF,
      FlutterwaveCurrency.KES,
      FlutterwaveCurrency.XAF,
      FlutterwaveCurrency.XOF,
      FlutterwaveCurrency.ZMW,
      FlutterwaveCurrency.TZS,
    ];
    return Container(
      height: 250,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {this._handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    this.setState(() {
      this.selectedCurrency = currency;
      this.currencyController.text = currency;
    });
    Navigator.pop(this.context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
