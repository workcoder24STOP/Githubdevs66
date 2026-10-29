import 'comment.dart';

class CommentumResponse {
  final List<Comment> data;
  final int count;
  final String? nextCursor;

  CommentumResponse({
    required this.data,
    required this.count,
    this.nextCursor,
  });

  factory CommentumResponse.fromJson(Map<String, dynamic> json,
      {required bool isReply}) {
    final key = isReply ? 'replies' : 'comments';
    final countKey = isReply ? 'reply_count' : 'comment_count';
    
    return CommentumResponse(
      data: (json[key] as List?)?.map((c) => Comment.fromJson(c)).toList() ?? [],
      count: json[countKey] ?? 0,
      nextCursor: json['next_cursor'],
    );
  }
}