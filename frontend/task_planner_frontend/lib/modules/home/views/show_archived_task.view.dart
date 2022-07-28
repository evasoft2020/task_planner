import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_planner_frontend/app/routes/app.routes.dart';
import 'package:task_planner_frontend/app/shared/colors.dart';
import 'package:task_planner_frontend/app/shared/text_style.dart';
import 'package:task_planner_frontend/modules/home/models/tasks.model.dart';
import 'package:task_planner_frontend/modules/home/notifier/task.notifier.dart';
import 'package:task_planner_frontend/modules/home/widgets/task_block.widget.dart';

class ShowArchivedTaskView extends StatelessWidget {
  const ShowArchivedTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier({required bool renderUI}) =>
        Provider.of<TaskNotifier>(context, listen: renderUI);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Archived Tasks',
          style: KCustomTextStyle.kBold(context, 12),
        ),
        backgroundColor: KConstantColors.bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 16),
        ),
      ),
      backgroundColor: KConstantColors.bgColor,
      body: FutureBuilder(
          future:
              taskNotifier(renderUI: false).fetchArchiveTask(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              List<TaskData> data = snapshot.data as List<TaskData>;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return TaskBlock(
                    taskData: data[index],
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No Data"),
              );
            }
          }),
    );
  }
}
