import 'package:flutter/material.dart';
import 'package:noname/notedata.dart';

class NotesViews extends StatelessWidget {
  NotesViews({Key? key,this.datanote}) : super(key: key);
  final notedata? datanote;

  Color c = Colors.yellowAccent ;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      height:h,
      width: w,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 30,),
          Container(
            height: h/7,
            width: w-10,
            decoration: BoxDecoration(
              color: c,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(datanote!.title!,style:const TextStyle(color: Colors.green,fontSize: 24,fontWeight: FontWeight.bold,decoration: TextDecoration.none,overflow: TextOverflow.clip),)
          ),
          const SizedBox(height: 30,),
          Container(
              height: h-((h/7)+80),
              width: w-10,
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(top: 60,left: 10,right: 10,),
              child: SingleChildScrollView(child: Text(datanote!.note!,style:const TextStyle(fontSize: 24,color: Colors.black,decoration: TextDecoration.none),)),
            ),


          
        ],
      ),

    );
  }
}


