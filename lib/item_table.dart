import 'package:app_latihan/model/item_model.dart';
import 'package:flutter/material.dart';

class ItemTable extends StatefulWidget {
  const ItemTable({super.key});

  @override
  State<ItemTable> createState() => _ItemTableState();
}

class _ItemTableState extends State<ItemTable> {
  List<Item> items = List.of(itemList);
  TextEditingController searchController = TextEditingController();

  searchItems(String value) {
    setState(() {
      items = itemList
          .where((element) =>
              element.namaItem.toLowerCase().contains(value.toLowerCase()))
          .toList();
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
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                onChanged: (value) {
                  searchItems(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('search item'),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: items.isNotEmpty
                  ? ListView.builder(
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(itemList[index].namaItem),
                            subtitle: Text('Rp${itemList[index].hargaItem}'),
                            trailing: Text(
                              itemList[index].status ? 'aktif' : 'tidak aktif',
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('items kosong'),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
