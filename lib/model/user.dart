class User {
  String? name;
  String? uid;
  String? image;
  String? email;
  String? youtube;
  String? facebook;
  String? twitter;
  String? instagram;

  User(
      {this.name,
        this.uid,
        this.image,
        this.email,
        this.youtube,
        this.facebook,
        this.twitter,
        this.instagram});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    email = json['email'];
    youtube = json['youtube'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uid'] = this.uid;
    data['image'] = this.image;
    data['email'] = this.email;
    data['youtube'] = this.youtube;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    return data;
  }
}