import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list_app/model/task.dart';
import 'package:to_do_list_app/model/todo.dart';

class DatabaseHelper {

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),

      onCreate: (db, version) async{
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description Text)',
        );
        await db.execute(
          'CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER,title TEXT, isDone INTEGER)',
        );
        return db;
      },
      version: 1,
    );
  }

    Future<int> insertTask(Task task) async {

      Database _db = await database();
      int taskId=0;
      await _db.insert(
          'tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value){
            taskId=value;
      });
      return taskId;
    }

    Future<void> updateTaskTitle(int id ,String title) async{
    Database db=await database();

    await db.rawUpdate("UPDATE tasks SET title='$title' WHERE id='$id'");
  }

  Future<void> updataskDescription(int id ,String description) async{
    Database db=await database();

    await db.rawUpdate("UPDATE tasks SET description='$description' WHERE id='$id'");
  }

  Future<void> updateTodoisDone(int id ,int isDone) async{
    Database db=await database();

    await db.rawUpdate("UPDATE todo SET isDone='$isDone' WHERE id='$id'");
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();

    await _db.insert(
        'todo', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }



    Future<List<Task>> getTask() async {

      Database _db= await database();

      List<Map<String,dynamic>> taskMap=await _db.query('tasks');
      return List.generate(taskMap.length,(index){
        return Task(id:taskMap[index]['id'],
      title:taskMap[index]['title'],
      description:taskMap[index]['description']);
      });
    }
  Future<List<Todo>> getTodo(int taskId) async {
    Database _db= await database();

    List<Map<String,dynamic>> todoMap=
    await _db.rawQuery("SELECT * FROM todo WHERE taskId=$taskId");
    return List.generate(todoMap.length,(index){
      return Todo(id:todoMap[index]['id'],
          title:todoMap[index]['title'],
          taskId:todoMap[index]['taskId'],
          isDone:todoMap[index]['isDone']);
    });
  }

  Future<void> deleteTask(int id) async{
    Database db=await database();
    await db.rawDelete("DELETE FROM tasks WHERE id='$id' ");
    await db.rawDelete("DELETE FROM todo WHERE taskid='$id'");
  }
  }