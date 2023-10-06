import 'package:contacts_service/contacts_service.dart';

import '../../data/model/user_model/user_model.dart';

abstract class Filtering {
  static Set<String> extractContactsPhoneNumbers(List<Contact> contacts) {
    return contacts
        .where(
            (contact) => contact.phones != null && contact.phones!.isNotEmpty)
        .map((contact) => contact.phones![0].value!.replaceAll(' ', ''))
        .toSet();
  }

  static Set<String> extractUserPhoneNumbers(List<UserModel> userPhoneNumbers) {
    return userPhoneNumbers
        .map((userModel) => userModel.userPhone.replaceAll(' ', ''))
        .toSet();
  }

  static Set<String> findCommonPhoneNumbers(
      Set<String> contactsPhoneNumbers, Set<String> userPhoneNumbersSet) {
    return contactsPhoneNumbers.intersection(userPhoneNumbersSet);
  }

  static List<UserModel> filterUserPhoneNumber(List<UserModel> userPhoneNumber,
      Set<String> commonPhoneNumbers, String phone) {
    return userPhoneNumber
        .where((userModel) => commonPhoneNumbers
            .contains(userModel.userPhone.replaceAll(' ', '')))
        .toList();
  }
}
