import 'dart:developer';
import 'package:flutter_test/flutter_test.dart';
import 'package:letsdo/screens/createAccountScreen.dart';

//Unit Testing Example

void main() {
  test('empty username', () {
    var result = UsernameValidator.validate('');
    expect(result, 'Username can\'t be empty');
  });

  test('Non empty username', () {
    var result = UsernameValidator.validate('swarup');
    expect(result, null);
  });

  test('empty password', () {
    var result = PasswordValidator.validate('');
    expect(result, 'Password can\'t be empty');
  });

  test('Non empty password', () {
    var result = PasswordValidator.validate('12345678');
    expect(result, null);
  });
}
//Unit Testing Example
