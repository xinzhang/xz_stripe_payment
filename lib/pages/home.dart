import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:xz_stripe_payment/services/payment-service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        Navigator.pushNamed(context, '/existing-cards');
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    var response = StripeService.payWithNewCard(amount: '15', currency: 'AUD');
    if (response.success == true) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(response.message),
        duration: new Duration(milliseconds: 1200),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    //StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Container(
            padding: EdgeInsets.all(20),
            child: ListView.separated(
              itemBuilder: (context, index) {
                Icon icon;
                Text text;
                switch (index) {
                  case 0:
                    icon = Icon(Icons.add_circle, color: theme.primaryColor);
                    text = Text('Pay view new card');
                    break;
                  case 1:
                    icon = Icon(Icons.credit_card, color: theme.primaryColor);
                    text = Text('Pay via existing card');
                    break;
                }

                return InkWell(
                  onTap: () {
                    onItemPress(context, index);
                  },
                  child: ListTile(
                    title: text,
                    leading: icon,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: theme.primaryColor,
              ),
              itemCount: 2,
            )));
  }
}
