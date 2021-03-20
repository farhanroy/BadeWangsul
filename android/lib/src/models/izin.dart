class Izin {
  final String id;
  final String idSantri;
  final String idPembina;
  final String title;
  final String information;
  final DateTime fromDate;
  final DateTime toDate;
  final bool isPermissioned;
  final bool isPulang;

  Izin({
    this.id,
    this.idSantri,
    this.idPembina,
    this.title,
    this.information,
    this.fromDate,
    this.toDate,
    this.isPermissioned,
    this.isPulang,
  });

  factory Izin.fromJson(Map<String, dynamic> json) => Izin(
    id: json["id"],
    idSantri: json["idSantri"],
    idPembina: json["idPembina"],
    title: json["title"],
    information: json["information"],
    fromDate: json["fromDate"].toDate(),
    toDate: json["toDate"].toDate(),
    isPermissioned: json["isPermissioned"],
    isPulang: json["isPulang"]
  );

  Map<String, dynamic> toJson(Izin izin) => {
    "id": izin.id,
    "idSantri": izin.idSantri,
    "idPembina": izin.idPembina,
    "title": izin.title,
    "information": izin.information,
    "fromDate": izin.fromDate,
    "toDate": izin.toDate,
    "isPermissioned": izin.isPermissioned,
    "isPulang": izin.isPulang
  };
}