
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory NoteModel.fromJson(dynamic map) {
    return NoteModel(
        id: map['id'] as String,
        title: map['title'] as String,
        content: map['content'] as String);
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
