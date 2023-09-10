import 'package:flutter/material.dart';
import 'dart:io';

import 'package:hive/hive.dart';

part 'notedata.g.dart';

@HiveType(typeId: 1)
class notedata {
  notedata({required this.title, required this.note,required this.date,this.ispinned});

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? note ;

  @HiveField(2)
  String? date;

  @HiveField(3)
   bool? ispinned;

}

