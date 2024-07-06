import 'package:ecommerce_application_test/consts/colors.dart';
import 'package:ecommerce_application_test/consts/string.dart';
import 'package:ecommerce_application_test/consts/widgets/our_button.dart';
import 'package:ecommerce_application_test/controllers/auth.dart';
import 'package:ecommerce_application_test/views/dashboard_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/widgets/normal_text.dart';

class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});

  @override
  State<InscriptionScreen> createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Auth _auth = Auth();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: normalText(text:inscription,color:Color.fromARGB(255, 9, 8, 8),size: 20.0),
              ),
              40.heightBox,
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: lightGrey,
                          prefixIcon: Icon(Icons.person, color: blueColor),
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
                          hintText: name,
                        ),
                      ),

                      10.heightBox,
                      TextFormField(
                        controller: _phoneController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: lightGrey,
                          prefixIcon: Icon(Icons.phone, color: blueColor),
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
                          hintText: phone,
                        ),
                      ),
                      10.heightBox,
                      TextFormField(
                        controller: _emailController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: lightGrey,
                          prefixIcon: Icon(Icons.mail, color: blueColor),
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
                          hintText: emailHint,
                        ),
                      ),
                      10.heightBox,
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: lightGrey,
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
                          hintText: password,
                        ),
                      ),
                      20.heightBox,
                      SizedBox(
                        height: 50,
                        width: context.screenWidth - 100,
                        child: ourButton(
                          title: inscription,
                          color: darkFontGrey,
                          onPress: () async {
                          String fullName = _fullNameController.text.trim();
                          String phone = _phoneController.text.trim();
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          try {
                            await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
              )
              ]
          )
        )
      )
    );
  }
}