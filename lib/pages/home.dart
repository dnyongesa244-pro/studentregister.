import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentregister/pages/add_student.dart';

import '../service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Stream? studentStream;

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  getOnTheLoad() async{
    studentStream = await DataBaseMethos().getStudentsDtails();
  }

  Widget ShowStudentList()  {
    return StreamBuilder<QuerySnapshot>(stream: DataBaseMethos().getStudentsDtails(), builder: (context, snapshot){
      if(snapshot.hasError){
        return Center(
          child: Text("Something went wrong"),
        );
      } if(snapshot.connectionState == ConnectionState.waiting){
        return Center(
          child: CircularProgressIndicator(),
        );
      } if(!snapshot.hasData){
        return Center(
          child: Text("No data found"),
        );
      }
      return  ListView.builder(
        padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index){
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return(
                  Material(
                      elevation: 3,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white12,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
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
                                    ds['fname']+ " " +ds['lname'],
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                        child: Icon(Icons.delete, color: Colors.black,),
                                      onTap: () async {
                                          await DataBaseMethos()
                                             .deleteStudent(ds.id)
                                             .then((value)=>{
                                               ScaffoldMessenger.of(context).showSnackBar(
                                                   SnackBar(content: Text(ds['fname']+" deleted succesfully")),
                                               )
                                             }
                                          );                                          ;

                                      },
                                    )
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
                                  ds['regNo'],
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
                                ds['present'] == false ? GestureDetector(
                                  onTap: (){
                                    DataBaseMethos()
                                        .updateAttendance("present", ds.id)
                                        .then((value){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                ds['fname']+ " marked present",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18
                                                ),
                                              )
                                          )
                                      );
                                    }
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width: 30,
                                    child: Text("P",style: TextStyle(color: Colors.black,),),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.black)
                                    ),
                                  ),
                                ):
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
                                ds['absent'] == false ? GestureDetector(
                                  onTap: (){
                                    DataBaseMethos()
                                        .updateAttendance("absent", ds.id)
                                        .then((value){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    ds['fname']+ " marked absent",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),
                                                  )
                                              )
                                          );
                                       }
                                    );
                                  },
                                  child: Container(
                                    width: 30,
                                    padding: EdgeInsets.all(5),
                                    child: Text("A",style: TextStyle(color: Colors.black),),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.black)
                                    ),
                                  ),
                                ):
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
              );
          });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: Container(
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
               ShowStudentList()
             ],
           ),
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
