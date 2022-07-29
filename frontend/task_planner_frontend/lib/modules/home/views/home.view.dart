import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_planner_frontend/app/routes/app.routes.dart';
import 'package:task_planner_frontend/app/shared/colors.dart';
import 'package:task_planner_frontend/app/shared/text_style.dart';
import 'package:task_planner_frontend/modules/home/models/tasks.model.dart';
import 'package:task_planner_frontend/modules/home/notifier/task.notifier.dart';
import 'package:task_planner_frontend/modules/home/widgets/task_block.widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TaskNotifier taskNotifier({required bool renderUI}) =>
      Provider.of<TaskNotifier>(context, listen: renderUI);

  @override
  void initState() {
    taskNotifier(renderUI: false).fetchTasks(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isFilterMode = taskNotifier(renderUI: true).isFilterMode;

    List<TaskData> fData = isFilterMode
        ? taskNotifier(renderUI: true).filteredTasks
        : taskNotifier(renderUI: true).allTasks;

    Widget filterChip({required String title}) {
      return AwesomeButton.roundedIconButton(
        title: title,
        titleTextstyle: KCustomTextStyle.kMedium(context, 10),
        width: 100,
        height: 40,
        radius: 10,
        onTap: () {
          taskNotifier(renderUI: false).toggleFilterMode(filterMode: true);
          taskNotifier(renderUI: false).setTaskFilter(taskStatus: title);
          Navigator.pop(context);
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            const CircleAvatar(radius: 12, child: FlutterLogo(size: 12)),
            AwesomeDimensions.hSizedBox3,
            const Icon(
              Icons.logout,
              size: 20,
              color: KConstantColors.whiteColor,
            ),
          ],
          backgroundColor: KConstantColors.bgColor,
          title: Text(
            'Task Planner',
            style: KCustomTextStyle.kBold(context, 14),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.pushReplacementNamed(
                    context, AppRoutes.createTaskRoute);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: KConstantColors.blueColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 200,
                height: 50,
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: KConstantColors.whiteColor,
                      size: 20,
                    ),
                    AwesomeDimensions.hSizedBox2,
                    Text(
                      "Create Task",
                      style: KCustomTextStyle.kBold(context, 10),
                    ),
                  ],
                ),
              ),
            ),
            AwesomeDimensions.hSizedBox2,
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: KConstantColors.bgColor,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                filterChip(title: "To do"),
                                filterChip(title: "Start"),
                                filterChip(title: "End"),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: KConstantColors.textureWhiteColor,
                child: Icon(
                  EvaIcons.fileAdd,
                  color: KConstantColors.darkColor,
                  size: 17,
                ),
              ),
            ),
            AwesomeDimensions.hSizedBox2,
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.showArchiveTaskRoute,
                );
              },
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: KConstantColors.textureWhiteColor,
                child: Icon(
                  EvaIcons.archive,
                  color: KConstantColors.darkColor,
                  size: 17,
                ),
              ),
            ),
          ],
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: fData.length,
          itemBuilder: (context, index) {
            return TaskBlock(
              taskData: fData[index],
            );
          },
        ));
  }
}
