import 'package:ejercicios_flutter2/ej34_gestor_tareas/db/sqflite_common_ffi_manager.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TaskDAO {
  static void create() {
    SqliteManager.db.then((connection) {
      connection?.execute('''
        CREATE TABLE IF NOT EXISTS tasks (
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
    final Database? db = await SqliteManager.db;

    List<Map<String, Object?>>? result = await db?.query("tasks");
    if (result != null) {
      for (var r in result) {
        tasks.add(Task(
            id: int.parse(r["id"].toString()),
            title: r["title"].toString(),
            description: r["description"].toString(),
            isComplete: (r["is_complete"] == 1) ? true : false));
      }
    }
    return tasks;
  }

  static Future<void> update(Task task) async {
    final Database? db = await SqliteManager.db;
    await db?.update(
      "tasks",
      {
        "title" : task.title,
        "description" : task.description,
        "is_complete" : task.isComplete ? 1 : 0
      },
      where: "id = ?",
      whereArgs: [task.id]
    );
  }

  static Future<bool> delete(int id) async {
    final Database? db = await SqliteManager.db;
    final int count = await db?.delete(
        "tasks",
        where: "id = ?",
        whereArgs: [id]
    ) ?? 0;
    return count > 0;
  }
}
