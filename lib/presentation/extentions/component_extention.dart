import 'package:flutter/material.dart';

extension DiacriticsAwareString on String {
  static const diacritics =
      'àáâãèéêếìíòóôõùúăđĩũơưăạảấầẩẫậắằẳẵặẹẻẽềềểễệỉịọỏốồổỗộớờởỡợụủứừửữựỳỵỷỹ';
  static const nonDiacritics =
      'aaaaeeeeiioooouuadiuouaaaaaaaaaaaaaeeeeeeeeiioooooooooooouuuuuuuyyyy';

  String get removeDiacritics => splitMapJoin('',
      onNonMatch: (char) => char.isNotEmpty && diacritics.contains(char)
          ? nonDiacritics[diacritics.indexOf(char)]
          : char);
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay add({int hour = 0, int minute = 0}) {
    return replacing(
      hour: hour + hour,
      minute: minute + minute,
    );
  }
}
