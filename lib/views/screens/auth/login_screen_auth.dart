import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok_flutter/constants.dart';
import 'package:tik_tok_flutter/views/screens/auth/sign_up_screen.dart';
import 'package:tik_tok_flutter/views/widgets/text_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emaileEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
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
                    onTap: () {},
                    child: Container(
                      width: width - 40,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: buttonColor),
                      child: const Center(
                          child: Text(
                        'Login',
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
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => SignUpScrren());
                        },
                        child: Text(
                          "Register here",
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
      )),
    );
  }
}
