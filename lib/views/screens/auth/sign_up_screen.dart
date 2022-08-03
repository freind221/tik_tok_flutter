import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok_flutter/constants.dart';
import 'package:tik_tok_flutter/views/screens/auth/login_screen_auth.dart';
import 'package:tik_tok_flutter/views/widgets/text_form.dart';

class SignUpScrren extends StatelessWidget {
  SignUpScrren({Key? key}) : super(key: key);
  final TextEditingController emaileEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                width: width,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: buttonColor,
                          backgroundImage:
                              const AssetImage('assets/avatar1.png'),
                        ),
                        Positioned(
                            left: 80,
                            bottom: -8,
                            child: IconButton(
                              onPressed: () {
                                authController.pickImage();
                              },
                              icon: const Icon(Icons.add_a_photo),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    MyTextField(
                        controller: usernameController,
                        labelText: 'Username',
                        isObscure: false,
                        icon: Icons.person),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    MyTextField(
                        controller: emaileEditingController,
                        labelText: 'Email',
                        isObscure: false,
                        icon: Icons.email),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    MyTextField(
                      controller: passwordEditingController,
                      labelText: 'Password',
                      isObscure: true,
                      icon: Icons.password,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        authController.registerUser(
                            usernameController.text,
                            emaileEditingController.text,
                            passwordEditingController.text,
                            authController.profilePhoto);
                      },
                      child: Container(
                        width: width - 40,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: buttonColor),
                        child: const Center(
                            child: Text(
                          'SignUp',
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => LoginScreen());
                          },
                          child: Text(
                            "Login here",
                            style: TextStyle(color: buttonColor, fontSize: 17),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
