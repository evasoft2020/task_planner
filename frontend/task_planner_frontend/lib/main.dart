import 'package:flutter/material.dart';
import 'package:task_planner_frontend/core.dart';
import 'package:task_planner_frontend/router.dart';

void main() {
  FluroRouterClass.setupRouter();
  runApp(const Core());
}
