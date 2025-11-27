import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/routes/app_routes.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          AppRoutes.router.push(purchasedProductsView);
        }
      },
    );
  }

  Future<void> showPaymentSuccessNotification({
    required String productName,
    required String productId,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'payment_channel_id',
          'Payment Notifications',
          channelDescription: 'Notifications for successful payments',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Payment Successful!',
      'You have purchased $productName.',
      notificationDetails,
      payload: productId,
    );
  }
}
