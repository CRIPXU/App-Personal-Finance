import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification{

  final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  initialize()async{
    AndroidInitializationSettings _androidInit =
        const AndroidInitializationSettings('@mipmap/big');

    InitializationSettings initiSetting = InitializationSettings(
      android: _androidInit,
    );

    await _plugin.initialize(initiSetting);
  }

  dailyNotification(int hour, int minute)async{
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    tz.TZDateTime utcTime = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      utcTime.year,
      utcTime.month,
      utcTime.day,
      hour,
      minute
    );

    print('${utcTime.hour}');
    
    if (scheduleDate.isBefore(utcTime)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    var bifImage =
    const BigPictureStyleInformation(DrawableResourceAndroidBitmap('@mipmap/pie'),
    largeIcon: DrawableResourceAndroidBitmap('@mipmap/big'),
      contentTitle: 'Es hora de registrar Gastos',
      summaryText: 'No olvídes registrar los gastos de tu día',
      htmlFormatContent: true,
      htmlFormatContentTitle: true
    );

    var _androidDetails = AndroidNotificationDetails(
        '1',
       'name',
      styleInformation: bifImage
    );

    var _notification = NotificationDetails(
      android: _androidDetails
    );



    await _plugin.zonedSchedule(
        1,
        'LLego el momento',
        'No olvides requistrar tus gastos',
        scheduleDate,
        _notification,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time
    );
  }

  cancelNotificaction()async{
    await _plugin.cancelAll();
  }
}