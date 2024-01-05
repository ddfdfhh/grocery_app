
class Thumbnail {
  String? tiny;
  String? small;
  String? medium;
  String? large;

  Thumbnail({this.tiny, this.small, this.medium, this.large});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    tiny = json['tiny'];
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tiny'] = this.tiny;
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}
