import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/pages/authentication/logout.dart';
import 'package:flutter_web_dashboard/pages/map/map.dart';
import 'package:flutter_web_dashboard/pages/overview/overview.dart';
import 'package:flutter_web_dashboard/pages/registration/registration.dart';
import 'package:flutter_web_dashboard/pages/ride%20management/ride.dart';
import 'package:flutter_web_dashboard/pages/services/services.dart';
import 'package:flutter_web_dashboard/pages/setting/Setting.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {PointerDeviceKind.mouse},
              ),
              theme: ThemeData(
                scaffoldBackgroundColor: light,
                colorScheme: const ColorScheme.light(primary: ecosperity),
              ),
              home: MyHomePage(),
            );
          }
          return CircularProgressIndicator();
        });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool darkMode = false;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            minWidth: 60,
            elevation: 30,
            groupAlignment: 0.0,
            backgroundColor: Color.fromARGB(255, 21, 50, 58),
            labelType: NavigationRailLabelType.none,
            selectedIconTheme:
                IconThemeData(color: Colors.tealAccent, size: 30),
            unselectedIconTheme:
                IconThemeData(color: Colors.tealAccent, opacity: 0.5, size: 30),
            leading: Image.asset(
              'assets/icons/logo.png',
              scale: 2,
              color: Colors.tealAccent,
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute (
                        builder: (BuildContext context) => Logout(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.tealAccent,
                  )),
            ),
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Tooltip(
                  message: "Dashboard",
                  textStyle: TextStyle(fontSize: 13, color: Colors.white),
                  // verticalOffset: -15.0,
                  height: 30,
                  // margin: EdgeInsets.only(left: 35),
                  decoration: BoxDecoration(
                    color: ecosperity,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Icon(
                    Icons.dashboard,
                  ),
                ),
                selectedIcon: Tooltip(
                  message: "Dashboard",
                  textStyle: TextStyle(fontSize: 13, color: Colors.white),
                  // verticalOffset: -15.0,
                  height: 30,
                  // margin: EdgeInsets.only(left: 35),
                  decoration: BoxDecoration(
                    color: ecosperity,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Icon(
                    Icons.dashboard,
                  ),
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.location_on,
                ),
                selectedIcon: Icon(
                  Icons.location_on,
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.app_registration,
                ),
                selectedIcon: Icon(
                  Icons.app_registration,
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.home_repair_service,
                ),
                selectedIcon: Icon(
                  Icons.home_repair_service,
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.local_atm,
                ),
                selectedIcon: Icon(
                  Icons.local_atm,
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.route,
                ),
                selectedIcon: Icon(
                  Icons.route,
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.settings,
                ),
                selectedIcon: Icon(
                  Icons.settings,
                ),
                label: Text(''),
              ),
            ],
          ),
          Expanded(
            child: MediaQuery.of(context).size.width > 1200
                ? Stack(
                    children: [
                      _buildOffstageNavigator(0),
                      _buildOffstageNavigator(1),
                      _buildOffstageNavigator(2),
                      _buildOffstageNavigator(3),
                      _buildOffstageNavigator(4),
                      _buildOffstageNavigator(5),
                      _buildOffstageNavigator(6),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Please open this web panel in large window",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
          )
        ],
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          OverviewPage(),
          GMap(),
          Registration(),
          Services(),
          Rides(),
          Rides(),
          SettingPage(
            title: '',
          )
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }
}
