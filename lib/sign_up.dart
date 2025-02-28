
import 'package:firebase_lesson/service/auth_service.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _cfpasswordcontroller = TextEditingController();
  bool isLoading = false;

  void signUp() {
    setState(() {
      isLoading = true;
    });
    String email = _emailcontroller.text.trim().toString();
    String password = _passwordcontroller.text.trim().toString();
    String confirmpassword = _passwordcontroller.text.trim().toString();

    if (email.isEmpty || password.isEmpty || confirmpassword.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }else{AuthService.signUp(email, password,confirmpassword).then((value) => {
      setState(() {
        isLoading = false;
      }),
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const HomePage();
      }))
    });}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigo,
                  Colors.deepPurple,
                  Colors.purple,
                  Colors.purpleAccent,
                ],
                stops: [
                  0.1,
                  0.3,
                  0.6,
                  0.9
                ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Instagram",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _emailcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _passwordcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _cfpasswordcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Center(
                                child: Text(
                                  "Forgotten password?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        isLoading
                            ? Container(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          ),
                        )
                            : InkWell(
                          onTap: () {
                            signUp();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.grey.shade200,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              "Login with Facebook",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Divider(
              color: Colors.grey,
            ),
            Container(
              height: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                            return LoginPage();
                          }));
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
