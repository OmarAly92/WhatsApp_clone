import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final bool isOnline;
  final Timestamp lastSeen;
  final String userName;
  final String profilePicture;
  final String userEmail;
  final String userPhone;
  final String userId;
  final String pushToken;

  const UserModel({
    required this.isOnline,
    required this.lastSeen,
    required this.userId,
    required this.pushToken,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.profilePicture,
  });

  // QuerySnapshot
  factory UserModel.fromQueryDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return UserModel(
      isOnline: json['isOnline'],
      lastSeen: json['lastSeen'],
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'] ?? '',
      userPhone: json['userPhone'],
      profilePicture: json['profileImage'],
      pushToken: json['pushToken'] ?? '',
    );
  }

  factory UserModel.fromQuerySnapshot(QuerySnapshot<Map<String, dynamic>> document) {
    final json = document.docs.first;
    return UserModel(
      isOnline: json['isOnline'],
      lastSeen: json['lastSeen'],
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'] ?? '',
      userPhone: json['userPhone'],
      profilePicture: json['profileImage'],
      pushToken: json['pushToken'] ?? '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      isOnline: json['isOnline'],
      lastSeen: json['lastSeen'] ?? Timestamp(0, 0),
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'] ?? '',
      userPhone: json['userPhone'],
      profilePicture: json['profileImage'],
      pushToken: json['pushToken'] ?? '',
    );
  }

  @override
  List<Object> get props => [
        isOnline,
        lastSeen,
        userId,
        userName,
        userEmail,
        userPhone,
        profilePicture,
      ];
}
