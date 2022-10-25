import 'package:exp_app/providers/shared_pref.dart';
import 'package:exp_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({Key? key}) : super(key: key);

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool value = false;
  final  prefs = UsePrefs();

  @override
  void initState() {
    super.initState();
    value = prefs.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        value: value,
        title: const Text(
          'Modo Obscuro',
          style: TextStyle(fontSize: 14.0),
        ),
        subtitle: const Text('El modo obcuro ayuda ahorrar energia'),
        onChanged: (_value) {
          setState(() {
            value = _value;
            prefs.darkMode = value;
            context.read<ThemeProvider>().swapTheme();
          });
        });
  }
}
