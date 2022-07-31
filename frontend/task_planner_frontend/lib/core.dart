import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:task_planner_frontend/modules/home/notifier/task.notifier.dart';
import 'package:task_planner_frontend/modules/home/repository/task.network.dart';
import 'package:task_planner_frontend/modules/home/repository/task.repository.dart';
import 'package:task_planner_frontend/router.dart';

import 'app/routes/app.routes.dart';

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => TaskNotifier(
            taskRepository: TaskRepository(
                taskNetwork:
                    TaskNetwork(baseApiUrl: "http://192.168.0.36:3000/"))),
      ),
    ], child: const Lava());
  }
}

class Lava extends StatelessWidget {
  const Lava({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Task Planner',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: FluroRouterClass.router.generator,
        initialRoute: AppRoutes.homeRoute,
        //home: const HomeView(),
      );
    });
  }
}
