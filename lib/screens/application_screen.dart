import 'package:evi_app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _contactController;
  late final TextEditingController _cgpaController;
  late final TextEditingController _addressController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _contactController = TextEditingController();
    _cgpaController = TextEditingController();
    _addressController = TextEditingController();
  }

  //for dropdown
  String _selectDomain = 'Software developer';
  String _selectTimePeriod = "1W";
  var domains = [
    'Software developer',
    'Full stack developer',
    'Web development',
    'App development',
    'IOT',
    'Data science',
    'UI/UX design',
    'Marketing',
    'Video editor'
  ];

  var timePeriod = ['1W', '4W', '3 Months', '6 Months'];

  CollectionReference User = FirebaseFirestore.instance.collection('User');
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return User.add({
      "name": _nameController.text,
      "emai": _emailController.text,
      "contact": _contactController.text,
      "address": _addressController.text,
      "cgpa": _cgpaController.text,
      "domain": _selectDomain.toString(),
      "time": _selectTimePeriod.toString()
    }).then((value) {
      showDialog(
              context: context,
              builder: (BuildContext context) => const AlertDialog(
                    title: Text("Application Successful"),
                    content: Text(
                        "Thanks for showing interest in us, our team will get back to you shortly."),
                  ))
          .then((value) => Navigator.of(context).pushNamed('/home_screen'));
    }).catchError((error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("ooops!!something went wrong"),
                content: Text(error.toString()),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Fill up Form",
                style: TextStyle(color: Colors.black, fontSize: 32),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: _nameController,
                      hintText: "Enter your name...",
                      labelText: 'Name',
                    ),
                    MyTextField(
                        controller: _emailController,
                        hintText: "Where should we reach you...",
                        labelText: "Email"),
                    MyTextField(
                        controller: _contactController,
                        hintText: "Number with active whatsapp...",
                        labelText: "Contact"),
                    MyTextField(
                        controller: _addressController,
                        hintText: "Enter your locality...",
                        labelText: "address"),
                    MyTextField(
                        controller: _cgpaController,
                        hintText: "Current CGPA...",
                        labelText: "CGPA"),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 20, right: 20),
                      child: Row(
                        children: [
                          DropdownButton<String>(
                            value: _selectDomain,
                            //elevation: 5,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),

                            items: <String>[
                              'Software developer',
                              'Full stack developer',
                              'Web development',
                              'App development',
                              'IOT',
                              'Data science',
                              'UI/UX design',
                              'Marketing',
                              'Video editor'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectDomain = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 20, right: 20),
                      child: Row(
                        children: [
                          DropdownButton<String>(
                            value: _selectTimePeriod,
                            //elevation: 5,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),

                            items: <String>['1W', '4W', '3 Months', '6 Months']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectTimePeriod = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.pink),
                        onPressed: addUser,
                        child: const SizedBox(
                          width: 100,
                          child: Center(
                              child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 20),
                          )),
                        ),
                      ),
                    ),
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
