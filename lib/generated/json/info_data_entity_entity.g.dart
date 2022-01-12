import 'package:untitled2/generated/json/base/json_convert_content.dart';
import 'package:untitled2/data/info_data_entity_entity.dart';

InfoDataEntityEntity $InfoDataEntityEntityFromJson(Map<String, dynamic> json) {
	final InfoDataEntityEntity infoDataEntityEntity = InfoDataEntityEntity();
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		infoDataEntityEntity.title = title;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		infoDataEntityEntity.city = city;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		infoDataEntityEntity.desc = desc;
	}
	final String? street = jsonConvert.convert<String>(json['street']);
	if (street != null) {
		infoDataEntityEntity.street = street;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		infoDataEntityEntity.phone = phone;
	}
	final String? price = jsonConvert.convert<String>(json['price']);
	if (price != null) {
		infoDataEntityEntity.price = price;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		infoDataEntityEntity.url = url;
	}
	return infoDataEntityEntity;
}

Map<String, dynamic> $InfoDataEntityEntityToJson(InfoDataEntityEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['title'] = entity.title;
	data['city'] = entity.city;
	data['desc'] = entity.desc;
	data['street'] = entity.street;
	data['phone'] = entity.phone;
	data['price'] = entity.price;
	data['url'] = entity.url;
	return data;
}