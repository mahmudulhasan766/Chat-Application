import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  PushNotificationService(this._messaging);

  final FirebaseMessaging _messaging;

  Future<void> initialize() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);
    await _messaging.subscribeToTopic('chat_application');
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
