
import 'package:flutter/material.dart';

import '../Backend/SupabaseAuthentication.dart';
import 'EnterUserDetailsPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              "SignUp",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
                width: 250,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "User name",
                      hintStyle: Theme.of(context).textTheme.bodySmall),
                )),
            SizedBox(
              height: 40,
            ),
            Container(
                width: 250,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: " Create Password",
                      hintStyle: Theme.of(context).textTheme.bodySmall),
                )),  
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                SupabaseAuthentication().signupEmailAndPassword(
                    emailController.text, passwordController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EnterUserDetailsPage()));
              },
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 100,
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text("signUp"),
              ),
            ),
           const  SizedBox(
              height: 30,
            ),
          const   SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInCard('assets/images/google.png'),
                SizedBox(
                  width: 50,
                ),
                SignInCard('assets/images/facebook.png')
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class SignInCard extends StatelessWidget {
  String imageLink = "";
  SignInCard(this.imageLink);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset(imageLink),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 10,
                  color: Color.fromARGB(255, 246, 242, 242))
            ]));
  }
}
