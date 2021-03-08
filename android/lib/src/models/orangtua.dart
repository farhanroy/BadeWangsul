class Orangtua {
  final String id;
  final String idSantri;
  final String name;
  final String address;
  final int age;
  final String imageUrl;
  final String phoneNumber;

  Orangtua({
    this.id, this.name, this.idSantri, this.address, this.age, this.imageUrl, this.phoneNumber
  });

  factory Orangtua.fromJson(Map<String, dynamic> json) => Orangtua(
    id: json["id"],
    idSantri: json["idSantri"],
    name: json["name"],
    address: json["address"],
    age: json["age"],
    imageUrl: json["imageUrl"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idSantri": idSantri,
    "name": name,
    "address": address,
    "age": age,
    "imageUrl": imageUrl,
    "phoneNumber": phoneNumber,
  };
}