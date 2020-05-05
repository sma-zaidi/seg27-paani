import 'package:flutter/material.dart';
import 'package:paani/screens/companysideapp/Companyeditprofile.dart';
import 'package:paani/screens/companysideapp/new_requests_screen.dart';
import 'package:paani/screens/companysideapp/in_progress.dart';
import 'package:paani/screens/companysideapp/completedorders.dart';
import 'package:paani/screens/companysideapp/ViewDrivers.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:paani/screens/home_screen.dart';
// import 'package:http/http.dart' as http;

class DrawerDetails extends StatefulWidget {
  @override
  DrawerDetailsState createState() => new DrawerDetailsState();
}

class DrawerDetailsState extends State<DrawerDetails> {
  Future<String> getname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name = pref.getString("username");
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getname(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Drawer(
              child: SingleChildScrollView(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //profile
                    new Container(
                      width: double.infinity, //expand for the entire drawer
                      padding: EdgeInsets.all(20),
                      color: Colors.teal,
                      child: new Center(
                        child: Column(
                          children: <Widget>[
                            //image
                            new Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(top: 30, bottom: 10),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    image: new AssetImage(
                                        'assets/user-profile.jpg'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            new Text(
                              '${snapshot.data}',
                              style:
                                  TextStyle(fontSize: 19, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: Icon(Icons.home),
                      title: Text(
                        'Home',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/companyhomescreen', (_) => false);
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        'Profile',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CompanyEditProfileScreen()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.playlist_add),
                      title: Text(
                        'New Requests',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NewReqs()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.timelapse),
                      title: Text(
                        'In Progress',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InProgress()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.done_outline),
                      title: Text(
                        'Completed',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompletedOrders()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text(
                        'Drivers',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DriversScreen()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.feedback),
                      title: Text(
                        'Feedback',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: null,
                    ),
                    new ListTile(
                      leading: Icon(Icons.question_answer),
                      title: Text(
                        'FAQs',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: null,
                    ),
                    new ListTile(
                      leading: Icon(Icons.library_books),
                      title: Text(
                        'Terms & Conditions',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: null,
                    ),
                    new ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text(
                        'Logout',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.clear();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Drawer(
              child: SingleChildScrollView(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //profile
                    new Container(
                      width: double.infinity, //expand for the entire drawer
                      padding: EdgeInsets.all(20),
                      color: Colors.teal,
                      child: new Center(
                        child: Column(
                          children: <Widget>[
                            //image
                            new Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(top: 30, bottom: 10),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    image: new AssetImage(
                                        'assets/user-profile.jpg'),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            new Text(
                              'User Name',
                              style:
                                  TextStyle(fontSize: 19, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: Icon(Icons.home),
                      title: Text(
                        'Home',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/companyhomescreen', (_) => false);
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        'Profile',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CompanyEditProfileScreen()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.playlist_add),
                      title: Text(
                        'New Requests',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NewReqs()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.timelapse),
                      title: Text(
                        'In Progress',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InProgress()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.done_outline),
                      title: Text(
                        'Completed',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompletedOrders()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text(
                        'Drivers',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DriversScreen()));
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.feedback),
                      title: Text(
                        'Feedback',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: null,
                    ),
                    new ListTile(
                      leading: Icon(Icons.question_answer),
                      title: Text(
                        'FAQs',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: null,
                    ),
                    new ListTile(
                      leading: Icon(Icons.library_books),
                      title: Text(
                        'Terms & Conditions',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: null,
                    ),
                    new ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text(
                        'Logout',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.clear();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}
