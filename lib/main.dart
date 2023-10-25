import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_dreams_logi/config/settings.dart';
import 'package:robot_dreams_logi/internal/application.dart';

void main() {
  runApp(
    ChangeNotifierProvider<Settings>(
      create: (_) => Settings(),
      child: const Application(),
    ),
  );
}
