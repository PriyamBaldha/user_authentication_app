import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> loginPage = GlobalKey<FormState>();

  final TextEditingController EmailController = TextEditingController();

  final TextEditingController PasswordController = TextEditingController();

  bool checkBoxVal = false;
  String? checkPassword;
  String? checkEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: loginPage,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val != checkEmail) {
                    return "Please Enter valid Email Id...";
                  }
                  return null;
                },
                onSaved: (val) {
                  Global.email = val;
                },
                controller: EmailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle:
                        TextStyle(fontSize: 15, color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              validator: (val) {
                if (val != checkPassword) {
                  return "Please Enter valid Password...";
                }
                return null;
              },
              onSaved: (val) {
                Global.password = val;
              },
              controller: PasswordController,
              decoration: InputDecoration(
                labelText: "Passsword",
                labelStyle:
                    TextStyle(fontSize: 15, color: Colors.grey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: checkBoxVal,
                  onChanged: (val) {
                    setState(() {
                      checkBoxVal = val!;
                    });
                  },
                ),
                const Text('Remember me'),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                checkEmail = prefs.getString("email");
                checkPassword = prefs.getString("password");

                if (loginPage.currentState!.validate()) {
                  loginPage.currentState!.save();

                  Navigator.of(context).pushReplacementNamed("HomePage");

                  prefs.setBool("isLogin", true);
                  prefs.setBool("isRemember", checkBoxVal);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(140, 45),
                shape: const StadiumBorder(),
              ),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
