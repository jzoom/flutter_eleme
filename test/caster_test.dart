import 'package:test/test.dart';

import 'package:flutter_eleme/utils/caster.dart';

void main() {
  test('Test caster', () {
    assert(Caster.to("#333", int) == 0xff333333);
  });
}
