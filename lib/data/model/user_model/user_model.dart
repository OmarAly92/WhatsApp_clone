import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final bool isOnline;
  final String userId;
  final String userName;
  final String userPhone;
  final String profilePicture;

  const UserModel({
    required this.isOnline,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.profilePicture,
  });

  // QuerySnapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return UserModel(
      isOnline: json['isOnline'],
      userId: json['userId'],
      userName: json['userName'],
      userPhone: json['userPhone'],
      profilePicture: json['profileImage'],
    );
  }


  factory UserModel.fromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> document) {
    final json = document.docs.first;
    return UserModel(
      isOnline: json['isOnline'],
      userId: json['userId'],
      userName: json['userName'],
      userPhone: json['userPhone'],
      profilePicture: json['profileImage'],
    );
  }



  factory UserModel.fromJson(
     Map<String, dynamic> json) {
    return UserModel(
      isOnline: json['isOnline'],
      userId: json['userId'],
      userName: json['userName'],
      userPhone: json['userPhone'],
      profilePicture: json['profileImage'],
    );
  }

  @override
  List<Object> get props => [
        isOnline,
        userId,
        userName,
        userPhone,
        profilePicture,
      ];
}
