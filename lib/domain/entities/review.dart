import 'package:equatable/equatable.dart';

class Review extends Equatable {
  Review({
    required this.reviewer,
    required this.comment,
    required this.rating,
  });

  String? reviewer;
  String? comment;
  double? rating;

  @override
  List<Object?> get props => [
        reviewer,
        comment,
        rating,
      ];
}
