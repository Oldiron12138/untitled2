import 'package:untitled2/generated/json/base/json_convert_content.dart';
import 'package:untitled2/data/result_data_entity.dart';

ResultDataEntity $ResultDataEntityFromJson(Map<String, dynamic> json) {
	final ResultDataEntity resultDataEntity = ResultDataEntity("111","111","111");
	final String? num = jsonConvert.convert<String>(json['num']);
	if (num != null) {
		resultDataEntity.num = num;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		resultDataEntity.url = url;
	}
	final String? video = jsonConvert.convert<String>(json['video']);
	if (video != null) {
		resultDataEntity.video = video;
	}
	return resultDataEntity;
}

Map<String, dynamic> $ResultDataEntityToJson(ResultDataEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['num'] = entity.num;
	data['url'] = entity.url;
	data['video'] = entity.video;
	return data;
}