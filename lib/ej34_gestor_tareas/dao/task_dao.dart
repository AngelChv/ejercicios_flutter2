import 'package:ejercicios_flutter2/ej34_gestor_tareas/db/sqflite_common_ffi_manager.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TaskDAO {
  static void create() {
    SqliteManager.db.then((connection) {
      connection?.execute('''
        CREATE TABLE tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          is_complete INTEGER NOT NULL
        )
      '''); // is_complete: 1 = true, 0 = false
    });
  }

  static Future<int?> insert(Task task) async {
    final Database? db = await SqliteManager.db;
    return await db?.insert('tasks', {
      'title': task.title,
      'description': task.description,
      'is_complete': (task.isComplete) ? 1 : 0,
    });
  }

  static Future<List<Task>> findAll() async {
    List<Task> tasks = [];
    print("findAll");
    final Database? db = await SqliteManager.db;

    List<Map<String, Object?>>? result = await db?.query("tasks");
    print("get result");
    print("result $result");
    if (result != null) {
      for (var r in result) {
        tasks.add(Task(
            title: r["title"].toString(),
            description: r["description"].toString(),
            isComplete: (r["isComplete"] == 1) ? true : false));
      }
    }
    print("findall enviado =====>>>>>");
    return tasks;
  }
}
