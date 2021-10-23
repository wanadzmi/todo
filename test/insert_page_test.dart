import 'package:flutter_test/flutter_test.dart';
import 'package:todo/screens/insert_page.dart';

void main() {
  test('Empty title return error message', () {
    var result = InsertTitleValidator.validate('');
    expect(result, 'Title can\'t be empty');
  });

  test("Non-Empty title return null", () {
    var result = InsertTitleValidator.validate('Title');
    expect(result, null);
  });

  test('Empty start date return error message', () {
    var result = InsertStartDateValidator.validate(null);
    expect(result, 'Start Date can\'t be empty');
  });

  test("Non-Empty start date return null", () {
    var result = InsertStartDateValidator.validate(DateTime.now());
    expect(result, null);
  });

  test('Empty end date return error message', () {
    var result = InsertEndDateValidator.validate(null);
    expect(result, 'End Date can\'t be empty');
  });

  test("Non-Empty end date return null", () {
    var result = InsertEndDateValidator.validate(DateTime.now());
    expect(result, null);
  });
}
