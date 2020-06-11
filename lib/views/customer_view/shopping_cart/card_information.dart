import 'package:flutter/material.dart';
import 'package:Selfsahaf/views/customer_view/shopping_cart/credit_card_view/credit_card.dart';
import 'package:Selfsahaf/views/customer_view/shopping_cart/order_summary.dart';
import 'package:Selfsahaf/views/registration/input_field.dart';
import 'credit_card_view/credit_card_widget.dart';

import 'credit_card_view/credit_card_model.dart';

class CardInformation extends StatefulWidget {
  @override
  _CardInformationState createState() => _CardInformationState();
}

class _CardInformationState extends State<CardInformation> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cardHolderSurname = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  TextEditingController _cardholdernameController;
  TextEditingController _cardnumberController;
  TextEditingController _cvcController;
  TextEditingController _expirationController;
  TextEditingController _cardholdersurnameController;
  String _cardholdernameValidation(String name) {
    bool emailValid = false;
    if (name.length >= 5) emailValid = true;
    return emailValid ? null : 'not valid name.';
  }

  @override
  Widget build(BuildContext widget) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                child: Center(
                    child: Text(
                  "Card Information",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )),
              ),
              Divider(
                thickness: 2.5,
                color: Colors.white,
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cardHolderSurname: cardHolderSurname,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
