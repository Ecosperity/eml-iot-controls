import 'package:animated_background/animated_background.dart';
import 'package:animated_background/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';

class Logout extends StatefulWidget {
  @override
  _LoginThreeState createState() => _LoginThreeState();
}

class _LoginThreeState extends State<Logout>
    with SingleTickerProviderStateMixin {
  ParticleOptions particles = const ParticleOptions(
    baseColor: Colors.indigoAccent,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.2,
    particleCount: 70,
    spawnMaxRadius: 5.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 10,
    spawnMinRadius: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    // Color login = Color.fromARGB(255, 100, 151, 180);
    Color login = Colors.grey.shade600;
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/icons/logo_name3.png", scale: 1,),
              SizedBox(height: 100,),
              Container(
                alignment: AlignmentDirectional.center,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: 500,
                      height: 400,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                        color: login,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 90.0,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              cursorColor: Colors.white,
                              style: TextStyle(
                                  color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Email address",
                                  hintStyle: TextStyle(
                                      color: Colors.white),
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Container(
                            child: Divider(
                              color: Colors.tealAccent.shade100,
                            ),
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 10.0),
                          ),
                          Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextField(
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color:
                                            Colors.white),
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    )),
                              )),
                          Container(
                            child: Divider(
                              color: Colors.tealAccent.shade100,
                            ),
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: TextButton(
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -150,
                      child: Image.asset(
                        "assets/images/city1.gif",
                        scale: 1.2,
                        color: login,
                      ),
                    ),
                    Positioned(
                        top: -50,
                        child: Image.asset(
                          "assets/images/side5.png",
                          scale: 10,
                        )),
                    Positioned(
                      bottom: 10,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white),
                            // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(
                                    fontSize: 15,))),
                        child: Text("Login",
                            style: TextStyle(color: ecosperity, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
