import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/note_repository.dart';

class NoteViewModel extends StateNotifier<AsyncValue<List<NoteEntity>>> {
  final NoteRepository repository;

  NoteViewModel({required this.repository}) :   super(const AsyncValue.data([]));
  final Set<String> deletedNoteIds = {};

  Future<void> loadNotes() async {
    state = const AsyncValue.loading();
    try {
      List<NoteEntity> localNotes = await repository.getNotes();
      List<NoteEntity> apiNotes = await repository.fetchApiNotes();
      List<NoteEntity> filteredApiNotes = apiNotes.where((note) => !deletedNoteIds.contains(note.id)).toList();
      for (var note in filteredApiNotes) {
        if (!localNotes.any((note) => note.id == note.id)) {
          await repository.addNote(note);
        }
      }
      final allNotes = await repository.getNotes();
      state = AsyncValue.data(allNotes);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }



  Future<void> addNote(NoteEntity note) async {
    await repository.addNote(note);
    await loadNotes();
  }

  Future<void> updateNote(NoteEntity note) async {
    await repository.updateNote(note);
    await loadNotes();
  }


  Future<void> deleteNote(String id) async {
    deletedNoteIds.add(id);
    await repository.deleteNote(id);
    await loadNotes();
  }
}
