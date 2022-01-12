import 'dart:convert';
import 'package:untitled2/generated/json/base/json_field.dart';
import 'package:untitled2/generated/json/result_data_entity.g.dart';

@JsonSerializable()
class ResultDataEntity {

	String? num;
	String? url;
	String? video;

  //ResultDataEntity();
  ResultDataEntity();

  factory ResultDataEntity.fromJson(Map<String, dynamic> json) => $ResultDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $ResultDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}