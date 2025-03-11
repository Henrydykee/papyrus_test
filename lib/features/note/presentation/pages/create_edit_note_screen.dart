import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/providers/provider.dart';
import '../../domain/entities/note_entity.dart';

class CreateEditNoteScreen extends ConsumerStatefulWidget {
  final NoteEntity? note; // If null, we're creating a new note

  CreateEditNoteScreen({this.note});

  @override
  _CreateEditNoteScreenState createState() => _CreateEditNoteScreenState();
}

class _CreateEditNoteScreenState extends ConsumerState<CreateEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveOrUpdateNote() async {
    if (_formKey.currentState!.validate()) {
      final id = widget.note?.id ?? Uuid().v4();
      final newNote = NoteEntity(
        id: id,
        title: _titleController.text,
        content: _contentController.text,
      );
      if (widget.note == null) {
        await ref.read(noteViewModelProvider.notifier).addNote(newNote);
      } else {
        await ref.read(noteViewModelProvider.notifier).updateNote(newNote);
        Navigator.pop(context);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Create Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a title' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter content' : null,
                maxLines: 5,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveOrUpdateNote,
                child: Text(widget.note == null ? 'Save Note' : 'Update Note'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
