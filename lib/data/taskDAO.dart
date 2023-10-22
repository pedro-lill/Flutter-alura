
import 'package:curso/Components/task.dart';
import 'package:curso/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_image TEXT, '
      '$_difficulty INTEGER)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _image = 'image';
  static const String _difficulty = 'difficulty';

  save(Task tarefa) async {
    final Database db = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> values = toMap(tarefa);
    if (itemExists.isEmpty) {
      return await db.insert(_tablename, values);
    
    }else{
      return await db.update
            (_tablename, 
              values, 
              where: '$_name = ?', 
              whereArgs: [tarefa.nome],);
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_image] = tarefa.foto;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    return mapaDeTarefas;
  }
    

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablename);
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> listaDeTarefas){
    final List<Task> tarefas = [];
    for(Map<String, dynamic> linha in listaDeTarefas){
      final Task tarefa = Task (
        linha[_name],
        linha[_image],
        linha[_difficulty],
      );
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Future<List<Task>> find(String nameTarefa) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await 
           db.query(_tablename, where: '$_name = ?', whereArgs: [nameTarefa]);
    return toList(result);
  }

  delete(String nameTarefa) async {
    final Database db = await getDatabase();
    return await db.delete(_tablename, where: '$_name = ?', whereArgs: [nameTarefa]);

  }  
}


