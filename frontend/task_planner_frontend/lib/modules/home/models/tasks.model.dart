class Task {
  Task({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<TaskData> data;

  Task.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => TaskData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['status'] = status;
    jsonData['data'] = data.map((e) => e.toJson()).toList();
    return jsonData;
  }
}

class TaskData {
  TaskData({
    required this.taskId,
    required this.taskTitle,
    required this.taskStatus,
    required this.taskDescription,
    required this.taskCreatedAt,
    required this.taskScheduledAt,
    required this.taskIsArchived,
    required this.taskCategories,
  });
  late final int taskId;
  late final String taskTitle;
  late final String taskStatus;
  late final String taskDescription;
  late final String taskCreatedAt;
  late final String taskScheduledAt;
  late final bool taskIsArchived;
  late final List<TaskCategories> taskCategories;

  TaskData.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskTitle = json['task_title'];
    taskStatus = json['task_status'];
    taskDescription = json['task_description'];
    taskCreatedAt = json['task_created_at'];
    taskScheduledAt = json['task_scheduled_at'];
    taskIsArchived = json['task_is_archived'];
    taskCategories = List.from(json['task_categories'])
        .map((e) => TaskCategories.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['task_id'] = taskId;
    data['task_title'] = taskTitle;
    data['task_status'] = taskStatus;
    data['task_description'] = taskDescription;
    data['task_created_at'] = taskCreatedAt;
    data['task_scheduled_at'] = taskScheduledAt;
    data['task_is_archived'] = taskIsArchived;
    data['task_categories'] = taskCategories.map((e) => e.toJson()).toList();
    return data;
  }
}

class TaskCategories {
  TaskCategories({
    required this.taskCategoryId,
    required this.taskCategoryTitle,
    required this.taskCategoryDescription,
  });
  late final int taskCategoryId;
  late final String taskCategoryTitle;
  late final String taskCategoryDescription;

  TaskCategories.fromJson(Map<String, dynamic> json) {
    taskCategoryId = json['task_category_id'];
    taskCategoryTitle = json['task_category_title'];
    taskCategoryDescription = json['task_category_description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['task_category_id'] = taskCategoryId;
    data['task_category_title'] = taskCategoryTitle;
    data['task_category_description'] = taskCategoryDescription;
    return data;
  }
}
