import 'dart:convert';
import 'package:untitled2/generated/json/base/json_field.dart';
import 'package:untitled2/generated/json/buy_response_entity.g.dart';

@JsonSerializable()
class BuyResponseEntity {

	bool? resultData;
  
  BuyResponseEntity();

  factory BuyResponseEntity.fromJson(Map<String, dynamic> json) => $BuyResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => $BuyResponseEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}