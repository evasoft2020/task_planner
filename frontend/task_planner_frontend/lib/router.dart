import 'package:fluro/fluro.dart';
import 'package:task_planner_frontend/app/routes/app.routes.dart';
import 'package:task_planner_frontend/modules/home/models/tasks.model.dart';
import 'package:task_planner_frontend/modules/home/views/create_task.view.dart';
import 'package:task_planner_frontend/modules/home/views/home.view.dart';
import 'package:task_planner_frontend/modules/home/views/show_archived_task.view.dart';
import 'package:task_planner_frontend/modules/home/views/task_details.view.dart';
import 'package:task_planner_frontend/modules/home/views/update_task.view.dart';

import 'modules/home/views/splash.view.dart';

class FluroRouterClass {
  static var router = FluroRouter();

  static dynamic splashHandler = Handler(handlerFunc: (context, params) {
    return const SplashView();
  });
  static dynamic homeHandler = Handler(handlerFunc: (context, params) {
    return const HomeView();
  });

  static dynamic createHandler = Handler(handlerFunc: (context, params) {
    return CreateTaskView();
  });
  static dynamic taskDetailsHandler = Handler(handlerFunc: (context, params) {
    final args = context!.settings!.arguments as TaskData;
    return TaskDetailsView(taskData: args);
  });
  static dynamic archivedTaskHandler = Handler(handlerFunc: (context, params) {
    return const ShowArchivedTaskView();
  });

  static dynamic updateTaskHandler = Handler(handlerFunc: (context, params) {
    final args = context!.settings!.arguments as UpdateTaskArguments;
    return UpdateTaskView(
        taskId: args.taskId,
        oldTaskTitle: args.oldTaskTitle,
        oldTaskDescription: args.oldTaskDescription);
  });

  static void setupRouter() {
    router.define(AppRoutes.splashRoute, handler: splashHandler);
    router.define(AppRoutes.homeRoute, handler: homeHandler);
    router.define(AppRoutes.createTaskRoute, handler: createHandler);
    router.define(AppRoutes.taskDetailsRoute, handler: taskDetailsHandler);
    router.define(AppRoutes.updateTaskRoute, handler: updateTaskHandler);
    router.define(AppRoutes.showArchiveTaskRoute, handler: archivedTaskHandler);
  }

  /*  void navigateToHome(BuildContext context) {
    navigateTo(context, homeHandler.path);
  }

  void navigateToSplash(BuildContext context) {
    navigateTo(context, splashHandler.path);
  }

  void navigateToCreate(BuildContext context) {
    navigateTo(context, createHandler.path);
  }

  void navigateToTaskDetails(BuildContext context, TaskData taskData) {
    navigateTo(context, taskDetailsHandler.path,
        transition: TransitionType.nativeModal,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }, routeSettings: RouteSettings(arguments: taskData));
  }

  void navigateToUpdateTask(BuildContext context, UpdateTaskArguments args) {
    navigateTo(context, updateTaskHandler.path,
        transition: TransitionType.nativeModal,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }, routeSettings: RouteSettings(arguments: args));
  }

  void navigateToHomeWithTransition(BuildContext context) {
    navigateTo(context, homeHandler.path,
        transition: TransitionType.nativeModal,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    });
  } */
}
