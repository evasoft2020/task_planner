class TaskCategory {
  TaskCategory({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final List<TaskCategoryData> data;

  TaskCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data'])
        .map((e) => TaskCategoryData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['status'] = status;
    jsonData['data'] = data.map((e) => e.toJson()).toList();
    return jsonData;
  }
}

class TaskCategoryData {
  TaskCategoryData({
    required this.taskCategoryId,
    required this.taskCategoryTitle,
    required this.taskCategoryDescription,
  });
  late final int taskCategoryId;
  late final String taskCategoryTitle;
  late final String taskCategoryDescription;

  TaskCategoryData.fromJson(Map<String, dynamic> json) {
    taskCategoryId = json['task_category_id'];
    taskCategoryTitle = json['task_category_title'];
    taskCategoryDescription = json['task_category_description'];
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['task_category_id'] = taskCategoryId;
    jsonData['task_category_title'] = taskCategoryTitle;
    jsonData['task_category_description'] = taskCategoryDescription;
    return jsonData;
  }
}
