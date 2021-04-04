class Pengasuh {
  final String? id;
  final String? name;
  final String? address;
  final String? age;
  final String? imageUrl;
  final String? phoneNumber;
  final String? dormitory;

  Pengasuh(
      {this.id,
      this.name,
      this.address,
      this.age,
      this.imageUrl,
      this.dormitory,
      this.phoneNumber});

  factory Pengasuh.fromJson(Map<String, dynamic> json) => Pengasuh(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        age: json["age"],
        dormitory: json["dormitory"],
        imageUrl: json["imageUrl"],
        phoneNumber: json["phoneNumber"],
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
