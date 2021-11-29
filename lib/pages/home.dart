import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isEmpty ? ModalRoute.of(context).settings.arguments : data ;

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child:Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover
              )
            ),
            child: Padding(
                padding: EdgeInsets.fromLTRB(0,120.0,0,0),
                child: Column(
                  children: [
                    FlatButton.icon(
                      onPressed: () async{
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'time' : result['time'],
                            'location' : result['location'],
                            'isDayTime' : result['isDayTime'],
                            'flag' : result['flag']
                          };
                        });
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[300]
                      ),
                      label: Text(
                          'Edit Location',
                          style: TextStyle(color: Colors.grey[300])
                      )
                    ),
                    SizedBox(height:20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage('assets/${data['flag']}')
                        ),
                        SizedBox(width: 10.0),
                        Text(
                            data['location'],
                            style: TextStyle(
                                fontSize: 28.0,
                                letterSpacing: 2.0,
                                color: Colors.white
                            )
                        )
                      ],
                    ),
                    SizedBox(height:20.0),
                    Text(
                      data['time'],
                      style: TextStyle(
                        fontSize: 66.0,
                        color: Colors.white
                      )
                    )
                  ]
                ),
              ),
          ),
          )
      );
  }
}
