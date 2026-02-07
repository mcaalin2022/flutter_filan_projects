
class ProgramModel {
  String? id;
  String? universityId;
  String? name;
  String? duration;
  String? requirements;

  ProgramModel({
    this.id,
    this.universityId,
    this.name,
    this.duration,
    this.requirements,
  });

  ProgramModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    universityId = json['universityId'];
    name = json['name'];
    duration = json['duration'];
    requirements = json['requirements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['universityId'] = universityId;
    data['name'] = name;
    data['duration'] = duration;
    data['requirements'] = requirements;
    return data;
  }
}

