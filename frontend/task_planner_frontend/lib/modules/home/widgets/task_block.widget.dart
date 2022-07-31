import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_planner_frontend/app/routes/app.routes.dart';
import 'package:task_planner_frontend/app/shared/colors.dart';
import 'package:task_planner_frontend/app/shared/text_style.dart';
import 'package:task_planner_frontend/modules/home/models/tasks.model.dart';

class TaskBlock extends StatelessWidget {
  final TaskData taskData;
  const TaskBlock({Key? key, required this.taskData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return GestureDetector(
      onTap: () {
        TaskData data = taskData;
        Navigator.pushReplacementNamed(context, AppRoutes.taskDetailsRoute,
            arguments: data);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 5,
          shadowColor: KConstantColors.violetColor,
          child: ListTile(
              tileColor: KConstantColors.bgColorFaint,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      taskData.taskTitle,
                      style: KCustomTextStyle.kBold(context, 16),
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    backgroundColor: statusColor(),
                    label: Text(
                      taskData.taskStatus,
                      style: KCustomTextStyle.kBold(context, 16),
                    ),
                  ),
                  AwesomeDimensions.hSizedBox2,
                  Text(
                    DateFormat.MMMd()
                        .format(DateTime.parse(taskData.taskScheduledAt)),
                    style: KCustomTextStyle.kMedium(context, 8),
                  ),
                ],
              ),
              subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskData.taskDescription,
                      style: KCustomTextStyle.kMedium(context, 8),
                    ),
                    AwesomeDimensions.vSizedBox2,
                    Row(children: [
                      const CircleAvatar(
                        radius: 16,
                        child: FlutterLogo(),
                      ),
                      AwesomeDimensions.vSizedBox2,
                      Text("1 Member",
                          style: KCustomTextStyle.kBold(context, 8)),
                    ]),
                    SizedBox(
                      height: 150,
                      width: 400,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: taskData.taskCategories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Chip(
                                backgroundColor:
                                    KConstantColors.darkColor.withOpacity(0.5),
                                label: Text(
                                  taskData
                                      .taskCategories[index].taskCategoryTitle,
                                  style: KCustomTextStyle.kMedium(context, 8),
                                ),
                              ),
                            );
                          }),
                    ),
                    AwesomeDimensions.vSizedBox1,
                    Text(
                      "Created at : ${DateFormat.MMMd().format(DateTime.parse(taskData.taskCreatedAt))}",
                      style: KCustomTextStyle.kMedium(context, 8),
                    ),
                    AwesomeDimensions.vSizedBox1,
                    if (taskData.taskIsArchived)
                      Chip(
                          backgroundColor: Colors.red,
                          label: Text("Archived",
                              style: KCustomTextStyle.kMedium(context, 8))),
                  ])),
        ),
      ),
    );
  }
}
