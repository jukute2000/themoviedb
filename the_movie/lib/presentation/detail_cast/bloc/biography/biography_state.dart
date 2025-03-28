import 'package:equatable/equatable.dart';

class BiographyState extends Equatable {
  final bool isExpanded;

  const BiographyState({this.isExpanded = false});

  BiographyState copyWith({bool? isExpanded}) {
    return BiographyState(
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  List<Object> get props => [isExpanded];
}
