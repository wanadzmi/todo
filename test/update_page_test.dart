import 'package:flutter_test/flutter_test.dart';
import 'package:todo/screens/update_page.dart';

void main() {
  test('Empty title return error message', () {
    var result = UpdateTitleValidator.validate('');
    expect(result, 'Title can\'t be empty');
  });

  test("Non-Empty title return null", () {
    var result = UpdateTitleValidator.validate('Title');
    expect(result, null);
  });
}
