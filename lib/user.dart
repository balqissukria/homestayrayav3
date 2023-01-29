class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;

    return data;
  }
}
