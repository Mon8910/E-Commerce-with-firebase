import 'package:e_commerce_app_with_firebase/constants/my_validators.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/app_name_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController email=TextEditingController();
   FocusNode emailFoucs = FocusNode();
   final kformkey=GlobalKey<FormState>();
   forgetPassword() async {
   final isValid = kformkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print('object');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const AppNameText(),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/forgot_password.jpg',
                  height: size.width * .6,
                  width: size.width * .5,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const TitleText(
                label: 'Forgot password',
                fontSize: 22,
              ),
              const SizedBox(
                height: 10,
              ),
              const SubtitleText(
                label:
                    'Please enter the email address you\'d like your password reset information sent to',
                fontSize: 14,
              ),
              const SizedBox(
                height: 8,
              ),
              Form(
                key: kformkey,
                child: Column(
                  children: [
                    TextFormField(
                            controller: email,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'youremail@email.com',
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(12),
                                child: const Icon(IconlyLight.message),
                              ),
                              filled: true,
                            ),
                            validator: (value) {
                              return MyValidators.emailValidator(value);
                            },
                            onFieldSubmitted: (_) {
                              // Move focus to the next field when the "next" button is pressed
                            },
                          ),
                          const SizedBox(height: 15,),
                          SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    // backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  icon: const Icon(IconlyBold.send),
                  label: const Text(
                    "Request link",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {
                    forgetPassword();
                  },
                ),
              ),
                          
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
