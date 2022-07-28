import 'package:easy_api/easy_api.dart';
import 'package:task_planner_frontend/modules/home/models/task_category.model.dart';
import 'package:task_planner_frontend/modules/home/models/tasks.model.dart';
import 'package:task_planner_frontend/modules/home/repository/task.network.dart';

class TaskRepository extends EasyModelWrapper {
  final TaskNetwork taskNetwork;

  TaskRepository({required this.taskNetwork});

  Future createTask({required CreateTaskDto createTaskDto}) async {
    return decoder(
        response: await taskNetwork.createTask(createTaskDto: createTaskDto));
  }

  Future fetchTasks() async => nestedModelDecoder(
      jsonFormat: Task.fromJson,
      parentTypeClass: Task,
      childTypeClass: TaskData,
      response: await taskNetwork.fetchTasks());
  //return decoder(response: await taskNetwork.fetchTasks());
  Future fetchTaskCategories() async => nestedModelDecoder(
      jsonFormat: TaskCategory.fromJson,
      parentTypeClass: TaskCategory,
      childTypeClass: TaskCategoryData,
      response: await taskNetwork.fetchTaskCategories());

  Future fetchArchiveTasks() async => nestedModelDecoder(
      jsonFormat: Task.fromJson,
      parentTypeClass: Task,
      childTypeClass: TaskData,
      response: await taskNetwork.fetchArchiveTasks());

  Future deleteTask({required int taskId}) async {
    return decoder(response: await taskNetwork.deleteTask(taskId: taskId));
  }

  Future updateTask(
      {required int taskId, required CreateTaskDto createTaskDto}) async {
    return decoder(
        response: await taskNetwork.updateTask(
            taskId: taskId, createTaskDto: createTaskDto));
  }

  Future setTaskStatus(
      {required int taskId, required String taskStatus}) async {
    return decoder(
        response: await taskNetwork.setTaskStatus(
            taskId: taskId, taskStatus: taskStatus));
  }

  Future setArchiveTask({required int taskId, required bool taskStatus}) async {
    return decoder(
        response: await taskNetwork.setArchiveTask(
            taskId: taskId, taskStatus: taskStatus));
  }
}
