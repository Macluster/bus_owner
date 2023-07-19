

import 'package:bus_owner/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Backend/SupabaseDatabase.dart';
import '../Components/Button1.dart';
import 'LoginPage.dart';

class EnterUserDetailsPage extends StatefulWidget {
  @override
  State<EnterUserDetailsPage> createState() => _EnterUserDetailsPageState();
}

class _EnterUserDetailsPageState extends State<EnterUserDetailsPage> {
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var dob = "Dob";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Enter Details",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "Full Name",
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var eDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 500)),
                              lastDate:
                                  DateTime.now().add(Duration(days: 500)));
                          dob = eDate.toString().split(" ")[0];
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,

                          color: Color.fromARGB(255, 228, 228, 228),
                          child: Text(
                            dob,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: phone,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: address,
                        decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: email,
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                  Button1("Submit", () {
                    var errorText = "Incorrect";
                    if (phone.text.length < 10 || phone.text.length > 10) {
                      errorText = errorText + " phone no Format";
                    }
                    if (!email.text.contains("@") ||
                        !email.text.contains(".")) {
                      if (errorText != "Incorrect") {
                        errorText = errorText + " &";
                      }
                      errorText = errorText + " Email Format";
                    }

                    var model = BusOwnerModel(0, name.text, phone.text, email.text,
                        address.text);

                    if (errorText == "Incorrect") {
                      SupaBaseDatabase().AddUserDetails(model);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (Route<dynamic> route) => false);
                    } else {
                      Fluttertoast.showToast(msg: errorText);
                    }
                  })
                ],
              ),
            )),
      ),
    );
  }
}
