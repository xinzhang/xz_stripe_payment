import 'dart:convert';

import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;
import 'package:xz_stripe_payment/utilities/keys.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';

  static Map<String, String> headers = {
    'Authorization': 'Bearer $API_SECRET',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: PUBLISHED_KEY,
        merchantId: "Test",
        androidPayMode: "test",
      ),
    );
  }

  static StripeTransactionResponse payViaExistingCard(
      {String amount, String currency, dynamic card}) {
    return new StripeTransactionResponse(
        message: 'transaction successful', success: true);
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));

      if (response.status == 'succeeded') {
        return new StripeTransactionResponse(
            message: 'transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(
            message: 'transaction failed:', success: false);
      }
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'transaction failed: ${err.toString()}', success: false);
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        //'amount': (double.parse(amount) * 100).toInt().toString(),
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        StripeService.paymentApiUrl,
        body: body,
        headers: StripeService.headers,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charing user: ${err.toString()}');
    }
    return null;
  }
}
