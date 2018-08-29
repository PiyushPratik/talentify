class LeaderBoardInstance{

  int userPoints;
  String name;
  int totalPoints;
  String description;
  int rank;
  int id;

  LeaderBoardInstance.fromJson(Map json) {
    this.userPoints = json['userPoints'];
    this.name = json['name'];
    this.totalPoints = json['totalPoints'];
    this.description = json['description'];
    this.rank = json['rank'];
    this.id = json['id'];
  }

}