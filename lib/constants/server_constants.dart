import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/models/todo.dart';
import '../theme/theme_color.dart';

enum TodoStatus { inProgress, completed, expired }

extension TodoStatusExt on TodoStatus {
  String localized(AppLocalizations trans) {
    switch (this) {
      case TodoStatus.inProgress:
        return trans.inProgress;
      case TodoStatus.completed:
        return trans.completed;
      case TodoStatus.expired:
        return trans.expired;
    }
  }

  Color get color {
    switch (this) {
      case TodoStatus.inProgress:
        return const Color(0xFF00AAFA);
      case TodoStatus.completed:
        return const Color(0xFF67C13C);
      case TodoStatus.expired:
        return themeColor.gray8C;
    }
  }

  LinearGradient get linearGradient {
    switch (this) {
      case TodoStatus.inProgress:
        return const LinearGradient(
          colors: [
            Color(0XFF4481EB),
            Color(0XFF04BEFE),
          ],
        );
      case TodoStatus.completed:
        return const LinearGradient(
          colors: [
            Color(0XFF0BA360),
            Color(0XFF7AC855),
          ],
        );
      case TodoStatus.expired:
        return const LinearGradient(
          colors: [
            Color(0XFFD3D3D3),
            Color(0XFFE0E0E0),
          ],
        );
    }
  }
}

enum DeadlineStatus { today, upcoming, all }

extension DeadlineEtx on Todo {
  Widget deadlineStatusText(
    dynamic trans,
    TextTheme textTheme,
  ) {
    final isToday = deadlineStatus == DeadlineStatus.today ? true : false;
    return Text(
      deadlineStatus.localized(trans),
      style: textTheme.bodyLarge?.copyWith(
        color: isToday ? themeColor.red : Colors.orange,
        fontSize: 14,
      ),
    );
  }

  void updateStatus() {
    if (deadline?.compareTo(DateTime.now()) == -1 &&
        status == TodoStatus.inProgress) {
      status = TodoStatus.expired;
    }
  }
}

extension DeadlineLocalization on DeadlineStatus {
  String localized(dynamic trans) {
    switch (this) {
      case DeadlineStatus.today:
        return trans.today;
      case DeadlineStatus.upcoming:
        return trans.upcoming;
      case DeadlineStatus.all:
        return trans.all;
    }
  }
}
