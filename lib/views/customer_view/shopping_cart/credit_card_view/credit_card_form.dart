import 'package:Selfsahaf/models/address.dart';
import 'package:Selfsahaf/models/shipping_company_model.dart';
import 'package:Selfsahaf/views/customer_view/shopping_cart/card_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:Selfsahaf/views/customer_view/shopping_cart/order_summary.dart';

import 'credit_card_model.dart';

class CreditCardForm extends StatefulWidget {
  
  const CreditCardForm({
    @required this.address,
    @required this.totalPrice,
    @required this.company,
    Key key,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cardHolderSurname,
    this.cvvCode,
    @required this.onCreditCardModelChange,
    this.themeColor,
    this.textColor = Colors.black,
    this.cursorColor,
  }) : super(key: key);

  final Address address;
  final double totalPrice;
  final ShippingCompanyModel company;
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cardHolderSurname;
  final String cvvCode;
  final void Function(CreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color cursorColor;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  Address address;
  double totalPrice;
  ShippingCompanyModel company;
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cardHolderSurname;
  String cvvCode;
  bool isCvvFocused = false;
  Color themeColor;

  void Function(CreditCardModel) onCreditCardModelChange;
  CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
      final TextEditingController _cardHolderSurnameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '000');

  FocusNode cvvFocusNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber ?? '';
    expiryDate = widget.expiryDate ?? '';
    cardHolderName = widget.cardHolderName ?? '';
    cvvCode = widget.cvvCode ?? '';

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cardHolderSurname,cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    this.address = widget.address;
    this.totalPrice = widget.totalPrice;
    this.company = widget.company;
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });
    _cardHolderSurnameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderSurnameController.text;
        creditCardModel.cardHolderSurname = cardHolderSurname;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void didChangeDependencies() {
    themeColor = widget.themeColor ?? Theme.of(context).primaryColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: themeColor.withOpacity(0.8),
        primaryColorDark: themeColor,
      ),
      child: Form(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: TextFormField(
                controller: _cardNumberController,
                cursorColor: widget.cursorColor ?? themeColor,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    hintText: "Card Number",
                    hintStyle: TextStyle(color: Colors.white70),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: new BorderRadius.circular(16.0)),
                    enabledBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    errorBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.deepPurple,
                        width: 3.0,
                      ),
                    ),
                    focusedErrorBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.deepPurple,
                        width: 3.0,
                      ),
                    )),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: TextFormField(
                controller: _expiryDateController,
                cursorColor: widget.cursorColor ?? themeColor,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    hintText: "MM/YY",
                    hintStyle: TextStyle(color: Colors.white70),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: new BorderRadius.circular(16.0)),
                    enabledBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    errorBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.deepPurple,
                        width: 3.0,
                      ),
                    ),
                    focusedErrorBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.deepPurple,
                        width: 3.0,
                      ),
                    )),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: TextField(
                focusNode: cvvFocusNode,
                controller: _cvvCodeController,
                cursorColor: widget.cursorColor ?? themeColor,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    hintText: "CVV",
                    hintStyle: TextStyle(color: Colors.white70),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: new BorderRadius.circular(16.0)),
                    enabledBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    errorBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.deepPurple,
                        width: 3.0,
                      ),
                    ),
                    focusedErrorBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.deepPurple,
                        width: 3.0,
                      ),
                    )),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onChanged: (String text) {
                  setState(() {
                    cvvCode = text;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: TextFormField(
                controller: _cardHolderNameController,
                cursorColor: widget.cursorColor ?? themeColor,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    hintText: "Card Holder's Name",
                    hintStyle: TextStyle(color: Colors.white70),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: new BorderRadius.circular(16.0)),
                    enabledBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                    errorBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.deepPurple,
                        width: 3.0,
                      ),
                    ),
                    focusedErrorBorder: new OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: new BorderRadius.circular(16.0),
                      borderSide: new BorderSide(
                        color: Colors.deepPurple,
                        width: 3.0,
                      ),
                    )),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0,bottom: 20),
              child: Container(
                  width: MediaQuery.of(context).size.width - 220,
                  height: 60,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Color.fromRGBO(230, 81, 0, 1))),
                    color: Colors.white,
                    onPressed: () async {

                      CreditCardModel myCard = new CreditCardModel(_cardNumberController.text, _expiryDateController.text, _cardHolderNameController.text,_cardHolderSurnameController.text ,_cvvCodeController.text, isCvvFocused);
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderSummary(address:address,company: company,totalPrice: totalPrice,myCard: myCard,)),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 15,
                          child: Text(
                            "Summary",
                            style: TextStyle(
                                color: Color.fromRGBO(230, 81, 0, 1),
                                fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(230, 81, 0, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
