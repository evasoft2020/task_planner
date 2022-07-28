import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_planner_frontend/app/routes/app.routes.dart';
import 'package:task_planner_frontend/app/shared/colors.dart';
import 'package:task_planner_frontend/app/shared/text_style.dart';
import 'package:task_planner_frontend/modules/home/models/tasks.model.dart';
import 'package:task_planner_frontend/modules/home/notifier/task.notifier.dart';
import 'package:task_planner_frontend/modules/home/views/update_task.view.dart';

class TaskDetailsView extends StatelessWidget {
  final TaskData taskData;
  const TaskDetailsView({Key? key, required this.taskData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier({required bool renderUI}) =>
        Provider.of<TaskNotifier>(context, listen: renderUI);

    Color statusColor() {
      switch (taskData.taskStatus) {
        case "To do":
          return Colors.green;
        case "Start":
          return Colors.blue;

        default:
          return Colors.red;
      }
    }

    commonButton({required String title}) {
      return AwesomeButton.roundedIconButton(
          backgroundColor: Colors.blue,
          width: 100,
          height: 40,
          titleTextstyle: KCustomTextStyle.kMedium(context, 10),
          onTap: () async {
            if (title == taskData.taskStatus) {
              bool status = await taskNotifier(renderUI: false).setTaskStatus(
                  context: context, taskId: taskData.taskId, taskStatus: title);
              if (status) {
                Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
              }
            }
          },
          title: title);
    }

    _changeStatusBottomSheet() {
      return showModalBottomSheet(
          context: context,
          backgroundColor: KConstantColors.bgColor,
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AwesomeDimensions.vSizedBox3,
                commonButton(title: "To do"),
                AwesomeDimensions.vSizedBox3,
                commonButton(title: "Start"),
                AwesomeDimensions.vSizedBox3,
                commonButton(title: "End"),
              ],
            );
          });
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: KConstantColors.bgColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
            },
            icon: const Icon(Icons.arrow_back_ios, size: 16),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.updateTaskRoute,
                  arguments: UpdateTaskArguments(
                      taskId: taskData.taskId,
                      oldTaskTitle: taskData.taskTitle,
                      oldTaskDescription: taskData.taskDescription),
                );
              },
              icon: const Icon(Icons.edit, size: 16),
            ),
          ],
          title:
              Text("Task Details", style: KCustomTextStyle.kBold(context, 14)),
          backgroundColor: KConstantColors.bgColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AwesomeDimensions.vSizedBox1,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  taskData.taskTitle,
                  maxLines: 2,
                  style: KCustomTextStyle.kBold(context, 20),
                ),
                const Spacer(),
                Text(
                  DateFormat.MMMd()
                      .format(DateTime.parse(taskData.taskScheduledAt)),
                  style: KCustomTextStyle.kBold(context, 8),
                ),
                AwesomeDimensions.hSizedBox2,
              ],
            ),
            ActionChip(
                backgroundColor: statusColor(),
                onPressed: () {
                  _changeStatusBottomSheet();
                },
                label: Text(taskData.taskStatus,
                    style: KCustomTextStyle.kMedium(context, 8))),
            Text(
              taskData.taskDescription,
              style: KCustomTextStyle.kMedium(context, 8),
            ),
            AwesomeDimensions.vSizedBox2,
            SizedBox(
              width: 200,
              height: 50,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Chip(
                      label: Text(
                        taskData.taskCategories[index].taskCategoryTitle,
                        style: KCustomTextStyle.kMedium(context, 8),
                      ),
                    );
                  },
                  itemCount: taskData.taskCategories.length),
            ),
            AwesomeDimensions.vSizedBox3,
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AwesomeButton.roundedIconButton(
                      backgroundColor: Colors.red,
                      width: 200,
                      height: 40,
                      titleTextstyle: KCustomTextStyle.kMedium(context, 10),
                      onTap: () async {
                        bool status =
                            await taskNotifier(renderUI: false).deleteTask(
                          context: context,
                          taskId: taskData.taskId,
                        );
                        if (status) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.homeRoute);
                        }
                      },
                      title: "Delete"),
                  AwesomeButton.roundedIconButton(
                      backgroundColor: Colors.blue,
                      width: 200,
                      height: 40,
                      titleTextstyle: KCustomTextStyle.kMedium(context, 10),
                      onTap: () async {
                        bool status = await taskNotifier(renderUI: false)
                            .setArchivedTask(
                                context: context,
                                taskId: taskData.taskId,
                                taskStatus: !taskData.taskIsArchived);
                        if (status) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.homeRoute);
                        }
                      },
                      title: taskData.taskIsArchived ? "UnArchive" : "Archive"),
                ],
              ),
            )
          ],
        ));
  }
}
