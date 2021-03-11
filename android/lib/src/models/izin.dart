class Izin {
  final String idSantri;
  final String idPembina;
  final String title;
  final String information;
  final DateTime fromDate;
  final DateTime toDate;

  Izin(
      {this.idSantri,
      this.idPembina,
      this.title,
      this.information,
      this.fromDate,
      this.toDate});

  factory Izin.fromJson(Map<String, dynamic> json) => Izin(
    idSantri: json["idSantri"],
    idPembina: json["idPembina"],
    title: json["title"],
    information: json["information"],
    fromDate: json["fromDate"].toDate(),
    toDate: json["toDate"].toDate(),
  );

  Map<String, dynamic> toJson(Izin izin) => {
    "idSantri": izin.idSantri,
    "idPembina": izin.idPembina,
    "title": izin.title,
    "information": izin.information,
    "fromDate": izin.fromDate,
    "toDate": izin.toDate,
  };
}