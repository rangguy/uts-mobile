import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crud_flutter/side_menu.dart';
import 'package:crud_flutter/tambah_data.dart';
import 'package:crud_flutter/update_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListData extends StatefulWidget {
  const ListData({super.key});
  @override
// ignore: library_private_types_in_public_api
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Map<String, String>> dataBarang = [];
  String url = Platform.isAndroid
      ? 'http://10.98.5.105/uasmobile/index.php'
      : 'http://localhost/uasmobile/index.php';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        dataBarang = List<Map<String, String>>.from(data.map((item) {
          return {
            'nama': item['nama'] as String,
            'jumlah': item['jumlah'] as String,
            'harga': item['harga'] as String,
            'id': item['id'] as String,
          };
        }));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future deleteData(int id) async {
    final response = await http.delete(Uri.parse('$url?id=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  lihatBarang(String id, String nama, String jumlah, String harga) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Detail Barang'),
            content: Container(
              height: 100.0,
              width: 400.0,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    child: Text('Id : $id'),
                  ),
                  Container(
                    child: Text('Nama : $nama'),
                  ),
                  Container(
                    child: Text('jumlah : $jumlah'),
                  ),
                  Container(
                    child: Text('harga : $harga'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Belanja'),
      ),
      drawer: const SideMenu(),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const TambahData()),
                  ));
            },
            child: const Text('Tambah Data Barang'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataBarang.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataBarang[index]['nama']!),
                  subtitle: Text('Jumlah: ${dataBarang[index]['jumlah']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          lihatBarang(
                              dataBarang[index]['id']!,
                              dataBarang[index]['nama']!,
                              dataBarang[index]['jumlah']!,
                              dataBarang[index]['harga']!);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => UpdateData(
                                      id: dataBarang[index]['id']!,
                                      nama: dataBarang[index]['nama']!,
                                      jumlah: dataBarang[index]['jumlah']!,
                                      url: url,
                                      harga: dataBarang[index]['harga']!,
                                    )),
                              ));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteData(int.parse(dataBarang[index]['id']!))
                              .then((result) {
                            if (result['pesan'] == 'berhasil') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Data berhasil dihapus'),
                                      content: const Text('ok'),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ListData(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
