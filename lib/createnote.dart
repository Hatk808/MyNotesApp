import 'package:flutter/material.dart';
import 'package:noname/noteboxes.dart';
import 'package:noname/notedata.dart';
import 'package:intl/intl.dart';


class Createnote extends StatefulWidget {

  const Createnote({Key? key}) : super(key: key);

  @override
  State<Createnote> createState() => _CreatenoteState();
}

class _CreatenoteState extends State<Createnote> {

  int count = 0;
  TextEditingController head = TextEditingController();

  TextEditingController note_text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: he/5,
                width: wi-10,
                child: TextField(
                      style: TextStyle(fontSize: 24,overflow: TextOverflow.clip,fontWeight: FontWeight.bold,color: Colors.green),
                      maxLines: null,
                      expands: true,
                      controller: head,
                      maxLength: 80,
                      onChanged: (value){
                        if(value.length > 100){

                          SnackBar(
                            content: const Text('Title is too long'),
                          );
                        }
                      },
                      decoration: InputDecoration(

                        filled: true,
                        fillColor: Colors.yellow,
                          hintText: 'Enter Title Of Your Note',
                          // Set border for enabled state (default)
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // Set border for focused state
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.green),
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                    ),
              ),
            ],
          ),
            SizedBox(height: he/128,),
            SingleChildScrollView(
              child: Container(
                height: he-he/5-60,
                width: wi-10,
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                  style: TextStyle(fontSize: 24,),
                  maxLines: null,
                  expands: true,
                  controller: note_text,
                  maxLength: 2000,
                  onChanged: (value){
                    if(value.length > 2000){
                      SnackBar(
                        content: const Text('note is too long'),
                      );
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Your Note Here',
                      filled: true,
                      fillColor: Colors.yellowAccent,

                      // Set border for enabled state (default)
                      enabledBorder: OutlineInputBorder(

                        borderSide: const BorderSide(width: 3, color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // Set border for focused state
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.green),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
          ],
        ),
      ),



       floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Container(height: 50,width: 50,child:FloatingActionButton(

        child: Text("Save",style: TextStyle(color: Colors.orangeAccent,fontSize: 16,),),hoverColor: Colors.red,focusColor: Colors.yellow,tooltip: "It saves your note",
      onPressed: () {
          count++;
        String createDate = DateFormat.yMMMEd().format(DateTime.now()).toString();
        setState(() {
          noteboxes.put("${head.text}+$count",notedata(title: head.text.length==null?"UNTITLED":head.text, note: note_text.text.length==null?"Null Data":note_text.text,date: createDate));
        });

        Navigator.pop(context);
      }
      ),
    ),
    );
  }
}
