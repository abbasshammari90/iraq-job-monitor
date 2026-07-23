import 'package:freezed_annotation/freezed_annotation.dart';

part 'keyword_model.freezed.dart';
part 'keyword_model.g.dart';

@freezed
class KeywordModel with _$KeywordModel {
  const factory KeywordModel({
    required String id,
    required String keyword,
    required bool isDefault,
    required DateTime createdAt,
  }) = _KeywordModel;

  factory KeywordModel.fromJson(Map<String, dynamic> json) =>
      _$KeywordModelFromJson(json);
}
