import 'package:flutter/material.dart';
import 'package:jaziadigitalid/Widgets/SearchWidget.dart';
import 'package:jaziadigitalid/main.dart';
import 'package:jaziadigitalid/mt940/Product.dart';
import 'package:jaziadigitalid/mt940/checkboxstates.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool value = false;
  String query = '';
  late List<CheckBoxState> properties;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    properties = allProperties;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MT940 Selection"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSearch(),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              children: [
                buildGroupCheckbox(checkAllProperties),
                const Divider(
                  color: Colors.white,
                ),
                ...properties.map(buildSingleCheckbox).toList(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            //navigate to the next page
            printallchecked();
          },
          child: const Icon(Icons.navigate_next_rounded)),
    );
  }

  void printallchecked() {
    for (var item in allCheckedProperties) {
      print(item);
    }
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "Property Name ",
        onChanged: searchProperty,
      );
  void searchProperty(String query) {
    final propertysearch = allProperties.where((product) {
      final tittlesearch = product.title.toLowerCase();
      final searchlower = query.toLowerCase();
      return tittlesearch.contains(searchlower);
    }).toList();
    setState(() {
      this.query = query;
      properties = propertysearch;
    });
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.red,
        title: Text(checkbox.title),
        value: checkbox.value,
        onChanged: (value) => setState(() {
          checkbox.value = value!;
          checkAllProperties.value =
              allProperties.every((notification) => notification.value);
          allCheckedProperties.contains(checkbox.title)
              ? allCheckedProperties.remove(checkbox.title)
              : allCheckedProperties.add(checkbox.title);
          //  allCheckedProperties.add(checkbox.title);
        }),
      );
  Widget buildGroupCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.red,
        title: Text(checkbox.title),
        value: checkbox.value,
        onChanged: toggleGroupCheckBox,
      );
  void toggleGroupCheckBox(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      // setState(() {
      checkAllProperties.value = value;
      for (var property in allProperties) {
        property.value = value;
      }
      if (value == true) {
        for (var property in allProperties) {
          setState(() {
            allCheckedProperties.contains(property.title)
                ? null
                : allCheckedProperties.add(property.title);
          });
        }
      } else {
        setState(() {
          allCheckedProperties.clear();
        });
      }
      // });
    });
  }
}
