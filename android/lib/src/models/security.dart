class Security {
  final String? id;
  final String? name;
  final String? address;
  final int? age;
  final String? imageUrl;
  final String? phoneNumber;
  final String? pos;

  Security({
    this.id,
    this.name,
    this.address,
    this.age,
    this.imageUrl,
    this.phoneNumber,
    this.pos
  });

  factory Security.fromJson(Map<String, dynamic> json) => Security(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    age: json["age"],
    pos: json["pos"],
    imageUrl: json["imageUrl"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "age": age,
    "pos": pos,
    "imageUrl": imageUrl,
    "phoneNumber": phoneNumber,
  };
}