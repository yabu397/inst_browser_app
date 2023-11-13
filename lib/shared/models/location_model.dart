import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String path;
  final String name;
  const Location({
    this.path = '',
    this.name = '',
  });

  @override
  List<Object?> get props => [
        path,
        name,
      ];
}
