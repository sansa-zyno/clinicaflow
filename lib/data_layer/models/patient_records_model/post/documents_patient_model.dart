class DocumentsPatient {
  String? fileName;
  String? blobName;

  DocumentsPatient({this.fileName, this.blobName});

  DocumentsPatient.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    blobName = json['blobName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileName'] = fileName;
    data['blobName'] = blobName;
    return data;
  }
}