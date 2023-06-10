class Constants {
  static const int connectionTimeOut = 900000;
  static const String fcmBaseUrl = "https://fcm.googleapis.com";
  static const String fcmKey = "key=AAAAbOtUPxI:APA91bFUZnED8HkWXMVMHXK4bN1En5CXzwDNjGzTB7JPX0V1R7eI-rQtqOL6gS0ZkXE4p3QcP5jRSC15uaemV9XqqN-hwcme8hFrgDtnZg1QOXVY5tZ5mUX4f4_ME1w9sIuj6KFHYdtw";
  static const String fcm = "/fcm/send";

}

class RegexValidator {
  // static final String emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String emailRegex = r'^([A-Za-z0-9]+[.-_])*[A-Za-z0-9]+@[A-Za-z0-9-]+(\.[A-Z|a-z]{2,})';
  static const String nameRegex = r'^[a-z A-Z,.\-]+$';
}