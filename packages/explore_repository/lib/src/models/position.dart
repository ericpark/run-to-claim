import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'generated/position.freezed.dart';
part 'generated/position.g.dart';

@freezed
@HiveType(typeId: 0)
class Position with _$Position {
  factory Position({
    @HiveField(0) required double latitude,
    @HiveField(1) required double longitude,
    @HiveField(2) @DateTimeConverter() DateTime? createdAt,
    @HiveField(3) String? zipCode,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
}

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String? date) =>
      date != null ? DateTime.parse(date) : DateTime.now();

  @override
  String toJson(DateTime? date) => (date ?? DateTime.now()).toIso8601String();
}
