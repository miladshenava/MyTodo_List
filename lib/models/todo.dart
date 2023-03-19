import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId : 1)
class todo{
  @HiveField(0)
  String title = '';

  @HiveField(1)
  String description = '';

  @HiveField(2)
  String myTask = '';
  todo({required this.title, required this.description, required this.myTask});

}