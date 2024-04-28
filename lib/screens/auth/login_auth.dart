import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/constants/my_validators.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/app_name_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/isloading.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/root_screen.dart';
import 'package:e_commerce_app_with_firebase/screens/auth/forget_password.dart';
import 'package:e_commerce_app_with_firebase/screens/auth/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailFoucs = FocusNode();
  FocusNode passwordFoucs = FocusNode();
  final auth = FirebaseAuth.instance;
  bool isloading = false;
  bool showPassword = true;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    emailFoucs.dispose();
    passwordFoucs.dispose();
    super.dispose();
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final authResults =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (authResults.additionalUserInfo!.isNewUser) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResults.user!.uid)
          .set({
        'userId': authResults.user!.uid,
        'userImage': authResults.user!.photoURL,
        'userName': authResults.user!.displayName,
        'userEmail': authResults.user!.email,
        'createdAt': Timestamp.now(),
        'userWish': [],
        'userCart': []
      });
    }
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RootScreen(),
      ),
    );
  }

  login() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      try {
        setState(() {
          isloading = true;
        });
        await auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        Fluttertoast.showToast(
          msg: "the email is success",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RootScreen(),
          ),
        );
      } on FirebaseAuthException catch (error) {
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
            context: context,
            fun: () {},
            title: 'error has benn occured ${error.message}');
      } catch (error) {
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
            context: context,
            fun: () {},
            title: 'error has benn occured $error');
      } finally {
        setState(() {
          isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IsLoadingWidget(
        isLoading: isloading,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(child: AppNameText()),
                    const SizedBox(
                      height: 30,
                    ),
                    const SubtitleText(label: 'Welcome Back'),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      "Let's get you logged in so you can start exploring",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: email,
                      focusNode: emailFoucs,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'enter your email',
                        prefixIcon: Icon(IconlyLight.message),
                      ),
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordFoucs);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: password,
                      focusNode: passwordFoucs,
                      obscureText: showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          hintText: "***************"),
                      validator: (value) {
                        return MyValidators.passwordValidator(value);
                      },
                      onFieldSubmitted: (value) {
                        login();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordScreen()));
                        },
                        child: const SubtitleText(
                          label: 'Forget Password',
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue),
                        child: const SubtitleText(
                          label: 'Sign in',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SubtitleText(
                        label: 'or conect using'.toUpperCase(),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight,
                            child: FittedBox(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  signInWithGoogle();
                                },
                                icon: const Icon(
                                  Ionicons.logo_google,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                label: const SubtitleText(
                                    label: 'Login with google'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const RootScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                            ),
                            child: const SubtitleText(label: 'Guest'),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SubtitleText(
                          label: "Don't have an account?",
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const SubtitleText(
                            label: "Sign up",
                            // textDecoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
