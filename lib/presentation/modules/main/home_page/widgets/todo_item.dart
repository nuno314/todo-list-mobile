import 'package:flutter/material.dart';
import 'package:todo_list/theme/theme_color.dart';

import '../../../../../data/models/todo.dart';
import '../../../../../constants/server_constants.dart';
import '../../../../../common/utils/date_utils.dart';

class TodoItem extends StatelessWidget {
  final Todo? todo;
  final TextTheme textTheme;
  final dynamic trans;
  final void Function() onRemove;
  final void Function() onDone;

  const TodoItem({
    super.key,
    this.todo,
    required this.textTheme,
    this.trans,
    required this.onRemove,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black12,
          ),
        ],
        color: themeColor.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: todo?.status?.color ?? themeColor.primaryColor,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 8,
              top: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              gradient: todo?.status?.linearGradient,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        todo?.title ?? '--',
                        style: textTheme.bodyText1?.copyWith(
                          color: themeColor.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          color: themeColor.white,
                        ),
                        child: Text(
                          todo?.status?.localized(trans) ?? trans.newTodo,
                          style: textTheme.bodyText1?.copyWith(
                            color: todo?.status?.color,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: themeColor.white,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    todo?.description ?? '--',
                    style: textTheme.bodyText2?.copyWith(
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (todo?.status == TodoStatus.inProgress) ...[
            Divider(
              color: todo?.status?.color,
              height: 10,
              thickness: 1,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo?.deadline?.toFullDateFormat(context) ?? '--',
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    children: [
                      todo!.deadlineStatusText(trans, textTheme),
                      const Spacer(),
                      IconButton(
                        onPressed: onDone,
                        icon: Icon(
                          Icons.done_outline,
                          color: TodoStatus.completed.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
