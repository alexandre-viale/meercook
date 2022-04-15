import 'dart:convert';

import 'package:http/http.dart';
import 'package:meercook/environment.dart';
import 'package:meercook/model/storer.dart';

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? userName;
  String? accessToken;
  String? password;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.userName,
    this.accessToken,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        userName: json['userName'] as String,
        accessToken: json['accessToken'] as String,
        password: json['password'] as String,
      );

  toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'accessToken': accessToken,
      'password': password,
    };
  }

  login() async {
    final url = Uri(
        host: Environment.apiHost,
        port: Environment.apiPort,
        path: '${Environment.apiPath}/user/login',
        scheme: 'http');
    try {
      final response = await post(url, body: {
        'emailOrUserName': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        final Map res = jsonDecode(response.body);
        id = res['user']['id'];
        email = res['user']['email'];
        firstName = res['user']['firstname'];
        lastName = res['user']['lastname'];
        userName = res['user']['username'];
        accessToken = res['accessToken'];
        password = null;
        await Storer.setAccessToken(accessToken ?? '');
      }
      return response.statusCode;
    } catch (e) {
      rethrow;
    }
  }
}
