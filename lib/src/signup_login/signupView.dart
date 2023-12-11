import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class signupView extends StatefulWidget {
  const signupView({Key? key}) : super(key: key);

  @override
  _signupViewState createState() => _signupViewState();
}

class _signupViewState extends State<signupView> {
  String email = '';
  String password = '';
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Center(
          child: Column(
            children: [
              Image.network(
                  'https://rotti-kanazawa.com/wp-content/uploads/2022/05/rotti_chef.png',
                  width: 100,
                  height: 100),
              const SizedBox(height: 20),
              GoogleButton(),
              const SizedBox(height: 20),
              AppleButton(),
              const SizedBox(height: 50),
              const Divider(
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              const SizedBox(height: 50),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  hintText: 'curry@qmail.com',
                  labelText: 'メールアドレス',
                ),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                obscureText: hidePassword,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  labelText: 'パスワード',
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(400, 50), // 幅と高さを調整
                ),
                child: const Text('新規登録する'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Googleサインインボタン
class GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ボタンが押されたときの処理
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Googleで登録',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// Appleサインインボタン
class AppleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ボタンが押されたときの処理
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Appleで登録',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
