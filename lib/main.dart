import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noname/createnote.dart';
import 'package:noname/editnote.dart';
import 'package:noname/notedata.dart';
import 'package:noname/notesview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'noteboxes.dart';


void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(notedataAdapter());
  noteboxes = await Hive.openBox<notedata>('notes');
  pinboxes = await Hive.openBox<notedata>('pins');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<notedata> data;
  var ind=0;
  @override
  void initState()  {
    // TODO: implement initState

    super.initState();
       setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    setState(() {

    });
      return SafeArea(

        child: Scaffold(
          appBar: AppBar(
            title: const Text("MyNotes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
            backgroundColor: Colors.yellow,
          ),
          body: noteboxes.length == 0 ? const Center(child: Text(
              "NO NOTES CREATED", style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)),
          )
              : ValueListenableBuilder<Box<notedata>>(valueListenable: noteboxes.listenable(), builder: (context,noteboxes,_){
                data = noteboxes.values.toList().cast<notedata>();
                data.sort((a,b)=>b.ispinned.toString().compareTo(a.ispinned.toString()));


    return ListView.builder(
    itemCount: noteboxes.length
    , itemBuilder: (context, index) {

    return Column(
      children: [
        Column(
          children: [
            Slidable(


      // The start action pane is the one at the left or the top side.

              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(onPressed: (context){
                    data[index].ispinned=true;
                    setState(() {

                    });
                  },
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.star,
                  label: "Pin",),

                ],
              ),
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.

                // All actions are defined in the children parameter.
                children:  [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: (context){
                      setState(() {
                        noteboxes.deleteAt(index);
                      });

                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.of(context).push( MaterialPageRoute(builder: (context)=> EditNote(editnote: data[index],indnum: index,)));
                     
                    },
                    backgroundColor:const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),

                ],
              ),


      // The start action pane is the one at the left or the top side.

              child: Card(
                shadowColor: Colors.black,
                color: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),

                  child:
                     Material(
                      child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>NotesViews(datanote: data[index],)));
                      },
                          child: Container(
                                height: height/5,
                                width: width-10,
                                decoration: const BoxDecoration(
                                    color: Colors.yellowAccent,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: Colors.white54,
                                      )
                                    ],
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Container(child: data[index].ispinned==true?const Align(alignment:Alignment.topLeft,child: Icon(Icons.star,color: Colors.red,)):const Align(alignment: Alignment.bottomLeft,child: Text('Unpinned',style: TextStyle(fontSize: 16,color: Colors.red,),)),),
                                    SizedBox(height: height/80,),
                                    Center(child: Text(data[index].title!,style: const TextStyle(color: Colors.green,fontSize: 24,),)),
                                    SizedBox(height: height/11.6,),
                                    Align(alignment: Alignment.bottomRight,child: Text("Date: ${data[index].date}")),

                                  ],
                                ),

                          ),

                  ),
    ),),

            ),
          ],
        ),

         const SizedBox(height: 20,),
      ],
    );
    });
          },
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.yellow,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Createnote()));
            },
            child: const Icon(Icons.add, color: Colors.orangeAccent,),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: height/8,
                  child: const DrawerHeader(decoration: BoxDecoration(
                    color: Colors.blue,
                  ),child: Text("Notes Drawer",style: TextStyle(fontSize: 32),),
                  ),
                ),
                ListTile(
                  title: const Text("Change Theme"),
                  leading: const Icon(Icons.colorize,color: Colors.blueAccent,),
                  onTap: () {
                    Navigator.pop(context);
                  }
                    ),
                ListTile(
                  title: const Text("Change Note Color"),
                  leading: const Icon(Icons.color_lens_rounded,color: Colors.blueAccent,),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),

              ],
            ),
          ),
        ),

      );

  }
}









































