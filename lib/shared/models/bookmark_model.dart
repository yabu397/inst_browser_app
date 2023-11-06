import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final String title;
  final String url;
  const Bookmark({
    this.title = '',
    this.url = '',
  });

  @override
  List<Object?> get props => [
        title,
        url,
      ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'url': url,
    };
  }

  factory Bookmark.fromJson(Map<String, dynamic> map) => Bookmark(
        title: map['title'] ?? '',
        url: map['url'] ?? '',
      );

  Bookmark copyWith({
    String? title,
    String? url,
  }) {
    return Bookmark(
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }
}
