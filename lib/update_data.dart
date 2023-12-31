import 'dart:convert';
import 'package:crud_flutter/list_data.dart';
import 'package:crud_flutter/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateData extends StatefulWidget {
  final String id;
  final String nama;
  final String jumlah;
  final String harga;
  final String url;
  const UpdateData(
      {super.key,
      required this.id,
      required this.nama,
      required this.jumlah,
      required this.url,
      required this.harga});
  @override
  _UpdateData createState() => _UpdateData(url: url);
}

class _UpdateData extends State<UpdateData> {
  String url;
  _UpdateData({required this.url});
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _hargaController = TextEditingController();

  Future<void> updateData(
      String nama, String jumlah, String harga, String id) async {
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(<String, String>{
        'id': id,
        'nama': nama,
        'jumlah': jumlah,
        'harga': harga
      }),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ListData(),
        ),
      );
    } else {
      throw Exception('Failed to Update Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Barang'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListData(),
                  )); // Navigasi kembali ke layar sebelumnya
            },
          ),
        ),
        drawer: const SideMenu(),
        body: ListView(padding: const EdgeInsets.all(16.0), children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: _namaController,
              decoration: InputDecoration(
                  label: Text(widget.nama),
                  hintText: "Nama...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: _jumlahController,
              decoration: InputDecoration(
                  label: Text(widget.jumlah),
                  hintText: "Jumlah...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: _hargaController,
              decoration: InputDecoration(
                  label: Text(widget.harga),
                  hintText: "Harga...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    updateData(_namaController.text, _jumlahController.text, _hargaController.text,
                        widget.id);
                  }))
        ]));
  }
}
