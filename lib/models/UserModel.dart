import 'dart:convert';

class RegisterUserModel {
  String username;
  String email;
  String mobileNumber;
  String password;

  RegisterUserModel({
    required this.username,
    required this.email,
    required this.mobileNumber,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'mobile_number': mobileNumber,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}

class LoginUserModel {
  String mobileNumberOrEmail;
  String password;

  LoginUserModel({
    required this.mobileNumberOrEmail,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email_or_mobile_number': mobileNumberOrEmail,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}

class UserModel {
  int id;
  String username;
  String email;
  String mobileNumber;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.mobileNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'mobile_number': mobileNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      mobileNumber: map['mobile_number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
