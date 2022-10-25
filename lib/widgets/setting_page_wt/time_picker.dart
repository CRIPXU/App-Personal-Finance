import 'package:exp_app/providers/local_notification.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

import '../../providers/shared_pref.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final _prefs = UsePrefs();
  final _notifs = LocalNotification();

  bool _isEnable = false;

  String _title = 'Activar notificaciónes';

  @override
  Widget build(BuildContext context) {
    final DateTime getDate = DateTime.now();
    String currentTime;

    if (_prefs.hour != 99) {
      final DateTime getTime = DateTime(
          getDate.year, getDate.month, getDate.day, _prefs.hour, _prefs.minute);
      currentTime = DateFormat.jm().format(getTime);
      _title = 'Desactivar Notificaciones';
      _isEnable = true;
    } else {
      currentTime = 'Desactivado';
      _title = 'Activar Notificaciones';
      _isEnable = false;
    }

    _cancelarNotificaciones(bool value) {
      if (value == true) {
        _prefs.hour = 21;
        _prefs.minute = 30;
        _notifs.dailyNotification(21, 30);

      } else {
        _prefs.deleteTime();
        _notifs.cancelNotificaction();
      }
    }

    return Column(
      children: [
        SwitchListTile(
            value: _isEnable,
            title: Text(_title),
            onChanged: (value) {
              setState(() {
                _isEnable = value;
                _cancelarNotificaciones(value);
              });
            }),
        ListTile(
          enabled: _isEnable,
          leading: (_isEnable)
              ? const Icon(
                  Icons.notifications_active_outlined,
                  size: 35.0,
                )
              : const Icon(
                  Icons.notifications_off_outlined,
                  size: 35.0,
                ),
          title: const Text('Recordatorio Diario'),
          subtitle: Text(currentTime),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: () {
            _selectedTime();
          },
        ),
      ],
    );
  }

  _selectedTime() {
    int? _hour;
    int? _minute;

    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: false,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 350.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TimePickerSpinner(
                  time: DateTime.now(),
                  is24HourMode: false,
                  isForce2Digits: true,
                  spacing: 60,
                  itemWidth: 60,
                  itemHeight: 90,
                  normalTextStyle: const TextStyle(
                    fontSize: 30,
                  ),
                  highlightedTextStyle: const TextStyle(
                    fontSize: 38,
                    color: Colors.green,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                  onTimeChange: (time) {
                    setState(() {
                      _hour = time.hour;
                      _minute = time.minute;
                      print(_hour);
                    });
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Constants.customButton(
                          Colors.transparent,
                          Colors.red,
                          'Cancelar',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Constants.customButton(
                          Colors.green,
                          Colors.transparent,
                          'Aceptar',
                        ),
                        onTap: () {
                          setState(() {
                            _notifs.dailyNotification(
                                _hour!,
                                _minute!
                            );
                            _prefs.hour = _hour!;
                            _prefs.minute = _minute!;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
