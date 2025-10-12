import 'package:flutter/material.dart';
import 'package:studentregister/pages/add_student.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         margin: EdgeInsets.only(top: 20, left: 10, right: 10),
         child: Column(
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   "student ",
                   style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold
                   ),
                 ),
                 Text(
                   "Attendance",
                   style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     color: Colors.blue
                   ),
                 )
               ],
             ),
             SizedBox(height: 20,),
             Material(
               elevation: 3,
               child: Container(
                 padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(color: Colors.white),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                         children: [
                           Text(
                             "Student name :",
                             style: TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.bold
                             ),
                           ),
                           Text(
                             " Marry musioka",
                             style: TextStyle(
                                 color: Colors.blue,
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold
                             ),
                           )
                         ],
                     ),
                     Row(
                       children: [
                         Text(
                           "Reg No: ",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                         Text(
                           "30",
                           style: TextStyle(
                               color: Colors.blue,
                               fontSize: 18,
                               fontWeight: FontWeight.bold
                           ),
                         )
                       ],
                     ),
                     Row(
                       children: [
                         Text(
                           "Attennce: ",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                         Container(
                           padding: EdgeInsets.all(5),
                           width: 30,
                           child: Text("P",style: TextStyle(color: Colors.black,),),
                           decoration: BoxDecoration(
                               color: Colors.green,
                               borderRadius: BorderRadius.circular(5)
                           ),
                         ),
                         SizedBox(width: 10,),
                         Container(
                           width: 30,
                           padding: EdgeInsets.all(5),
                           child: Text("A",style: TextStyle(color: Colors.black),),
                           decoration: BoxDecoration(
                               color: Colors.red,
                               borderRadius: BorderRadius.circular(5)
                           ),
                         )
                       ],
                     )
                   ],
                 ),
               )
             )
           ],
         ),
       ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent()));
        },
        backgroundColor: Colors.blue,
      ),
    );
  }
}
