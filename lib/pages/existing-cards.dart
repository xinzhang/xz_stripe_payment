import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:xz_stripe_payment/services/payment-service.dart';

class ExistingCardsPage extends StatefulWidget {
  ExistingCardsPage({Key key}) : super(key: key);

  @override
  _ExistingCardsPageState createState() => _ExistingCardsPageState();
}

class _ExistingCardsPageState extends State<ExistingCardsPage> {
  List cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Muhammad Ahsan Ayaz',
      'cvvCode': '424',
      'showBackView': false,
    },
    {
      'cardNumber': '5555555566554444',
      'expiryDate': '04/23',
      'cardHolderName': 'Tracer',
      'cvvCode': '123',
      'showBackView': false,
    }
  ];

  payViaExistingCard(BuildContext context, card) async {
    var response = StripeService.payViaExistingCard(
        amount: '15', currency: 'AUD', card: card);
    if (response.success == true) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(
            content: Text(response.message),
            duration: new Duration(milliseconds: 1200),
          ))
          .closed
          .then((_) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('choose existing card')),
        body: Container(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  var card = cards[index];
                  return InkWell(
                      onTap: () {
                        payViaExistingCard(context, card);
                      },
                      child: CreditCardWidget(
                        cardNumber: card['cardNumber'],
                        expiryDate: card['expiryDate'],
                        cardHolderName: card['cardHolderName'],
                        cvvCode: card['cvvCode'],
                        showBackView: false,
                      ));
                })));
  }
}
