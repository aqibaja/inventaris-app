class InventarisModel {
  String id;
  String namaBarang;
  String nomorBarang;
  String tanggal;
  String lokasi;
  String image;

  InventarisModel(
      {this.id,
      this.namaBarang,
      this.nomorBarang,
      this.tanggal,
      this.lokasi,
      this.image});

  InventarisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    namaBarang = json['nama_barang'];
    nomorBarang = json['nomor_barang'];
    tanggal = json['tanggal'];
    lokasi = json['lokasi'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_barang'] = this.namaBarang;
    data['nomor_barang'] = this.nomorBarang;
    data['tanggal'] = this.tanggal;
    data['lokasi'] = this.lokasi;
    data['image'] = this.image;
    return data;
  }
}
