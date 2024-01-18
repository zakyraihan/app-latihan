import 'package:flutter/material.dart';

class TableUser extends StatefulWidget {
  const TableUser({super.key});

  @override
  State<TableUser> createState() => _TableUserState();
}

class _TableUserState extends State<TableUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('user data'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: List.generate(
                    10,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text('${index + 1}')),
                        const DataCell(Text('Testgmail@.com')),
                        DataCell(Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete))
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ]),
    );
  }
}
