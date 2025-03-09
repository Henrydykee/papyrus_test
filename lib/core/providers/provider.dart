import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../features/note/data/model/note_model.dart';
import '../../features/note/data/repositories/note_repository_impl.dart';
import '../../features/note/domain/entities/note_entity.dart';
import '../../features/note/presentation/state/note_view_model.dart';

final dioProvider = Provider<Dio>((ref) => Dio());
final noteBoxProvider = Provider<Box<NoteModel>>((ref) => Hive.box<NoteModel>('notes'));

final noteRepositoryProvider = Provider((ref) => NoteRepositoryImpl(
      noteBox: ref.watch(noteBoxProvider),
      dio: ref.watch(dioProvider),
    ));

final noteViewModelProvider = StateNotifierProvider<NoteViewModel, AsyncValue<List<NoteEntity>>>(
  (ref) => NoteViewModel(repository: ref.watch(noteRepositoryProvider)),
);
