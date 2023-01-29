import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homestayraya/homescreen.dart';

import 'package:ndialog/ndialog.dart';
import 'config.dart';
import 'details_screen.dart';
import 'login_screen.dart';
import 'mainmenu.dart';
import 'newhomestayscreen.dart';
import 'user.dart';
import 'homestay.dart';
import 'package:http/http.dart' as http;

class LoginUser extends StatefulWidget {
  final User user;
  const LoginUser({super.key, required this.user});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  var _lat, _lng;
  late Position _position;
  List<Homestay> homestayList = <Homestay>[];
  String titlecenter = "Loading...";
  var placemarks;

  late double screenHeight, screenWidth, resWidth;
  int rowcount = 2;

  @override
  void initState() {
    super.initState();

    _loadHomestays();
  }

  @override
  void dispose() {
    homestayList = [];
    print("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }
    return Scaffold(
        appBar: AppBar(title: const Text("HomePage"), actions: [
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("New Homestay"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Logout"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              _gotoNewHomestay();
              print("My account menu is selected.");
            } else if (value == 1) {
              _logout();
              print("Logout menu is selected.");
            }
          }),
        ]),
        body: homestayList.isEmpty
            ? Center(
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your current homestays (${homestayList.length} found)",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: rowcount,
                      children: List.generate(homestayList.length, (index) {
                        return Card(
                          elevation: 8,
                          child: InkWell(
                            onTap: () {
                              _showDetails(index);
                            },
                            onLongPress: () {
                              _deleteDialog(index);
                            },
                            child: Column(children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  width: resWidth / 2,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${Config.server}/homestayimage/${homestayList[index].homestayId}a.png",
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          truncateString(
                                              homestayList[index]
                                                  .homestayName
                                                  .toString(),
                                              15),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "RM ${double.parse(homestayList[index].homestayPrice.toString()).toStringAsFixed(2)}"),
                                      ],
                                    ),
                                  ))
                            ]),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
        drawer: MainMenuWidget(user: widget.user));
  }

  String truncateString(String str, int size) {
    if (str.length > size) {
      str = str.substring(0, size);
      return "$str...";
    } else {
      return str;
    }
  }

  Future<void> _gotoNewHomestay() async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 10,
      message: const Text("Searching your current location"),
      title: null,
    );
    progressDialog.show();
    if (await _checkPermissionGetLoc()) {
      progressDialog.dismiss();
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (content) => NewHomestayScreen(
                  position: _position,
                  user: widget.user,
                  placemarks: placemarks)));
      _loadHomestays();
    } else {
      Fluttertoast.showToast(
          msg: "Please allow the app to access the location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    }
  }

  Future<bool> _checkPermissionGetLoc() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: "Please allow the app to access the location",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        Geolocator.openLocationSettings();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: "Please allow the app to access the location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      Geolocator.openLocationSettings();
      return false;
    }
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    try {
      placemarks = await placemarkFromCoordinates(
          _position.latitude, _position.longitude);
    } catch (e) {
      Fluttertoast.showToast(
          msg:
              "Error in fixing your location. Make sure internet connection is available and try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return false;
    }
    return true;
  }

  void _loadHomestays() {
    http
        .get(
      Uri.parse(
          "${Config.server}/php/loadhomestays.php?userid=${widget.user.id}"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          var extractdata = jsondata['data'];
          if (extractdata['homestay'] != null) {
            homestayList = <Homestay>[];
            extractdata['homestay'].forEach((v) {
              homestayList.add(Homestay.fromJson(v));
            });
            titlecenter = "Found";
          } else {
            titlecenter = "No homestay Available";
            homestayList.clear();
          }
        } else {
          titlecenter = "No homestay Available";
        }
      } else {
        titlecenter = "No homestay Available";
        homestayList.clear();
      }
      setState(() {});
    });
  }

  Future<void> _showDetails(int index) async {
    Homestay homestay = Homestay.fromJson(homestayList[index].toJson());

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => DetailsScreen(
                  homestay: homestay,
                  user: widget.user,
                )));
    _loadHomestays();
  }

  _deleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(
            "Delete ${truncateString(homestayList[index].homestayName.toString(), 15)}",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                _deleteHomestay(index);
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

  void _deleteHomestay(index) {
    try {
      http.post(Uri.parse("${Config.server}/php/delete_homestay.php"), body: {
        "homestayid": homestayList[index].homestayId,
      }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == "success") {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          _loadHomestays();
          return;
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          return;
        }
      });
    } catch (e) {
      print(e.toString());
    }
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
}
