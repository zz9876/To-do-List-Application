import 'package:flutter/material.dart';
import 'package:to_do_list_app/databaseHelper.dart';
import 'package:to_do_list_app/model/task.dart';
import 'package:to_do_list_app/model/todo.dart';
import 'package:to_do_list_app/taskkcardwidget.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({Key key, @required this.task}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int taskId=0;
  String taskTitle = "";
  String taskdesc="";

  FocusNode Titlefocus;
  FocusNode descriptionfocus;
  FocusNode todofocus;
  DatabaseHelper _dbhelper = DatabaseHelper();

  bool contentVisible=false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.task!=null){
      contentVisible=true; //when task is added then task is displayed

      taskTitle = widget.task.title;
    taskId=widget.task.id;
    taskdesc=widget.task.description;
    }


    Titlefocus=FocusNode();
    descriptionfocus=FocusNode();
    todofocus=FocusNode();
  }


  @override
  void dispose() {
    Titlefocus.dispose();
    descriptionfocus.dispose();
    todofocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //for top enter task title
                  Padding(
                    padding: EdgeInsets.only(top: 24.0, bottom: 12.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Image(
                              image: AssetImage(
                                'assets/images/back_arrow_icon.png',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: Titlefocus,
                            onSubmitted: (value) async {
                              //check if field is nort empty
                              if (value != "") {
                                //check if task is not null
                                if (widget.task == null) {
                                  Task _newtask = Task(title: value);
                                   taskId=await _dbhelper.insertTask(_newtask);
                                   setState(() {
                                     contentVisible=true;
                                     taskTitle=value;

                                   });
                                   print("new task is added$taskId");
                                  setState(() {
                                  });
                                } else {
                                 await _dbhelper.updateTaskTitle(taskId, value);
                                 print("task updated");
                                }
                                descriptionfocus.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text = taskTitle,
                            decoration: InputDecoration(
                              hintText: "Enter Task Title",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff211551),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: contentVisible,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        focusNode: descriptionfocus,
                        onSubmitted: (value) async{

                          if(value!=null){
                            if(taskId!=0){
                              await _dbhelper.updataskDescription(taskId, value);
                              taskdesc=value;
                              print("desc updated");
                            }
                          }
                          todofocus.requestFocus();
                        },
                        controller: TextEditingController()..text=taskdesc,
                        decoration: InputDecoration(
                          hintText: "Enter Description for the task",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
          Visibility(
            visible: contentVisible,
            child: FutureBuilder(
                initialData: [],
                future: _dbhelper.getTodo(taskId),
                builder: (context,snapshot){
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder:(context,index) {
                          return GestureDetector(
                            onTap: () async{
                              //swich the complete task

                             if(snapshot.data[index].isDone==0){
                               await _dbhelper.updateTodoisDone(snapshot.data[index].id, 1);
                             }
                             else{
                               await _dbhelper.updateTodoisDone(snapshot.data[index].id, 0);

                             }
                              setState(() {

                              });
                            },
                            child: TodoWidget(
                              isDone:snapshot.data[index].isDone==0
                                  ? false
                                  :true,
                            text:snapshot.data[index].title ,),
                          );
                        }),
                  );
                }),
          ),
                  Visibility(
                    visible: contentVisible,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 6.0),
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                            ),
                            child: Image(
                              image:
                                  AssetImage('assets/images/check_icon.png'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: TextEditingController()..text="",
                              focusNode: todofocus,
                              onSubmitted: (value) async {

                                //check if field is nort empty
                                if (value != "") {
                                  //check if task is not null
                                  if (taskId != null) {
                                    DatabaseHelper _dbhelper = DatabaseHelper();
                                   Todo _newtodo=Todo(

                                       title: value,
                                       isDone:0,
                                       taskId: taskId);
                                    await _dbhelper.insertTodo(_newtodo);
                                    setState(() {
                                      todofocus.requestFocus();
                                    });
                                    print("creating new todo");
                                  }
                                }

                              },
                              decoration: InputDecoration(
                                hintText: "Enter Todo item",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: contentVisible,
                child: Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () async{
                      if(taskId!=0){
                        await _dbhelper.deleteTask(taskId);
                        Navigator.pop(context);
                      }
                        },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      child: Image(
                        image: AssetImage('assets/images/delete_icon.png'),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
