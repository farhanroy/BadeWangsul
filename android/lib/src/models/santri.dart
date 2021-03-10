class Santri{
  final String name;
  final String age;
  final String address;
  final String dormitory;
  final String imageUrl;

  Santri({this.name, this.age, this.address, this.dormitory, this.imageUrl});

  factory Santri.fromJson(Map<String, dynamic> json) => Santri(
    name: json["name"],
    address: json["address"],
    age: json["age"],
    dormitory: json["dormitory"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "age": age,
    "dormitory": dormitory,
    "imageUrl": imageUrl,
  };

}