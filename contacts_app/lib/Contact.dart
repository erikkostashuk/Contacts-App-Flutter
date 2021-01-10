class Contact {
  int id;
  String name;
  String dateAdded;
  String phone;
  String userAvatarUrl;

  Contact(int id, String name, String dateAdded, String phone,
      String userAvatarUrl) {
    this.id = id;
    this.name = name;
    this.dateAdded = dateAdded;
    this.phone = phone;
    this.userAvatarUrl = userAvatarUrl;
  }

  Contact.noID(
      String name, String dateAdded, String phone, String userAvatarUrl) {
    this.name = name;
    this.dateAdded = dateAdded;
    this.phone = phone;
    this.userAvatarUrl = userAvatarUrl;
  }

  Contact.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        dateAdded = map['dateAdded'],
        phone = map['phone'],
        userAvatarUrl = map['userAvatarUrl'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dateAdded': dateAdded,
      'phone': phone,
      'userAvatarUrl': userAvatarUrl,
    };
  }
}
