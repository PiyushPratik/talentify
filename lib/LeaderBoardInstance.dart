class LeaderBoardInstance {
  int userPoints;
  String name;
  int totalPoints;
  String description;
  int rank;
  int id;
  AllStudentRanks allStudentRanks;
  LeaderBoardInstance.fromJson(Map json) {
    this.userPoints = json['userPoints'];
    this.name = json['name'];
    this.totalPoints = json['totalPoints'];
    this.description = json['description'];
    this.rank = json['rank'];
    this.id = json['id'];
    //print(json['allStudentRanks'].runtimeType);
    this.allStudentRanks = AllStudentRanks.fromJson(json['allStudentRanks']);
  }
}

class AllStudentRanks {
  List<AllStudentRank> allStudentRanks;
  //todo
  AllStudentRanks.fromJson(List<dynamic> json) {
    for(Map<String, dynamic> roles in json){
      print(roles['name']);
      print(roles['batchRank']);
      print(roles['points']);
    }
    //todo
  }
}

class AllStudentRank {
  int batchRank;
  int coins;
  String imageURL;
  String name;
  int id;
  int points;
  AllStudentRank.fromJson(Map json) {
    this.batchRank = json['batchRank'];
   // print(this.batchRank.runtimeType.toString());
    this.coins = json['coins'];
    this.imageURL = json['imageURL'];
    this.name = json['name'];
    this.id = json['id'];
    this.points = json['points'];
  }
}
