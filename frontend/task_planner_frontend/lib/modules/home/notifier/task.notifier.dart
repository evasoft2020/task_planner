import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:easy_api/easy_api.dart';
import 'package:flutter/material.dart';
import 'package:task_planner_frontend/app/shared/colors.dart';
import 'package:task_planner_frontend/modules/home/models/task_category.model.dart';
import 'package:task_planner_frontend/modules/home/models/tasks.model.dart';
import 'package:task_planner_frontend/modules/home/repository/task.network.dart';
import 'package:task_planner_frontend/modules/home/repository/task.repository.dart';

class TaskNotifier extends ChangeNotifier {
  final TaskRepository taskRepository;

  TaskNotifier({required this.taskRepository});

  //in-state-functions
  DateTime? _selectedTaskTime;
  DateTime? get selectedTaskTime => _selectedTaskTime;

  List<TaskData> allTasks = [];
  List<TaskData> filteredTasks = [];

  bool isFilterMode = false;

  toggleFilterMode({required bool filterMode}) {
    isFilterMode = filterMode;
    notifyListeners();
  }

  setTaskFilter({required String taskStatus}) {
    filteredTasks.clear();

    if (taskStatus == "Start") {
      for (TaskData taskData in allTasks) {
        if (filteredTasks.contains(taskData)) {
          if (taskData.taskStatus == "Start") {
            filteredTasks.add(taskData);
          }
        }
      }
    } else if (taskStatus == "End") {
      for (TaskData taskData in allTasks) {
        if (filteredTasks.contains(taskData)) {
          if (taskData.taskStatus == "End") {
            filteredTasks.add(taskData);
          }
        }
      }
    } else {
      for (TaskData taskData in allTasks) {
        if (filteredTasks.contains(taskData)) {
          if (taskData.taskStatus == "To do") {
            filteredTasks.add(taskData);
          }
        }
      }
    }
    notifyListeners();
  }

  final List<int> _selectedTaskCategories = [];
  List<int> get selectedTaskCategories => _selectedTaskCategories;

  addToSelectedCategory({required int value}) {
    _selectedTaskCategories.contains(value)
        ? _selectedTaskCategories.remove(value)
        : _selectedTaskCategories.add(value);
    notifyListeners();
  }

  setTaskTime({required DateTime value}) {
    _selectedTaskTime = value;
    notifyListeners();
  }

//api
  Future<bool> createTask(
      {required BuildContext context,
      required CreateTaskDto createTaskDto}) async {
    try {
      Map result =
          await taskRepository.createTask(createTaskDto: createTaskDto);
      debugPrint(result.toString());
      bool status = result['status'];
      return status;
    } on EasyException catch (exception) {
      AwesomeSnackbar.style1(
          context: context,
          primaryColor: KConstantColors.blueColor,
          title: exception.message,
          backgroundColor: KConstantColors.bgColor);
      return false;
    }
  }

  Future fetchTasks({required BuildContext context}) async {
    try {
      List<TaskData> result = await taskRepository.fetchTasks();
      allTasks = result;
      notifyListeners();
    } on EasyException catch (e) {
      AwesomeSnackbar.style1(
          context: context,
          primaryColor: KConstantColors.blueColor,
          title: e.message,
          backgroundColor: KConstantColors.bgColor);
      return null;
    }
  }

  Future<List<TaskCategoryData>?> fetchTaskCategories(
      {required BuildContext context}) async {
    try {
      List<TaskCategoryData>? result =
          await taskRepository.fetchTaskCategories();

      return result;
    } on EasyException catch (e) {
      AwesomeSnackbar.style1(
          context: context,
          primaryColor: KConstantColors.blueColor,
          title: e.message,
          backgroundColor: KConstantColors.bgColor);
      return null;
    }
  }

  Future<bool> setArchivedTask(
      {required BuildContext context,
      required int taskId,
      required bool taskStatus}) async {
    try {
      Map result = await taskRepository.setArchiveTask(
          taskId: taskId, taskStatus: taskStatus);
      bool status = result['status'];
      return status;
    } on EasyException catch (exception) {
      AwesomeSnackbar.style1(
          context: context,
          primaryColor: KConstantColors.blueColor,
          title: exception.message,
          backgroundColor: KConstantColors.bgColor);
      return false;
    }
  }

  Future<bool> updateTask(
      {required BuildContext context,
      required int taskId,
      required CreateTaskDto createTaskDto}) async {
    try {
      Map result = await taskRepository.updateTask(
          taskId: taskId, createTaskDto: createTaskDto);
      debugPrint(result.toString());
      bool status = result['status'];
      return status;
    } on EasyException catch (exception) {
      AwesomeSnackbar.style1(
          context: context,
          primaryColor: KConstantColors.blueColor,
          title: exception.message,
          backgroundColor: KConstantColors.bgColor);
      return false;
    }
  }

  Future<List<TaskData>?> fetchArchiveTask(
      {required BuildContext context}) async {
    try {
      List<TaskData> result = await taskRepository.fetchArchiveTasks();
      return result;
    } on EasyException catch (e) {
      AwesomeSnackbar.style1(
          context: context,
          primaryColor: KConstantColors.blueColor,
          title: e.message,
          backgroundColor: KConstantColors.bgColor);
      return null;
    }
  }

  Future<bool> deleteTask(
      {required BuildContext context, required int taskId}) async {
    try {
      Map result = await taskRepository.deleteTask(taskId: taskId);
      bool status = result['status'];
      return status;
    } on EasyException catch (exception) {
      AwesomeSnackbar.style1(
          context: context,
          primaryColor: KConstantColors.blueColor,
          title: exception.message,
          backgroundColor: KConstantColors.bgColor);
      return false;
    }
  }

  Future<bool> setTaskStatus(
      {required BuildContext context,
      required int taskId,
      required String taskStatus}) async {
    try {
      Map result = await taskRepository.setTaskStatus(
          taskId: taskId, taskStatus: taskStatus);
      bool status = result['status'];
      notifyListeners();
      return status;
    } on EasyException catch (exception) {
      AwesomeSnackbar.style1(
          context: context,
          primaryColor: KConstantColors.blueColor,
          title: exception.message,
          backgroundColor: KConstantColors.bgColor);
      return false;
    }
  }

  Future<bool> setArchiveTask(
      {required BuildContext context,
      required int taskId,
      required bool taskStatus}) async {
    try {
      Map result = await taskRepository.setArchiveTask(
          taskId: taskId, taskStatus: taskStatus);
      bool status = result['status'];
      notifyListeners();
      return status;
    } on EasyException catch (exception) {
      AwesomeSnackbar.style1(
          context: context,
          primaryColor: KConstantColors.blueColor,
          title: exception.message,
          backgroundColor: KConstantColors.bgColor);
      return false;
    }
  }
}
