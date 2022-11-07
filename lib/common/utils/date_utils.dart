import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension DateUtilsExtention on DateTime {
  String toNormalDateFormat() {
    return formatDate(
      this,
      [dd, '/', mm, '/', yyyy],
    );
  }

  String toFullDateFormat(
    BuildContext context,
  ) {
    return formatDate(
      this,
      [HH, ':', nn, ', ', DD, ' ', dd, '/', mm],
      locale: Localizations.localeOf(context).languageCode == 'en'
          ? const EnglishDateLocale()
          : const VietnameseDateLocale(),
    );
  }

  String toDayMonthFormat() {
    return formatDate(
      this,
      [dd, '/', mm],
    );
  }

  String toHourMinuteFormat(BuildContext context) {
    return formatDate(
      this,
      [HH, ':', nn],
      locale: Localizations.localeOf(context).languageCode == 'en'
          ? const EnglishDateLocale()
          : const VietnameseDateLocale(),
    );
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

}
