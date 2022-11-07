import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_list/data/models/todo.dart';
import 'package:todo_list/presentation/extentions/component_extention.dart';
import 'package:todo_list/theme/theme_color.dart';
import '../../../../../common/utils/date_utils.dart';

class AddTodoForm extends StatefulWidget {
  final dynamic trans;
  final TextTheme textTheme;
  const AddTodoForm({
    super.key,
    this.trans,
    required this.textTheme,
  });

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late TextEditingController _timeController;
  final _dateController =
      TextEditingController(text: DateTime.now().toDayMonthFormat());
  final _titleValidation = ValueNotifier<bool?>(null);
  DateTime selectedDate = DateTime.now().add(const Duration(minutes: 1));

  @override
  Widget build(BuildContext context) {
    _timeController =
        TextEditingController(text: selectedDate.toHourMinuteFormat(context));
    return AlertDialog(
      content: SizedBox(
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: widget.trans.title,
                style: widget.textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: widget.textTheme.bodyText1?.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ValueListenableBuilder(
              valueListenable: _titleValidation,
              builder: (context, value, child) => TextField(
                style: widget.textTheme.bodyText2?.copyWith(
                  fontSize: 16,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _titleValidation.value = true;
                  } else {
                    _titleValidation.value = false;
                  }
                },
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: themeColor.primaryColorLight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor.red, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  errorText: _titleValidation.value == null
                      ? null
                      : _titleValidation.value == true
                          ? null
                          : 'Vui lòng nhập tiêu đề',
                  errorStyle: _titleValidation.value == false
                      ? null
                      : const TextStyle(
                          color: Colors.transparent,
                          fontSize: 0,
                        ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: themeColor.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: themeColor.primaryColorLight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                controller: _titleController,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.trans.description,
              style: widget.textTheme.bodyText1?.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: themeColor.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: themeColor.primaryColorLight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              controller: _descriptionController,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.trans.selectTime,
              style: widget.textTheme.bodyText1?.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onTap: () => _onPickTime(context),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: themeColor.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: themeColor.primaryColorLight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignLabelWithHint: true,
                        hintStyle: widget.textTheme.bodyText2?.copyWith(
                          color: themeColor.gray8C,
                          fontSize: 16,
                        ),
                        hintText: DateTime.now().toHourMinuteFormat(context),
                      ),
                      controller: _timeController,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onTap: () => _onPickDate(context),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: themeColor.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: themeColor.primaryColorLight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignLabelWithHint: true,
                        hintStyle: widget.textTheme.bodyText2?.copyWith(
                          color: themeColor.gray8C,
                          fontSize: 16,
                        ),
                        hintText: _dateController.text,
                      ),
                      controller: _dateController,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: _onAddTodo,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: themeColor.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.trans.addTodo,
                  style: widget.textTheme.bodyText1?.copyWith(
                    fontSize: 16,
                    color: themeColor.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPickTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    ).then((value) {
      _timeController.text =
          value?.format(context) ?? selectedDate.toHourMinuteFormat(context);
      selectedDate = selectedDate.copyWith(
        minute: value?.minute,
        hour: value?.hour,
      );
    });
  }

  void _onPickDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    ).then(
      (value) {
        selectedDate = selectedDate.copyWith(
          day: value?.day,
          month: value?.month,
          year: value?.year,
        );
        _dateController.text = selectedDate.toDayMonthFormat();
      },
    );
  }

  void _onAddTodo() {
    if (_titleValidation.value == false || _titleValidation.value == null) {
      _titleValidation.value = false;
      return;
    }

    Navigator.pop(
      context,
      Todo(
        title: _titleController.text,
        description: _descriptionController.text,
        deadline: selectedDate,
      ),
    );
  }
}
