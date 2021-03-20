class Santri{
  final String id;
  final String name;
  final String age;
  final String address;
  final String dormitory;
  final String imageUrl;
  final DateTime birthDate;

  Santri({this.id, this.name, this.age, this.address, this.dormitory, this.imageUrl, this.birthDate});

  factory Santri.fromJson(Map<String, dynamic> json) => Santri(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    age: json["age"],
    dormitory: json["dormitory"],
    birthDate: json["birthDate"].toDate(),
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "age": age,
    "dormitory": dormitory,
    "birthDate":birthDate,
    "imageUrl": imageUrl,
  };

}