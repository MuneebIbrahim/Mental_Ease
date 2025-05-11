import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

const String stripePublishableKey = "pk_test_51Pt47MH8RYav7UwyTR7NkDhLimzDlMGEGujKFlhxp0nOm5YfiW4VaSSS0iGKkAX3FZS5iDrwA3wf2u8hBPbYaTGQ00ZLDF4GFq";
const String stripeSecretKey = "sk_test_51Pt47MH8RYav7UwyCU03k5i8sUdBDH6EFf6RuAXdY0C9957KqXg8zlC9HumznT0hhc5is5KknQtwp9D74vNyfZWY00vwxYhYRS";

class StripeService {
  StripeService._();
  String paymentIntentSecret = '';
  bool isSuccess = false;

  static final StripeService instance = StripeService._();

  // Fetch the AuthController instance
  Future<String?> getPaymentIntentClientSecret(double amount, String currency) async {
    print('Fetching PaymentIntent client secret for amount: $amount, currency: $currency');
    return await _createPaymentIntent(25, 'USD');
  }
  Future<void> makePayment(double amount, String currency) async {
    print('makePayment called with amount: $amount, currency: $currency');
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(25, 'USD');
      print('Received PaymentIntent client secret: $paymentIntentClientSecret');
      print('IntentStatus$isSuccess');
      if (paymentIntentClientSecret == null) {
        print('PaymentIntent creation failed. Exiting makePayment.');
        return;
      }
      print('Initializing PaymentSheet...');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "TradeMe AE",
        ),
      );
      print('PaymentSheet initialized successfully.');
      await _processPayment();
      print('Payment processed successfully.');

      // Call the dummy API after payment is processed
      // await _callDummyApi(amount, currency);
    } catch (e) {
      print('Error in makePayment: $e');
    }
  }
  // Future<void> _confirmDeposit(String trx,String paymentIntentClientSecret) async {
  //   final accessToken = authController.getAccessToken();
  //
  //
  //
  //   const String url = "https://trademe.ae/api/deposit/status";
  //
  //   try {
  //     var response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $accessToken",
  //       },
  //       body: jsonEncode({
  //         "trx": trx,
  //         "status": '1',
  //         "btc_wallet": paymentIntentClientSecret,
  //       }),
  //     );
  //     print('ConfirmSubmitBody${response.request}');
  //     print('Confirm Response Body: ${response.body}');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // Parse the response body
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //
  //     } else {
  //
  //       // Handle unsuccessful response (non-200 status)
  //
  //     }
  //   } catch (e) {
  //
  //     // Handle any exceptions
  //
  //   } finally {
  //
  //   }
  // }
  Future<String?> _createPaymentIntent(double amount, String currency) async {
    print('Creating PaymentIntent for amount: $amount, currency: $currency');
    try {
      final Uri url = Uri.parse("https://api.stripe.com/v1/payment_intents");
      print('Stripe API URL: $url');
      Map<String, String> headers = {
        "Authorization": "Bearer $stripeSecretKey",
        "Content-Type": "application/x-www-form-urlencoded",
      };
      print('Request headers: $headers');

      String body = "amount=${_calculateAmount(amount).toInt()}&currency=$currency";
      print('StripeRequest body: $body');

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print('Stripe API response received with status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response JSON parsed: $responseData');
        if (responseData['client_secret'] != null) {
          print('PaymentIntent client_secret found: ${responseData['client_secret']}');
          paymentIntentSecret = responseData['client_secret'];
          print('PI$paymentIntentSecret');

          return responseData['client_secret'];
        } else {

          throw Exception("No client_secret found in the response");
        }
      } else {

        throw Exception("Failed to create PaymentIntent with status code: ${response.statusCode}");
      }
    } catch (e) {

      print('Error in _createPaymentIntent: $e');
      return null;
    }
  }


  Future<void> _processPayment() async {
    print('Processing payment...');
    try {
      print('Presenting PaymentSheet...');
      await Stripe.instance.presentPaymentSheet();
      print('PaymentSheet presented successfully.');

      print('Confirming PaymentSheet payment...');
      // Uncomment the following line if confirmation is required
      // await Stripe.instance.confirmPaymentSheetPayment();
      print('Payment confirmed successfully.');
      isSuccess = true;
      print('PaymentIntent$isSuccess');
    } catch (e, stackTrace) {
      isSuccess = false;
      print('Error occurred while processing payment: $e');
      print('Stack trace: $stackTrace');
      if (e is StripeException) {

        isSuccess = false;
        print('PaymentIntent$isSuccess');
        print('StripeException occurred: ${e.error.localizedMessage}');
      } else {
        isSuccess = false;
        print('An unexpected error occurred.');
      }
    }
  }

  double _calculateAmount(double amount) {
    print('Calculating amount in cents for amount: $amount');
    final calculatedAmount = amount * 100;
    print('Calculated amount in cents: $calculatedAmount');
    return calculatedAmount;
  }
}