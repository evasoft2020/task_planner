import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_planner_frontend/app/routes/app.routes.dart';
import 'package:task_planner_frontend/app/shared/colors.dart';
import 'package:task_planner_frontend/app/shared/fonts.dart';
import 'package:task_planner_frontend/app/shared/text_style.dart';
import 'package:task_planner_frontend/modules/home/models/task_category.model.dart';
import 'package:task_planner_frontend/modules/home/notifier/task.notifier.dart';
import 'package:task_planner_frontend/modules/home/repository/task.network.dart';

import '../widgets/task_time_picker.widget.dart';

class CreateTaskView extends StatelessWidget {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  CreateTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier({required bool renderUI}) =>
        Provider.of<TaskNotifier>(context, listen: renderUI);

    return Scaffold(
      /* floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartDocked,
        floatingActionButton: AwesomeButton.roundedIconButton(
          width: 200,
          radius: 25,
          onTap: () async {
            List<int> ids =
                taskNotifier(renderUI: false).selectedTaskCategories;
            CreateTaskDto createTaskDto = CreateTaskDto(
                taskTitle: _taskTitleController.text,
                taskDescription: _taskDescriptionController.text,
                taskScheduleAt: taskNotifier(renderUI: false)
                    .selectedTaskTime!
                    .toIso8601String(),
                taskCategoryIds: ids);
            bool status = await taskNotifier(
              renderUI: false,
            ).createTask(context: context, createTaskDto: createTaskDto);

            if (status) {
              Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
            }
          },
          title: 'Create',
          titleTextstyle: KCustomTextStyle.kBold(context, 20),
          icon: const Icon(
            Icons.add,
            color: KConstantColors.whiteColor,
          ),
        ), */
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: KConstantColors.pinkColor),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, AppRoutes.homeRoute),
        ),
        centerTitle: true,
        backgroundColor: KConstantColors.bgColor,
        title: Text('Create Task',
            style: KConstantFonts.poppinsBold.copyWith(
              fontSize: 14,
              color: KConstantColors.pinkColor,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AwesomeDimensions.vSizedBox1,
          AwesomeTextfield.filled(
            textEditingController: _taskTitleController,
            fillColor: KConstantColors.bgColorFaint,
            width: 500,
            height: 60,
            hintText: 'Title',
          ),
          AwesomeTextfield.filled(
            textEditingController: _taskDescriptionController,
            fillColor: KConstantColors.bgColorFaint,
            width: 500,
            minLines: 10,
            maxLines: 12,
            hintText: 'Description',
          ),
          AwesomeDimensions.vSizedBox2,
          const TaskTimePickerWidget(),
          FutureBuilder(
              future: taskNotifier(renderUI: false)
                  .fetchTaskCategories(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  List<TaskCategoryData> data =
                      snapshot.data as List<TaskCategoryData>;
                  return Expanded(
                    child: Center(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2, crossAxisCount: 4),
                          itemBuilder: (context, index) {
                            int id = data[index].taskCategoryId;
                            return ActionChip(
                              onPressed: () {
                                taskNotifier(renderUI: false)
                                    .addToSelectedCategory(value: id);
                              },
                              backgroundColor: taskNotifier(renderUI: true)
                                      .selectedTaskCategories
                                      .contains(id)
                                  ? KConstantColors.blueColor
                                  : KConstantColors.bgColor,
                              label: Text(
                                data[index].taskCategoryTitle,
                                style: KCustomTextStyle.kBold(
                                  context,
                                  10,
                                ),
                              ),
                            );
                          },
                          itemCount: data.length),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
          Expanded(
            flex: 1,
            child: Center(
              child: SizedBox(
                width: 300,
                height: 100,
                child: AwesomeButton.roundedIconButton(
                  width: 200,
                  radius: 25,
                  onTap: () async {
                    List<int> ids =
                        taskNotifier(renderUI: false).selectedTaskCategories;
                    CreateTaskDto createTaskDto = CreateTaskDto(
                        taskTitle: _taskTitleController.text,
                        taskDescription: _taskDescriptionController.text,
                        taskScheduleAt: taskNotifier(renderUI: false)
                            .selectedTaskTime!
                            .toIso8601String(),
                        taskCategoryIds: ids);
                    bool status = await taskNotifier(
                      renderUI: false,
                    ).createTask(
                        context: context, createTaskDto: createTaskDto);
                    if (status) {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.homeRoute);
                    }
                  },
                  title: 'Update',
                  titleTextstyle: KCustomTextStyle.kBold(context, 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
