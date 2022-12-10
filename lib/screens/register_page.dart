import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailAddressController;
  late TextEditingController _contactController;
  late TextEditingController _passwordController;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailAddressController = TextEditingController();
    _contactController = TextEditingController();
    _passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.fitHeight)),
          child: Column(
            children: [
              Expanded(child: Container()),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/register.png",
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, right: 20, left: 20, bottom: 5),
                      child: Row(
                        children: const [
                          Text(
                            "Let's get you\nRegistered",
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: "SquarePeg",
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyTextField(
                      controller: _emailAddressController,
                      hintText: "Enter your email here...",
                      labelText: "Email",
                    ),
                    MyTextField(
                      controller: _contactController,
                      hintText: "Enter your number here...",
                      labelText: "Contact",
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: !passwordVisibility,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Color(0xFF95A1AC),
                            ),
                            hintText: "Enter password here...",
                            hintStyle: const TextStyle(
                              color: Color(0xFF95A1AC),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFDBE2E7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFDBE2E7),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    16, 24, 0, 24),
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () => passwordVisibility = !passwordVisibility,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: const Color(0xFF95A1AC),
                                size: 22,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Color(0xFF2B343A),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, bottom: 20, right: 40, top: 20),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/login_page'),
                            child: const Text(
                              "Go back to login",
                              style: TextStyle(
                                  //color: Colors.blue,
                                  //fontSize: 16
                                  ),
                            ),
                          ),
                          Expanded(child: Container()),
                          ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailAddressController.text,
                                        password: _passwordController.text)
                                    .then((value) {
                                  Navigator.of(context)
                                      .pushNamed('/login_page');
                                }).onError((error, stackTrace) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text(
                                                "ooops!!something went wrong"),
                                            content: Text(error.toString()),
                                          ));
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pink[200],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text(
                                "Sign-up",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                        ],
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
