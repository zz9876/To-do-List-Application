import 'package:flutter/material.dart';
import 'package:to_do_list_app/databaseHelper.dart';
import 'package:to_do_list_app/screen/taskpage.dart';
import 'package:to_do_list_app/taskkcardwidget.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  DatabaseHelper _db =DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF6F6F6),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal:24.0,

          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 32.0,
                      bottom: 32.0,
                    ),
                    child:Image(
                      image: AssetImage(
                          'assets/images/logo.png'
                      ),
                    ) ,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _db.getTask(),
                      builder: (context,snapshot){
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder:
                                    (context)=>TaskPage(task: snapshot.data[index])))
                                .then((value){
                                  setState(() {

                                  });
                                });
                              },
                              child: TaskCardWidget(
                                title: snapshot.data[index].title,
                                desc: snapshot.data[index].description,
                              ),
                            );
                          },),
                        );
                      }
                    )
                    ),

                ],
              ),


              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context)=>TaskPage(task: null)))
                    .then((value){
                      setState(() {

                      });
                    });
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child:Image(image: AssetImage('assets/images/add_icon.png'),),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueGrey,Colors.red],
                        begin: Alignment(0.0,-1.0),
                        end: Alignment(0.0,1.0),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
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
