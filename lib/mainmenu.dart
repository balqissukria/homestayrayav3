import 'package:flutter/material.dart';
import 'package:homestayraya/homescreen.dart';
import 'package:homestayraya/login_screen.dart';
import 'package:homestayraya/login_user.dart';
import 'package:homestayraya/profile.dart';
import 'user.dart';

import 'enterExitRoute.dart';

class MainMenuWidget extends StatefulWidget {
  final User user;
  const MainMenuWidget({super.key, required this.user});

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      elevation: 10,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(widget.user.email.toString()),
            accountName: Text(widget.user.name.toString()),
            currentAccountPicture: const CircleAvatar(
              radius: 30.0,
            ),
          ),
          ListTile(
              title: const Text('Login'),
              onTap: () {
                _loginDialog();
              }),
          ListTile(
            title: const Text('Homestays Catalogue'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (content) => BuyerScreen()));
              Navigator.push(
                  context,
                  EnterExitRoute(
                      exitPage: Homescreen(user: widget.user),
                      enterPage: Homescreen(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text('Your homestay'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (content) => BuyerScreen()));
              Navigator.push(
                  context,
                  EnterExitRoute(
                      exitPage: LoginUser(user: widget.user),
                      enterPage: LoginUser(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  EnterExitRoute(
                      exitPage: ProfileScreen(user: widget.user),
                      enterPage: ProfileScreen(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              _logout();
              print("Logout menu is selected.");
            },
          ),
        ],
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Logout?",
            style: TextStyle(),
          ),
          content: const Text("Are your sure"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => const LoginScreen()));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Login account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => const LoginScreen()));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
