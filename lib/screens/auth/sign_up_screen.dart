import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase/app_services.dart/my_app_methods.dart';
import 'package:e_commerce_app_with_firebase/constants/my_validators.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/app_name_text.dart';
import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/screens/auth/pick_image_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();
  bool isLoading = false;
  TextEditingController password = TextEditingController();
  FocusNode emailFoucs = FocusNode();
  FocusNode repeatPasswordFoucs = FocusNode();
  FocusNode userFoucs = FocusNode();
  FocusNode passwordFoucs = FocusNode();
  bool showPassword = true;
  XFile? pickedImage;
  final auth = FirebaseAuth.instance;
  String? imageUrl;

  pickimage() {
    final ImagePicker picker = ImagePicker();
    MyAppMthods.pickImage(
        context: context,
        funCamera: () async {
          pickedImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        funGallery: () async {
          pickedImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        funRemove: () {
          setState(() {
            pickedImage = null;
          });
        });
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    emailFoucs.dispose();
    passwordFoucs.dispose();
    user.dispose();
    repeatPassword.dispose();
    userFoucs.dispose();
    repeatPasswordFoucs.dispose();
    super.dispose();
  }

  SignUp() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (pickedImage == null) {
      MyAppMthods.showErrorWringDialog(
          context: context, fun: () {}, title: 'Make sure to pick image');
      return;
    }
    if (isValid) {
      formKey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImage')
            .child('${email.text.trim()}.jpg');
        await ref.putFile(
          File(pickedImage!.path),
        );
        imageUrl = await ref.getDownloadURL();
        await auth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        User? users = auth.currentUser;
        final uid = users!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'userId': uid,
          'userImage': imageUrl,
          'userName': user.text,
          'userEmail': email.text,
          'createdAt': Timestamp.now(),
          'userWish': [],
          'userCart': []
        });
        Fluttertoast.showToast(
          msg: "the email has been created ",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
      } on FirebaseAuthException catch (error) {
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
          context: context,
          fun: () {},
          title: 'an error has been occured ${error.message}',
        );
      } catch (error) {
        // ignore: use_build_context_synchronously
        MyAppMthods.showErrorWringDialog(
          context: context,
          fun: () {},
          title: 'an error has been occured$error',
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
                    "sign up now to receie special offers and updates \n from our app",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: size.width * .3,
                      height: size.width * .3,
                      child: PickImageWidget(
                        pickimage: pickedImage,
                        fun: () async {
                          pickimage();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: user,
                    focusNode: userFoucs,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'enter your username',
                      prefixIcon: Icon(IconlyLight.user),
                    ),
                    validator: (value) {
                      return MyValidators.displayNamevalidator(value);
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(emailFoucs);
                    },
                  ),
                  const SizedBox(
                    height: 15,
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
                    height: 15,
                  ),
                  TextFormField(
                    controller: password,
                    focusNode: passwordFoucs,
                    obscureText: showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
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
                      FocusScope.of(context).requestFocus(repeatPasswordFoucs);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: repeatPassword,
                    focusNode: repeatPasswordFoucs,
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
                    onFieldSubmitted: (value) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        SignUp();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue),
                      child: const SubtitleText(
                        label: 'Sign up',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
