class folder {
  Filelist file;
  String dirName;
  folder.fromjson(Map json) {
    this.dirName = json['dirName'];
    this.file = Filelist.fromjson(json['files']);
  }
}

class Filelist {
  List<files> file = [];
  Filelist.fromjson(List<dynamic> json) {
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
