//Spin Defender 使用时间
class TrainingTimeModel {

  String id = '0';
  String trainingTime = '0'; // 训练时间
  String time = ''; // 训练日期

  TrainingTimeModel({required this.trainingTime,required this.time});


  factory TrainingTimeModel.modelFromJson(Map<String, dynamic> json) {
    TrainingTimeModel model =  TrainingTimeModel(
      trainingTime: json['trainingTime'] ?? '0',
      time: json['time'] ?? '0',
    );
    return model;
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'trainingTime': this.trainingTime,
        'time': this.time,
        'id': this.id,
      };

}