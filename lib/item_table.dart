import 'package:app_latihan/model/item_model.dart';
import 'package:flutter/material.dart';

class ItemTable extends StatefulWidget {
  const ItemTable({super.key});

  @override
  State<ItemTable> createState() => _ItemTableState();
}

class _ItemTableState extends State<ItemTable> {
  List<Item> items = List.of(itemList);

  bool isActive = false;
  TextEditingController searchController = TextEditingController();
  TextEditingController namaItemController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

  void searchItems() {
    setState(() {
      items = itemList
          .where((element) => element.namaItem
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  String? hargaItem;

  void sortHarga() {
    setState(() {
      if (hargaItem == 'termurah') {
        items.sort(
          (a, b) => a.hargaItem.compareTo(b.hargaItem),
        );
      } else {
        items.sort(
          (a, b) => b.hargaItem.compareTo(a.hargaItem),
        );
      }
    });
  }

  String? status;
  void sortStatus() {
    setState(() {
      if (status == 'tidak aktif') {
        items
            .sort((a, b) => a.status.toString().compareTo(b.status.toString()));
      } else {
        items
            .sort((a, b) => b.status.toString().compareTo(a.status.toString()));
      }
    });
  }

  showModal(Item? data, int? index) {
    if (data != null) {
      namaItemController.text = data.namaItem;
      hargaController.text = data.hargaItem.toString();
      isActive = data.status;
    } else {
      namaItemController.text = '';
      hargaController.text = '';
      isActive = false;
    }
    AlertDialog alertDialog = AlertDialog(
      title: Text(data == null ? 'Tambah Item' : 'Update Item'),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: namaItemController,
                    decoration: const InputDecoration(
                      hintText: 'nama item',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: hargaController,
                    decoration: const InputDecoration(
                      hintText: 'harga item',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Switch.adaptive(
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                    ),
                    Text(isActive ? 'aktif' : 'tidak aktif')
                  ],
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            data != null ? editData(index!) : saveData();
            Navigator.pop(context);
            // namaItemController.text = '';
            // hargaController.text = '';
            // isActive = false;
          },
          child: const Text('save'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('cancel'),
        ),
      ],
    );
    return showDialog(context: context, builder: (context) => alertDialog);
  }

  saveData() {
    int harga = int.tryParse(hargaController.text) ?? 0;

    setState(() {
      items.add(Item(namaItemController.text, harga.toInt(), isActive));
    });
  }

  editData(int index) {
    double harga = double.tryParse(hargaController.text) ?? 0;

    setState(() {
      items[index].namaItem = namaItemController.text;
      items[index].hargaItem = harga.toInt();
      items[index].status = isActive;
    });
    Navigator.pushReplacementNamed(context, '/item');
  }

  deleteData(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TABLE ITEM'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('search item'),
                  suffixIcon: IconButton(
                      onPressed: () => searchItems(),
                      icon: const Icon(Icons.search)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        hargaItem = 'termurah';
                        sortHarga();
                      });
                    },
                    child: const Text('Termurah'),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        hargaItem = 'termahal';
                        sortHarga();
                      });
                    },
                    child: const Text('Termahal'),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        status = 'aktif';
                        sortStatus();
                      });
                    },
                    child: const Text('aktif'),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        status = 'tidak aktif';
                        sortStatus();
                      });
                    },
                    child: const Text('tidak aktif'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Items Kosong'),
                          OutlinedButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, '/item'),
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    )
                  : buildList(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView buildList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            isThreeLine: true,
            title: Text(items[index].namaItem),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rp${items[index].hargaItem}'),
                Text(
                  items[index].status ? 'aktif' : 'tidak aktif',
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    showModal(items[index], index);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    deleteData(index);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
