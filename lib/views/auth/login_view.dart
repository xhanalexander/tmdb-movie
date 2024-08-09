import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdbapp/components/buttons.dart';
import 'package:tmdbapp/components/form_fields.dart';
import 'package:tmdbapp/constant/constant.dart';
import 'package:tmdbapp/constant/design_system.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferences prefs;

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      if (usernameController.text == Constant.defaultUsername && passwordController.text == Constant.defaultPassword) {
        final prefs = SharedPreferences.getInstance();
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        prefs.then((value) => value.setBool('isLogin', true));
        prefs.then((value) => value.setString('username', usernameController.text));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username or password is incorrect'),
          ),
        );
      }
    }
  }

  void isLogin() async {
    prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.getBool('isLogin') ?? false;
    if (isLogin) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In TMDB App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              UsernameForm(
                controllerNames: usernameController,
                hintTextName: 'Username',
              ),

              const SizedBox(height: 20),
              PasswordForm(
                hintTextName: 'Password',
                controllerNames: passwordController,
                isPasswordVisible: isPasswordVisible,
                onPressedPassword: () => setState(() => isPasswordVisible = !isPasswordVisible),
              ),

              const SizedBox(height: 30),
              FormButton(
                onPressed: () => submit(),
                childs: Text('Sign in', style: TextStyleSystem().buttonStyle),
              ),
              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Register'),
                        content: const Text('Username and password are "admin"'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Close'),
                          )
                        ],
                      );
                    },
                  );
                },
                child: const Text('how?', style: TextStyle(color: Colors.purple)),
              )

            ],
          )
        ),
      ),
    );
  }
}