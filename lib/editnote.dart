import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noname/createnote.dart';
import 'package:noname/notedata.dart';
import 'package:noname/notesview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'noteboxes.dart';
import 'package:intl/intl.dart';


class EditNote extends StatefulWidget {
   EditNote({Key? key,this.editnote,this.indnum}) : super(key: key);

 final notedata? editnote;
 int? indnum;
  @override
  State<EditNote> createState() => _EditNoteState(editnote1: editnote,indnum1: indnum);
}

class _EditNoteState extends State<EditNote> {
  _EditNoteState({Key? key,this.editnote1,this.indnum1});
    final notedata? editnote1;
    int? indnum1;
   TextEditingController headedit = TextEditingController();

   TextEditingController note_textedit = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    headedit.text='${editnote1!.title}';
    note_textedit.text='${editnote1!.note}';
  }
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
                    controller: headedit,
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
            SizedBox(height: he/150,),
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
                  controller: note_textedit,
                  maxLength: 2000,
                  onChanged: (value){
                    if(value.length > 2000){
                      SnackBar(
                        content: const Text('note is too long'),
                      );
                    }
                  },
                  decoration: InputDecoration(
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
            String create_date =
            DateFormat.yMMMEd().format(DateTime.now()).toString();
            String textkey = widget.editnote!.title!.toString();
              noteboxes.put("${textkey}+${widget.indnum}",notedata(title: headedit.text, note: note_textedit.text, date: create_date));

            Navigator.pop(context);
          }
      ),
      ),
    );
  }
}
