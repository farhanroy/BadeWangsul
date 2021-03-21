class Keamanan {
  final String id;
  final String name;
  final String address;
  final String age;
  final String imageUrl;
  final String phoneNumber;

  Keamanan({
    this.id,
    this.name,
    this.address,
    this.age,
    this.imageUrl,
    this.phoneNumber
  });

  factory Keamanan.fromJson(Map<String, dynamic> json) => Keamanan(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    age: json["age"],
    imageUrl: json["imageUrl"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "age": age,
    "imageUrl": imageUrl,
    "phoneNumber": phoneNumber,
  };
}