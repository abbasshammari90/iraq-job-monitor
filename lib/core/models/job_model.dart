import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
class JobModel with _$JobModel {
  const factory JobModel({
    required String id,
    required String company,
    required String title,
    required String location,
    required DateTime date,
    required String source,
    required String message,
    required double importanceScore,
    required String classification,
    required bool isFavorite,
    required DateTime createdAt,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);
}
