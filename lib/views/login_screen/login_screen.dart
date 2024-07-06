import 'package:ecommerce_application_test/consts/colors.dart';
import 'package:ecommerce_application_test/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/string.dart';
import '../../consts/widgets/normal_text.dart';
import '../../consts/widgets/our_button.dart';
import '../dashboard_screen/dashboard_screen.dart';
import '../inscription_screen/inscription_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:blueColor,//Color.fromARGB(255, 2, 159, 214),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: normalText(text:welcome,color:const Color.fromARGB(255, 9, 8, 8),size: 20.0),
              ),
              20.heightBox,
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: normalText(text:loginTo,color: Color.fromARGB(255, 72, 71, 71),size: 16.0),
              ),
              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: textfeildGrey,
                          prefixIcon: Icon(Icons.email, color: blueColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          hintText: emailHint,
                        ),
                      ),

                      10.heightBox,
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: textfeildGrey,
                          prefixIcon: Icon(Icons.lock, color: blueColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Ajustez la valeur ici
                          hintText: passwordHint,
                        ),
                      ),

                      10.heightBox,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child: normalText(text: forgetPassword,color: blueColor))),
                      10.heightBox,
                      SizedBox(
                        height: 50,
                        width: context.screenWidth - 100,
                        child: ourButton(
                          title: login,
                          onPress: () async {
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();

                            try {
                              await _auth.signInWithEmailAndPassword(email: email, password: password);
                              // Navigate to DashboardScreen after successful login
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => DashboardScreen()),
                              );
                            } catch (e) {
                              VxToast.show(context, msg: e.toString());
                            }
                          },
                        )
                      ),
            ]),
              ),
              20.heightBox,
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>const InscriptionScreen()),
                          );
                        },
                        child: normalText(text: createAccount, color: blueColor),
                      ),
                      )
              
            ],
          ).box.color(Colors.white).border(color: whiteColor).rounded.outerShadowMd.padding(const EdgeInsets.all(8)).make(),
      )),
    );
  }
}