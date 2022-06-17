// ignore_for_file: unnecessary_this



class AppUser {
  String? uid;
  String? fullName;
  String? mobileNumber;
  String? email;
  String? password;
  String? confirmPassword;



  AppUser(
      {this.uid,
        this.fullName,
        this.mobileNumber,
        this.email,
        this.password,
        this.confirmPassword,

      });

  AppUser.fromJson(Map<String, dynamic> json, id) {
    uid = id;
    fullName = json['fullName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = this.uid;
    data['fullName'] = this.fullName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['password'] = this.password;

    return data;
  }
}
