import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../service.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController regNoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? fname;
  String? lname;
  String? regNo;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top : 20, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),

                  ),
                  SizedBox(width: 80,),
                  Text(
                      "Add ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    "Student",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize  : 20,
                      color: Colors.blue
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Form(
                  key: _formKey,
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelText: 'First Name',
                      hintText: 'Enter your first name',
                    ),
                    controller: fnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First name is requied';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelText: 'Last Name',
                      hintText: 'Enter your last name',
                    ),
                    controller: lnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Last name is requied';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      labelText: 'Reg No',
                      hintText: 'Enter your Reg No',
                    ),
                    controller: regNoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Reg No is requied';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      elevation: 5
                    ),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          fname = fnameController.text;
                          lname = lnameController.text;
                          regNo = regNoController.text;
                          String addId = randomAlphaNumeric(10);
                          Map<String, dynamic> studentInfoMap = {
                            "fname" : fname,
                            "lname" : lname,
                            "regNo" : regNo,
                            "present" : false,
                            "absent" : false,
                          };
                          await DataBaseMethos()
                              .addStudents(studentInfoMap, addId)
                              .then((value){
                                fnameController.text = "";
                                lnameController.text = "";
                                regNoController.text = "";
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                  content: Text(
                                  "Student added successfully",
                                   style: TextStyle(
                                     color: Colors.white
                                   ),
                                 )
                              )
                          );
                        }
                      },
                      child: Text(
                          "Submit",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                  ),

                ],
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
