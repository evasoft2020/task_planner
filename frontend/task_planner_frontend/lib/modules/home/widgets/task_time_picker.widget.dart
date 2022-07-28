import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_planner_frontend/app/shared/text_style.dart';
import 'package:task_planner_frontend/modules/home/notifier/task.notifier.dart';

class TaskTimePickerWidget extends StatelessWidget {
  const TaskTimePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier({required bool renderUI}) =>
        Provider.of<TaskNotifier>(context, listen: renderUI);

    return SizedBox(
      width: 400,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: KCustomTextStyle.kMedium(
                  context,
                  10,
                ),
              ),
            ),
            child: CupertinoDatePicker(
              key: UniqueKey(),
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: taskNotifier(renderUI: true).selectedTaskTime ??
                  DateTime.now(),
              onDateTimeChanged: (DateTime date) {
                taskNotifier(renderUI: false).setTaskTime(value: date);
              },
              backgroundColor: Colors.transparent,
            )),
      ),
    );
  }
}
