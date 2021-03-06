
class Pembina {
  final String id;
  final String name;
  final String address;
  final String age;
  final String imageUrl;
  final String dormitory;
  final String phoneNumber;

  Pembina({
    this.id, this.name, this.address, this.age, this.imageUrl, this.dormitory, this.phoneNumber,
  });

  factory Pembina.fromJson(Map<String, dynamic> json) => Pembina(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    age: json["age"],
    dormitory: json["dormitory"],
    imageUrl: json["imageUrl"].toDouble(),
    phoneNumber: json["phoneNumber"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "age": age,
    "dormitory": dormitory,
    "imageUrl": imageUrl,
    "phoneNumber": phoneNumber,
  };
}
