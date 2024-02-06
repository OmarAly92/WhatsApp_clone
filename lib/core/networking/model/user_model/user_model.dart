import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final bool isOnline;
  final int lastActive;
  final String name;
  final String profilePicture;
  final String email;
  final String phoneNumber;
  final String userId;
  final String pushToken;

  const UserModel({
    required this.isOnline,
    required this.lastActive,
    required this.userId,
    required this.pushToken,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  factory UserModel.fromQueryDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return UserModel(
      isOnline: json['isOnline'],
      lastActive: json['lastActive'],
      userId: json['userId'],
      name: json['userName'],
      email: json['userEmail'] ?? '',
      phoneNumber: json['userPhone'],
      profilePicture: json['profileImage'],
      pushToken: json['pushToken'] ,
    );
  }

  factory UserModel.fromQuerySnapshot(QuerySnapshot<Map<String, dynamic>> document) {
    final json = document.docs.first;
    return UserModel(
      isOnline: json['isOnline'],
      lastActive: json['lastActive'],
      userId: json['userId'],
      name: json['userName'],
      email: json['userEmail'] ?? '',
      phoneNumber: json['userPhone'],
      profilePicture: json['profileImage'],
      pushToken: json['pushToken'] ,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      isOnline: json['isOnline'],
      lastActive: json['lastActive'] ?? 0,
      userId: json['userId'],
      name: json['userName'],
      email: json['userEmail'] ?? '',
      phoneNumber: json['userPhone'],
      profilePicture: json['profileImage'],
      pushToken: json['pushToken'] ,
    );
  }

  @override
  List<Object> get props => [
        isOnline,
        userId,
        name,
        phoneNumber,
        profilePicture,
        lastActive,
        email,
      ];
}
