import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final String? id;
  final String? title;
  final String? url;
  const Bookmark({
    this.id = '',
    this.title = '',
    this.url = '',
  });

  @override
  List<Object?> get props => [
        id,
        title,
        url,
      ];

  Bookmark copyWith({
    String? id,
    String? title,
    String? url,
  }) {
    return Bookmark(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }
}
