import 'package:flutter/material.dart';
class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({Key key, this.title, this.desc}) : super(key: key);

  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 26.0,
      ),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title??"Unnamed Title",
          style: TextStyle(
            color: Color(0xff211551),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              desc??"No description added",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xff86029d),
                height: 1.5,
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key key, this.text,@required this.isDone}) : super(key: key);
  final String text;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 6.0),
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: isDone?Colors.deepPurple:Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
              border: isDone?null:Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            child: Image(
              image: AssetImage(
                'assets/images/check_icon.png'
              ),
            ),

          ),
          Flexible(
            child: Text(
              text??'(Unnamed todo)',
            style: TextStyle(
              color:isDone? Colors.black87:Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: isDone?FontWeight.bold:FontWeight.w500,
            ),),
          ),
          Container(
            margin: EdgeInsets.only(left:12.0),
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(6.0),
              border: isDone?null:Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            child: Image(
              image: AssetImage(
                  'assets/images/delete_icon.png'
              ),
            ),

          ),
        ],
      ),



    );
  }
}


class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

