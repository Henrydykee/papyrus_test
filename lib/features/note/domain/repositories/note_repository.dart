import '../entities/note_entity.dart';

abstract class NoteRepository {
  Future<List<NoteEntity>> getNotes();

  Future<void> addNote(NoteEntity note);

  Future<void> updateNote(NoteEntity note);

  Future<void> deleteNote(String id);

  Future<List<NoteEntity>> fetchApiNotes();
}
