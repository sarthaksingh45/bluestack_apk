class ProfileData {
  String name;
  String imageUrl;
  String gameId;
  int elo;
  int played;
  int won;
  int perc;

  ProfileData(this.name, this.imageUrl, this.gameId, this.elo, this.played,
      this.won, this.perc);

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(json['name'], json['image_url'], json['game_id'],
        json['elo'], json['played'], json['won'], json['perc']);
  }
}
