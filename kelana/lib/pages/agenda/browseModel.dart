class BrowseEvent {
  static final String columnId = "idTempat";
  static final String columnName = "nama";
  static final String columnDescription = "deskripsi";
  static final String columnHarga = "harga";
  static final String columnFoto = "fotoThumb";
  static final String columnLoc = "lokasi";
  static final String columnAdd = "additionalActivities";
  static final String columnRevco = "reviewCount";
  static final String columnRevst = "reviewStar";

  BrowseEvent({
    this.nama,
    this.lokasi,
    this.harga,
    this.additionalActivities,
    this.deskripsi,
    this.fotoThumb,
    this.reviewCount,
    this.reviewStar,
  });

  final String nama;
  final int reviewCount;
  final int harga;
  final int reviewStar;
  final String deskripsi;
  final String lokasi;
  final String fotoThumb;
  final Map additionalActivities;

  Map toMap() {
    Map<String, dynamic> map = {
      columnName: nama,
      columnDescription: deskripsi,
      columnHarga: harga,
      columnLoc: lokasi,
      columnFoto: fotoThumb,
      columnRevco: reviewCount,
      columnRevst: reviewStar
    };

    return map;
  }

  static BrowseEvent fromMap(Map map) {
    return new BrowseEvent(
        nama: map[columnName],
        deskripsi: map[columnDescription],
        harga: map[columnHarga],
        reviewCount: map[columnRevco],
        reviewStar: map[columnRevst],
        lokasi: map[columnLoc],
        fotoThumb: map[columnFoto],
        );
  }
}