import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SettingPage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10.withAlpha(80)),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha(150).withOpacity(0.005),
            blurRadius: 50.0,
            spreadRadius: 0.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
        // color: Colors.white.withOpacity(0.2),
      ),
      child: SettingsList(
        lightTheme: SettingsThemeData(
          settingsListBackground: Colors.transparent,
        ),
          sections: [
            SettingsSection(
              margin: EdgeInsetsDirectional.all(20),
              title: Text('Section 1'),
              tiles: [
                SettingsTile(
                  title: Text('Language'),
                  description: Text('English'),
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: Text('Use System Theme'),
                  leading: Icon(Icons.phone_android),
                  initialValue: isSwitched,
                  onToggle: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            SettingsSection(
              margin: EdgeInsetsDirectional.all(20),
              title: Text('Section 2'),
              tiles: [
                SettingsTile(
                  title: Text('Security'),
                  description: Text('Fingerprint'),
                  leading: Icon(Icons.lock),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: Text('Use fingerprint'),
                  leading: Icon(Icons.fingerprint),
                  initialValue: isSwitched,
                  onToggle: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
    );
  }
}