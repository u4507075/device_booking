// String capitalize(String string) {
//   if (string.isEmpty) {
//     return string;
//   }

//   return string[0].toUpperCase() + string.substring(1).toLowerCase();
// }

bool isPhoneNumber(String phoneNumber) {
  return RegExp(r'\+?[0-9]{10,11}').hasMatch(phoneNumber);
}

String formatPhoneNumber(String phoneNumber) {
  return (isPhoneNumber(phoneNumber))
      ? '0' + phoneNumber.substring(phoneNumber.length - 9)
      : '';
}
