import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? passwordEncrypted;

  UserModel({
    required this.username,
    required this.passwordEncrypted,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    passwordEncrypted = json["passwordEncrypted"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["username"] = username;
    data["passwordEncrypted"] = passwordEncrypted;

    return data;
  }

  factory UserModel.fromDocument(Map<String, dynamic> document) {
    return UserModel(
      username: document['username'],
      passwordEncrypted: document['passwordEncrypted'],
    );
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      username: data['username'],
      passwordEncrypted: data['passwordEncrypted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "passwordEncrypted": passwordEncrypted,
    };
  }
}
