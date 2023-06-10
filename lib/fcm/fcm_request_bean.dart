class FcmRequestBean {
  List<String>? registrationIds;
  String? priority;
  Notification? notification;
  Map<String, dynamic>? data;
  Android? android;
  Apns? apns;
  WebPush? webPush;

  FcmRequestBean({this.registrationIds, this.priority, this.notification, this.data, this.android, this.apns, this.webPush});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registration_ids'] = registrationIds;
    data['priority'] = priority;
    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!;
    }
    if (android != null) {
      data['android'] = android!.toJson();
    }
    if (apns != null) {
      data['apns'] = apns!.toJson();
    }
    if (webPush != null) {
      data['webpush'] = webPush!.toJson();
    }
    return data;
  }
}

class Notification {
  String? title;
  String? body;

  Notification({this.title, this.body});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}

class Android {
  String priority = "high";
  AndroidNotification? notification;

  Android.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    notification = json['notification'] != null ? AndroidNotification.fromJson(json['notification']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['priority'] = priority;
    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    return data;
  }
}

class AndroidNotification {
  String sound = "default";

  AndroidNotification.fromJson(Map<String, dynamic> json) {
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sound'] = sound;
    return data;
  }
}


class Apns {
  Payload? payload;
  Headers? headers;

  Apns({this.payload, this.headers});

  Apns.fromJson(Map<String, dynamic> json) {
    payload = json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    headers = json['headers'] != null ? Headers.fromJson(json['headers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    if (headers != null) {
      data['headers'] = headers!.toJson();
    }
    return data;
  }
}

class Payload {
  Aps? aps;

  Payload({this.aps});

  Payload.fromJson(Map<String, dynamic> json) {
    aps = json['aps'] != null ? Aps.fromJson(json['aps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (aps != null) {
      data['aps'] = aps!.toJson();
    }
    return data;
  }
}

class Aps {
  Notification? alert;
  String? sound = "default";
  bool? contentAvailable = true;
  int? mutableContent = 1;

  Aps({this.alert, this.sound, this.contentAvailable, this.mutableContent});

  Aps.fromJson(Map<String, dynamic> json) {
    alert = json['alert'] != null ? Notification.fromJson(json['alert']) : null;
    sound = json['sound'];
    contentAvailable = json['contentAvailable'];
    mutableContent = json['mutable-content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (alert != null) {
      data['alert'] = alert!.toJson();
    }
    data['sound'] = sound;
    data['contentAvailable'] = contentAvailable;
    data['mutable-content'] = mutableContent;
    return data;
  }
}

class Headers {
  String? apnsPushType = "background";
  String? apnsPriority = "5";
  String? apnsTopic = "io.flutter.plugins.firebase.messaging";
  int? mutableContent = 1;

  Headers({this.apnsPushType, this.apnsPriority, this.apnsTopic, this.mutableContent});

  Headers.fromJson(Map<String, dynamic> json) {
    apnsPushType = json['apns-push-type'];
    apnsPriority = json['apns-priority'];
    apnsTopic = json['apns-topic'];
    mutableContent = json['mutable-content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apns-push-type'] = apnsPushType;
    data['apns-priority'] = apnsPriority;
    data['apns-topic'] = apnsTopic;
    data['mutable-content'] = mutableContent;
    return data;
  }
}

class WebPush {
  WebHeaders? webHeaders;

  WebPush({this.webHeaders});

  WebPush.fromJson(Map<String, dynamic> json) {
    webHeaders = json['headers'] != null ? WebHeaders.fromJson(json['headers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (webHeaders != null) {
      data['headers'] = webHeaders!.toJson();
    }
    return data;
  }
}

class WebHeaders {
  String? image;

  WebHeaders({this.image});

  WebHeaders.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}

// class ApsParent {
//   Notification? alert;
//   String? sound;
//   bool? contentAvailable;
//   int? mutableContent;
//
//   ApsParent({this.alert, this.sound, this.contentAvailable, this.mutableContent});
//
//   ApsParent.fromJson(Map<String, dynamic> json) {
//     alert = json['alert'] != null ? Notification.fromJson(json['alert']) : null;
//     sound = json['sound'];
//     contentAvailable = json['contentAvailable'];
//     mutableContent = json['mutable-content'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (alert != null) {
//       data['alert'] = alert!.toJson();
//     }
//     data['sound'] = sound;
//     data['contentAvailable'] = contentAvailable;
//     data['mutable-content'] = mutableContent;
//     return data;
//   }
// }
