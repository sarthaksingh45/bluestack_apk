class RecData {
  String name;
  String imageUrl;
  String gameName;

  RecData(this.name, this.imageUrl, this.gameName);

  factory RecData.fromJson(Map<String, dynamic> json) {
    return RecData(json['name'], json['cover_url'], json['game_name']);
  }
}
