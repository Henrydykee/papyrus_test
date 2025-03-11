import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ui/boxes_view.dart';
import '../../../../core/providers/provider.dart';
import '../../../../main.dart';
import '../../domain/entities/note_entity.dart';
import 'create_edit_note_screen.dart';
import 'note_detail_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(noteViewModelProvider.notifier).loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notesState = ref.watch(noteViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        // ...
      ),
      body: notesState.when(
        data: (notes) {
          if (notes.isEmpty) {
            return Center(child: Text('No notes available'));
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              NoteEntity note = notes[index];
              return ListTile(
                title: Text(note.title,style: TextStyle(
                  fontWeight: FontWeight.w500
                )),
                subtitle: Text(
                  note.content.length > 50 ? '${note.content.substring(0, 50)}...' : note.content,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteDetailScreen(note: note),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e,s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HiveBoxesView(
                hiveBoxes: BoxClass.allBoxes,
                onError: (String errorMessage) =>
                {
                  print(errorMessage)
                })),
          );

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => CreateEditNoteScreen()),
          // );
        },
      ),
    );
  }
}

