class UserModelFirestore {
  String? uID;
  String? creationTime;
  String? email;
  String? lastSignIN;
  String? nama;
  String? photoUrl;
  String? status;
  String? updatedTime;

  UserModelFirestore(
      {this.uID,
      this.creationTime,
      this.email,
      this.lastSignIN,
      this.nama,
      this.photoUrl,
      this.status,
      this.updatedTime});

  UserModelFirestore.fromJson(Map<String, dynamic> json) {
    uID = json['UID'];
    creationTime = json['creationTime'];
    email = json['email'];
    lastSignIN = json['lastSignIN'];
    nama = json['nama'];
    photoUrl = json['photoUrl'];
    status = json['status'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['UID'] = uID;
    data['creationTime'] = creationTime;
    data['email'] = email;
    data['lastSignIN'] = lastSignIN;
    data['nama'] = nama;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    data['updatedTime'] = updatedTime;
    return data;
  }
}
