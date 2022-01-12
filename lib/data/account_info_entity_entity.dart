import 'dart:convert';
import 'package:untitled2/generated/json/base/json_field.dart';
import 'package:untitled2/generated/json/account_info_entity_entity.g.dart';

@JsonSerializable()
class AccountInfoEntityEntity {

	String? num;
	String? name;
	int? id;
	int? coin;
	String? token;
  
  AccountInfoEntityEntity();

  factory AccountInfoEntityEntity.fromJson(Map<String, dynamic> json) => $AccountInfoEntityEntityFromJson(json);

  Map<String, dynamic> toJson() => $AccountInfoEntityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}