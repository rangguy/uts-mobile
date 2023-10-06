import 'package:crud_flutter/home_page.dart';
import 'package:crud_flutter/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var namaUser;

  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text);
  }

  _showDialog(pesan, alamat) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text(pesan),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => alamat),
                    );
                  },
                  child: const Text("Ok"))
            ],
          );
        }));
  }

  _inputan(namaController, placeholder, isPassword) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff475BD8)),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: namaController,
        decoration: InputDecoration.collapsed(hintText: placeholder),
        obscureText: isPassword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/image/login.png",
            height: 196,
            width: 154,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Login",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Color(0xff475BD8)),
          ),
          const SizedBox(
            height: 15,
          ),
          _inputan(usernameController, 'Masukkan Username', false),
          const SizedBox(
            height: 15,
          ),
          _inputan(passwordController, 'Masukkan Password', true),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text("Belum punya akun?"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text("Daftar"),
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
                if (usernameController.text == 'admin' &&
                    passwordController.text == 'admin') {
                  _saveUsername();
                  _showDialog("Anda berhasil login", const HomePage());
                } else {
                  _showDialog("Username dan Password Salah", const LoginPage());
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
