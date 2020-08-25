import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/getLocation.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  WeatherApp({Key key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String apiKey='c212380b641a7f2665adaed3fead8c17';
  @override
  void initState() {
 
    // TODO: implement initState
    super.initState();
  }
  var desc;
  var temp;
  var city;
  @override
  Widget build(BuildContext context) {
        
      
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
          home: Scaffold(
         body: Column(
           children: [
             Container(
               child: displayImage(),
               ),
               Container(
                 margin: EdgeInsets.only(top:50),
                 child: Text(
                   "You are in:",
                   style: TextStyle(
                     color: Colors.blue[500],
                     fontSize: 35.0,
                     fontWeight: FontWeight.bold
                   ),
                 ),
               ),
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 45.0),
                 child: Row(
                   children: [
                     Text(
                       "${city.toString()}",
                       style: TextStyle(
                         fontSize: 25.0,
                         fontWeight: FontWeight.bold,
                         color: Colors.blue[500]
                       ),
                       ),
                       SizedBox(width: 10.0,),
                       Icon(
                         Icons.location_on,
                         color: Colors.red,
                         size: 30.0,
                       )
                   ],
                 ),
               ),
               Card(
                 margin: EdgeInsets.symmetric(vertical: 17.0,horizontal: 25.0),
                 color: Colors.white,
                 child: ListTile(
                   leading: Icon(
                     Icons.wb_sunny,
                     color: Colors.amber,
                   ),
                   title: Text("Temperature: ${temp.toString()} C"),
                   subtitle: Text("Status:${desc.toString()}"),
                 ),
               ),
               Container(
              child: Center(
                child: FlatButton(
                  child: Text('Get weather info'),
                  color: Colors.blue[500],
                  textColor: Colors.white,
                  onPressed: (){
                    setState(() {
                      getLocation();
                    });
                  },
                ),
              ),
            )
           ],
         ),
      ),
    );
  }
  displayImage(){
    var now=DateTime.now();
    final currentTime=DateFormat.jm().format(now);
    if(currentTime.contains("AM")){
      print("currentTime: $currentTime");
      return Image.asset("images/dayTime.jpg");
    }else if (currentTime.contains("PM")){
      print("currentTime: $currentTime");
      return Image.asset("images/nightTime.jpg");
    }
  }
  void getLocation()async{
    GetLocation getLocation=GetLocation();
    await getLocation.getCurrentLocation();
    print(getLocation.latitude);
     print(getLocation.longitude);
      city=getLocation.city;
    
   getTemp(getLocation.latitude, getLocation.longitude);
  }
  Future<void>getTemp(double lat,double lon) async{
    http.Response response=await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
  

var dataDecoded=jsonDecode(response.body);
 desc=dataDecoded['weather'][0]['description'];
 temp=dataDecoded['main']['temp'];
 print(temp);



 }

  
}