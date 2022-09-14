import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final GlobalKey<FormState> userDetails = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Detail"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: userDetails,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image.asset("assets/images/login.png"),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.name = val;
                  },
                  controller: nameController,
                  decoration:
                      textFieldDecoration(Icons.person, "Enter Name", "Name"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Number";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.number = val;
                  },
                  keyboardType: TextInputType.phone,
                  controller: numberController,
                  decoration:
                      textFieldDecoration(Icons.call, "Enter Number", "Number"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.email = val;
                  },
                  controller: emailController,
                  decoration:
                      textFieldDecoration(Icons.email, "Enter Email", "Email"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    Global.password = val;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: textFieldDecoration(
                      Icons.lock, "Enter Password", "Password"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (userDetails.currentState!.validate()) {
                      userDetails.currentState!.save();
                      Navigator.of(context).pushReplacementNamed("LoginPage");
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool("isUserDetails", true);
                      prefs.setString("email", Global.email.toString());
                      prefs.setString("password", Global.password.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(140, 45),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFieldDecoration(icon, hint, label) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hint,
      label: Text(label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
