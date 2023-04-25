import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');
    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    return yesNoModel.toMessageEntity();
  }
}

class YesNoModel {
    YesNoModel({
      required this.answer,
      required this.forced,
      required this.image,
    });

    final String answer;
    final bool forced;
    final String image;

    factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
    };

    Message toMessageEntity() => Message(
      text: answer == 'yes' ? 'Si' : 'No', 
      fromWho: FromWho.hers,
      imageUrl: image
    );
}

