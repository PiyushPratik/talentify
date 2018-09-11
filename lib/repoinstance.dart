class repoinstance {
  Repo file;
  String dirName;
  repoinstance.fromjson(Map json) {
    this.dirName = json['dirName'];
    this.file = Repo.fromjson(json['files']);
  }
}

class Repo {
  List<files> file = [];
  Repo.fromjson(List<dynamic> json) {
    for (Map<String, dynamic> File in json) {
      files lis = files.fromjson(File);
      file.add(lis);
      //print(lis.name);
    }
  }
}

class files {
  var createdAt;
  String name;
  String fileUrl;
  files.fromjson(Map json) {
    this.createdAt = json['createdAt'];
    this.name = json['name'];
    this.fileUrl = json['fileUrl'];
  }
}
