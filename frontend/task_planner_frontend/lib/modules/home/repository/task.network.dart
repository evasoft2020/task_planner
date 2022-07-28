import 'package:easy_api/easy_api.dart';
import 'package:task_planner_frontend/app/routes/api.routes.dart';

class CreateTaskDto {
  final String taskTitle;
  final String taskDescription;
  final String taskScheduleAt;
  final List<int> taskCategoryIds;

  CreateTaskDto(
      {required this.taskTitle,
      required this.taskDescription,
      required this.taskScheduleAt,
      required this.taskCategoryIds});
}

class TaskNetwork extends EasyApiHelper {
  TaskNetwork({required String baseApiUrl}) : super(baseApiUrl: baseApiUrl);

  Future createTask({required CreateTaskDto createTaskDto}) async {
    return sendPostRequest(route: ApiRoutes.createTaskRoute, body: {
      'task_title': createTaskDto.taskTitle,
      'task_description': createTaskDto.taskDescription,
      'task_scheduled_at': createTaskDto.taskScheduleAt,
      'task_categories': createTaskDto.taskCategoryIds,
    });
  }

  Future fetchTasks() async {
    return sendGetRequest(route: ApiRoutes.fetchTaskRoute);
  }

  Future fetchTaskCategories() async {
    return sendGetRequest(route: ApiRoutes.fetchTaskCategoriesRoute);
  }

  Future fetchArchiveTasks() async {
    return sendGetRequest(route: ApiRoutes.fetchArchiveTaskRoute);
  }

  Future deleteTask({required int taskId}) async {
    return sendDeleteRequest(
        route: ApiRoutes.deleteTaskRoute,
        isParams: true,
        params: taskId.toString());
  }

  Future updateTask(
      {required int taskId, required CreateTaskDto createTaskDto}) async {
    return sendPutRequest(route: ApiRoutes.updateTaskRoute, body: {
      'task_title': createTaskDto.taskTitle,
      'task_description': createTaskDto.taskDescription,
      'task_scheduled_at': createTaskDto.taskScheduleAt,
      'task_id': taskId,
    });
  }

  Future setTaskStatus(
      {required int taskId, required String taskStatus}) async {
    return sendPutRequest(route: ApiRoutes.setTaskStatusRoute, body: {
      'task_status': taskStatus,
      'task_id': taskId,
    });
  }

  Future setArchiveTask({required int taskId, required bool taskStatus}) async {
    return sendPutRequest(route: ApiRoutes.setArchiveTaskRoute, body: {
      'task_is_archived': taskStatus,
      'task_id': taskId,
    });
  }
}
