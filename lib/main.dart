import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'features/note/data/model/note_model.dart';
import 'features/note/presentation/pages/home_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await BoxClass().openBoxes();
  runApp(ProviderScope(child: NoteApp()));
}

class BoxClass {
 static Box<NoteModel> get noteBox => Hive.box<NoteModel>("notes");
  Future<void> openBoxes() async {
    Hive.registerAdapter(NoteModelAdapter());
    await Hive.openBox<NoteModel>('notes');
    await _generateNote(noteBox);
  }

  static Map<Box<dynamic>, dynamic Function(dynamic json)> get allBoxes => {
        noteBox: (json) => NoteModel.fromJson(json),
      };

  static Future<void> _generateNote(Box<NoteModel> box) async {
    final note = NoteModel(
      id: Uuid().v4(),
      title: "Note ${box.length + 1}",
      content: "Content ${box.length + 1}",
    );
    await box.put(note.id, note);
  }
}

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
