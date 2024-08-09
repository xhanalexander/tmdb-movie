import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdbapp/view_models/movies_view_models.dart';
import 'package:tmdbapp/views/auth/login_view.dart';

class Profilepages extends StatefulWidget {
  const Profilepages({super.key});

  @override
  State<Profilepages> createState() => _ProfilepagesState();
}

class _ProfilepagesState extends State<Profilepages> {
  late String username = '';

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('isLogin');
    context.read<MoviesViewModel>().clearWishlist();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Username: $username', style: TextStyle(fontSize: 18)),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  logout();
                },
                child: const Text('Logout', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ]
          ),
        ),
      ),
    );
  }
}