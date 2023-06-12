import 'package:first_project/components/task.dart';
import 'package:first_project/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao{
  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  List<Task> toList(List<Map<String,dynamic>> tasksMap){
    print('Convertendo to list');
    final List<Task> tasks = [];
    for (Map<String,dynamic> row in tasksMap){
      final Task task = Task(row[_name], row[_image], row[_difficulty]);
      tasks.add(task);
    }
    print('Lista de tarefas ${tasks.toString()}');
    return tasks;
  }

  Map<String, dynamic> toMap(Task task){
    print('Convertendo tarefa em map');
    final Map<String,dynamic> taskMap = Map();
    taskMap[_name] = task.name;
    taskMap[_difficulty] = task.difficulty;
    taskMap[_image] = task.image;
    print('Mapa de tarefas: $taskMap');
    return taskMap;
  }
  //CREATE AND UPDATE
  save(Task task) async{
    print('Iniciando o save');
    final Database database = await getDatabase();
    var itemExists = await find(task.name);
    Map<String,dynamic> taskMap = toMap(task);
    if(itemExists.isEmpty){
      print('A tarefa não existe');
      return await database.insert(_tablename, taskMap);
    }else{
      print('A tarefa já existe');
      return await database.update(_tablename, taskMap, where: '$_name =?',whereArgs: [task.name]);
    }
  }

  //READ
  Future<List<Task>> findAll() async{
    print('Acessando o findAll');
    final Database database = await getDatabase();
    final List<Map<String,dynamic>> result = await database.query(_tablename);
    print('Procurando dados no banco. Encontrado: ${toList(result)}');
    return toList(result);
  }

  Future<List<Task>> find(String taskName) async{
    print('Acessando o find');
    final Database database = await getDatabase();
    final List<Map<String,dynamic>> result = await database.query(_tablename, where: '$_name = ?', whereArgs: [taskName]);
    print('Tarefa encontrada. ${toList(result)}');
    return toList(result);
  }

  //DELETE
  delete(String taskName) async{
    print('Exluindo tarefa: $taskName');
    final Database database = await getDatabase();
    return database.delete(_tablename, where: '$_name = ?', whereArgs: [taskName]);
  }
}