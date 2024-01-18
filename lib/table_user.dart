import 'package:app_latihan/model/user_model.dart';
import 'package:flutter/material.dart';

class TableUser extends StatefulWidget {
  const TableUser({super.key});

  @override
  State<TableUser> createState() => _TableUserState();
}

class _TableUserState extends State<TableUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // modal for add datas
  showModal(User? data, int? index) {
    if (data != null) {
      emailController.text = data.email;
      passwordController.text = data.password;
    } else {
      emailController.text = '';
      passwordController.text = '';
    }
    AlertDialog alert = AlertDialog(
      title: Text(data == null ? 'add data' : 'Edit data'),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: emailController,
                decoration:
                    const InputDecoration(hintText: 'example@gmail.com'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: '******'),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => data != null ? editData(index!) : saveData(),
          child: const Text('Save', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
    return showDialog(context: context, builder: (context) => alert);
  }

  saveData() {
    dataUser.add(User(emailController.text, passwordController.text));
    Navigator.pushReplacementNamed(context, '/user');
  }

  editData(int index) {
    dataUser[index].email = emailController.text;
    dataUser[index].password = passwordController.text;
    Navigator.pushReplacementNamed(context, '/user');
  }

  deleteData(int index) {
    dataUser.removeAt(index);
    Navigator.pushReplacementNamed(context, '/user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('user data'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              dataUser.isNotEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: List.generate(
                          dataUser.length,
                          (index) => DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text(dataUser[index].email)),
                            DataCell(Row(children: [
                              IconButton(
                                onPressed: () => {
                                  showModal(dataUser[index], index),
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteData(index);
                                },
                                icon: const Icon(Icons.delete),
                              )
                            ]))
                          ]),
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Center(child: Text("Data Kosong")),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => showModal(null, null),
        child: const Icon(Icons.add),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: const [
      //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //   BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      // ]),
    );
  }
}
