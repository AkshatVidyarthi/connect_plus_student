import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController paymentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Donate Us",style: GoogleFonts.arsenal(
          fontWeight: FontWeight.bold,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           Image.asset('Assets/connect-student-logo-removebg-preview.png'),
            TextField(
              controller: paymentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Amount",
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (paymentController.text.isNotEmpty) {
                        Razorpay razorpay = Razorpay();
                        var options = {
                          'key': 'rzp_live_ILgsfZCZoFIKMb',
                          'amount': (int.parse(paymentController.text) * 100),
                          'name': 'National PG College',
                          'description': 'Donation for National PG Collage',
                          'retry': {'enabled': true, 'max_count': 1},
                          'send_sms_hash': true,

                          'prefill': {
                            'contact':
                                '${FirebaseAuth.instance.currentUser?.phoneNumber}',
                            'email':
                                '${FirebaseAuth.instance.currentUser?.email}',
                          },
                          'external': {
                            'wallets': ['paytm']
                          }
                        };
                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                            handlePaymentErrorResponse);
                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                            handlePaymentSuccessResponse);
                        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                            handleExternalWalletSelected);
                        razorpay.open(options);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please Enter Amount"),
                          ),
                        );
                      }
                    },
                    child: const Text("Proceed to Payment"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    saveDetailsToFirebase(
      "Failed",
      error: response.error.toString(),
      responseCode: response.code.toString(),
      message: response.message,
    );
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    saveDetailsToFirebase(
      "success",
      paymentId: response.paymentId,
      orderId: response.orderId,
      sign: response.signature,
    );
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    saveDetailsToFirebase("success", walletName: response.walletName);
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> saveDetailsToFirebase(String status,
      {String? paymentId,
      String? walletName,
      String? orderId,
      String? sign,
      String? responseCode,
      String? message,
      String? error}) async {
    FirebaseFirestore.instance.collection("payments").doc().set({
      "status": status,
      "amount": paymentController.text,
      "walletName": walletName,
      "orderId": orderId,
      "sign": sign,
      "responseCode": responseCode,
      "message": message,
      "error": error,
      "userId": FirebaseAuth.instance.currentUser?.uid,
      "name": FirebaseAuth.instance.currentUser?.displayName,
      "mail":FirebaseAuth.instance.currentUser?.email,
      "number":FirebaseAuth.instance.currentUser?.phoneNumber,

    });
  }

  @override
  void dispose() {
    paymentController.dispose();
    super.dispose();
  }
}
