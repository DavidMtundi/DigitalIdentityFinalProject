import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaziadigitalid/mt940/Item.dart';
import 'package:jaziadigitalid/mt940/Product.dart';

class MultiSelectionPage extends StatefulWidget {
  MultiSelectionPage({Key? key}) : super(key: key);

  @override
  State<MultiSelectionPage> createState() => _MultiSelectionPageState();
}

class _MultiSelectionPageState extends State<MultiSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("MT940 Components Selection Page"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 500,
              color: Colors.blue[200],
              child: GridView.count(
                crossAxisCount: 4,
                scrollDirection: Axis.vertical,
                children: [
                  ...List.generate(
                      productList.length,
                      (index) => Item(
                            product: productList[index],
                            onSelected: (bool value) {
                              if (value) {
                                pickeditems.add(productList[index]);
                              } else {
                                pickeditems.remove(productList[index]);
                              }
                              setState(() {});
                            },
                          ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              height: 100,
              width: double.infinity,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...List.generate(
                      pickeditems.length,
                      (index) => SelectedWidget(
                            title: pickeditems[index].title,
                          ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectedWidget extends StatelessWidget {
  final String title;
  const SelectedWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chip(
        label: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

List<Product> pickeditems = [];
