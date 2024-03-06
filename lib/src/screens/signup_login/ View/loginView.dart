import 'package:currytabetaiappnihonbashi/src/screens/signup_login/ViewModel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class loginView extends StatelessWidget {
  const loginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
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
                    onChanged: (String value) => loginViewModel.setEmail(value),
                  ),
                  TextFormField(
                    onChanged: (value) => loginViewModel.setPassword(value),
                    obscureText: loginViewModel.hidePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: const Icon(Icons.lock), // アイコンを追加
                      suffixIcon: IconButton(
                        icon: Icon(loginViewModel.hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () =>
                            loginViewModel.togglePasswordVisibility(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => loginViewModel.login(context),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(400, 50), // 幅と高さを調整
                    ),
                    child: loginViewModel.isLoading
                        ? CircularProgressIndicator()
                        : Text('ログインする'),
                  ),

                  if (loginViewModel.errorMessage.isNotEmpty)
                    Text(loginViewModel.errorMessage), // エラーメッセージの表示
                ],
              ),
            )));
  }
}

// Googleログインボタン
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
            'Googleでログイン',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// Appleログインボタン
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
            'Appleでログイン',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
