import 'package:connect_plus_student/screens/Login_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneno =TextEditingController();
  TextEditingController otp=TextEditingController();
  TextEditingController mycontroller= TextEditingController();
  TextEditingController otpController=TextEditingController();
  bool isOTPSend = false;
  String verificationID = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Login Screen'),
      ),
     body:
     Column(children: [
       SizedBox(height: 30,),
       Padding(
         padding: const EdgeInsets.all(10.0),
         child: Image.network('https://npgc.in/assets/images/CollegeLogo.png?Valu=74c0a3be-5932-4865-8ba9-7c223e4135ba'),
       ),
       Text('PRESENTS',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
       SizedBox(height: 10,),
       Text('Connect+ Student',style:
        GoogleFonts.arsenal(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          wordSpacing: 3.0,
          letterSpacing: 0.5,
        ),

       ),
          SizedBox(height: 20,),
         CircleAvatar(
           radius: 80,
           backgroundColor: Colors.black,
           backgroundImage: AssetImage("Assets/connect-student-logo.png"),
         ),
       Padding(
         padding: const EdgeInsets.all(24.0),
         child: TextField(
           enabled: !isOTPSend,
           controller: mycontroller,
           keyboardType: TextInputType.phone,
           decoration: InputDecoration(
             prefixIcon: Icon(Icons.phone),
             border:  OutlineInputBorder(
               borderSide: BorderSide(
                 color: Colors.black,
             ),
             ),
             hintText: 'Phone Number with Code',
           ),
         ),
       ),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text('*A One Time Password (OTP) would be sent to your Phone Number which will be required to verify your identity.',style: TextStyle(
             fontSize: 10,
             color: Colors.grey,
           fontWeight: FontWeight.bold,
         )),
       ),
       Visibility(
         visible: isOTPSend,
         child: Padding(
           padding: const EdgeInsets.all(32.0),
           child: TextField(
             controller: otpController,
             keyboardType: TextInputType.phone,
             decoration: InputDecoration(
               hintText: 'ENTER OTP',
               border: OutlineInputBorder(
                 borderSide: BorderSide(width: 5),


               )
             ),
           ),
         ),
       ),
       Visibility(
         visible: !isOTPSend,
         child: ElevatedButton(
             onPressed: () async {
               await FirebaseAuth.instance.verifyPhoneNumber(
                 phoneNumber: mycontroller.text,
                 verificationCompleted: (PhoneAuthCredential credential) {
                 },
                 verificationFailed: (FirebaseAuthException e) {},
                 codeSent: (String verificationId, int? resendToken) {
                   verificationID = verificationId;
                   setState(() {
                     isOTPSend = true;
                   });
                 },
                 codeAutoRetrievalTimeout: (String verificationId) {},
               );
             },
             child: Text('Send OTP')),
       ),
       Visibility(
         visible: isOTPSend,
         child: ElevatedButton(
             onPressed: () async {
               PhoneAuthCredential credential = PhoneAuthProvider.credential(
                   verificationId: verificationID,
                   smsCode: otpController.text);
               // Sign the user in (or link) with the credential
               final userCred = await FirebaseAuth.instance
                   .signInWithCredential(credential);
               print(userCred.user?.phoneNumber);
               if(userCred.user?.phoneNumber !=null){
                 //FirebaseFirestore.instance.collection("${userCred.user?.phoneNumber.toString().replaceAll("+", "")}");
               }

               Navigator.pushAndRemoveUntil(
                 context,
                 MaterialPageRoute(builder: (context) {
                   return Login_options();
                 }),
                     (route) => false,
               );
             },
             child: Text('Verify OTP')),
       ),
       Padding(
         padding: const EdgeInsets.all(16.0),
         child: ElevatedButton(

               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.red,
               ),
              onPressed: () async {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                   return Login_options();
                 },));
                final user = await signInWithGoogle();
                print(user.user?.email);
              },
              child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle_rounded),
                      SizedBox(width: 10,),
                      Text("Continue With Google"),
                    ],
                  ),
            ),
       )


        ],
      ),
    );
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
