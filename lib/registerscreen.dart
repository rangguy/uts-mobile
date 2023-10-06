import 'package:crud_flutter/login_page.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/register.png",
                height: 196,
                width: 154,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Registration",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff475BD8)),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff475BD8)),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(hintText: "Username"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff475BD8)),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(hintText: "Password"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff475BD8)),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(
                      hintText: "Confirm Password"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                    children: [
                      Text("Sudah punya akun?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text("Login"),
                      ),
                    ],
                  ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff475BD8),
                    border: Border.all(color: const Color(0xff475BD8)),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () {
                    // Route route =
                    //     MaterialPageRoute(builder: (context) => home());
                    // Navigator.push(context, route);
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
