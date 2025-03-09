import 'package:dio/dio.dart';
import 'package:flutter_arch_riverpod/features/note/data/model/note_model.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/note_repository.dart';


class NoteRepositoryImpl implements NoteRepository {
  final Box<NoteModel> noteBox;
  final Dio dio;

  NoteRepositoryImpl({required this.noteBox, required this.dio});

  @override
  Future<List<NoteEntity>> getNotes() async {
    final notes = noteBox.values.toList();
    return notes.map((note) => NoteEntity(
      id: note.id,
      title: note.title,
      content: note.content,
    )).toList();
  }

  @override
  Future<void> addNote(NoteEntity note) async {
    final noteModel = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
    );
    await noteBox.put(note.id, noteModel);
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    final noteModel = noteBox.get(note.id);
    if (noteModel != null) {
      noteModel.title = note.title;
      noteModel.content = note.content;
      await noteModel.save();
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    await noteBox.delete(id);
  }

  @override
  Future<List<NoteEntity>> fetchApiNotes() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    List data = response.data;
    return data.take(10).map((item) => NoteEntity(
      id: item['id'].toString(),
      title: item['title'],
      content: item['body'],
    )).toList();
  }
}
