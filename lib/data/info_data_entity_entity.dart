import 'dart:convert';
import 'package:untitled2/generated/json/base/json_field.dart';
import 'package:untitled2/generated/json/info_data_entity_entity.g.dart';

@JsonSerializable()
class InfoDataEntityEntity {

	String? title;
	String? city;
	String? desc;
	String? street;
	String? phone;
	String? price;
	String? url;

  InfoDataEntityEntity(String? title, String? city, String? desc,String? street, String? phone, String? price, String? url) {
    this.title = title;
    this.city = city;
    this.desc = desc;
    this.street = street;
    this.phone = phone;
    this.price = price;
    this.url = url;
  }


  factory InfoDataEntityEntity.fromJson(Map<String, dynamic> json) => $InfoDataEntityEntityFromJson(json);

  Map<String, dynamic> toJson() => $InfoDataEntityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}