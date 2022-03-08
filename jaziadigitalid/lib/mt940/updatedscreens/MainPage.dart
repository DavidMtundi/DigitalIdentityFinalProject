import 'package:flutter/material.dart';
import 'package:jaziadigitalid/mt940/updatedscreens/DownloadPage.dart';
import 'package:jaziadigitalid/mt940/widgets/SearchWidget.dart';
import 'package:jaziadigitalid/mt940/models/checkboxstates.dart';

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
        title: const Text("Customize your MT940"),
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
                buildAllCheckDetails(checkAllProperties),
                const Divider(
                  color: Colors.white,
                ),
                // ...properties.map(buildSingleCheckbox).toList(),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              children: [
                buildGroupCheckbox1(checkallHeaders),
                const Divider(
                  color: Colors.white,
                ),
                ...properties
                    .where((element) => element.index < 6)
                    .map(buildSingleCheckbox)
                    .toList(),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              children: [
                buildGroupCheckbox2(checkalltransactions),
                const Divider(
                  color: Colors.white,
                ),
                ...properties
                    .where((element) => element.index < 13 && element.index > 6)
                    .map(buildSingleCheckbox)
                    .toList(),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              children: [
                buildGroupCheckbox3(checkallfooterDetails),
                const Divider(
                  color: Colors.white,
                ),
                ...properties
                    .where(
                        (element) => element.index > 13 && element.index < 20)
                    .map(buildSingleCheckbox)
                    .toList(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            //navigate to the next page
            toDownload();
          },
          child: const Icon(Icons.navigate_next_rounded)),
    );
  }

  toDownload() async {
    print(allCheckedProperties);
    Route route = MaterialPageRoute(builder: (context) => DownloadPage());
    Navigator.push(context, route);
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "Property Name ",
        onChanged: searchProperty,
      );
  void searchProperty(String query) {
    final propertysearch = allProperties.where((product) {
      final tittlesearch = product.title.toLowerCase();
      final searchlower = query.trim().toLowerCase();
      return tittlesearch.contains(searchlower);
    }).toList();
    setState(() {
      this.query = query;
      properties = propertysearch;
    });
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.platform,
        activeColor: Colors.red,
        title: Text(checkbox.title),
        value: checkbox.value,
        onChanged: (value) => setState(() {
          checkbox.value = value!;
          checkAllProperties.value =
              properties.every((notification) => notification.value);
          allCheckedProperties.contains(checkbox.name)
              ? allCheckedProperties.remove(checkbox.name)
              : allCheckedProperties.add(checkbox.name);
          //  allCheckedProperties.add(checkbox.index);
        }),
      );
  Widget buildAllCheckDetails(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.red,
        subtitle: const Text(
          "Selects all Properties",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        isThreeLine: true,
        title: Text(
          checkbox.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        value: checkbox.value,
        onChanged: toggleGroupAllCheckBox,
      );
  Widget buildGroupCheckbox2(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.red,
        title: Text(
          checkbox.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        value: checkbox.value,
        onChanged: toggleGroupCheckBox2,
      );
  Widget buildGroupCheckbox1(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.red,
        title: Text(
          checkbox.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        value: checkbox.value,
        onChanged: toggleGroupCheckBox1,
      );
  Widget buildGroupCheckbox3(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.red,
        title: Text(
          checkbox.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        value: checkbox.value,
        onChanged: toggleGroupCheckBox3,
      );
  void toggleGroupAllCheckBox(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      // setState(() {
      checkAllProperties.value = value;
      for (var property in properties) {
        property.value = value;
      }
      if (value == true) {
        for (var property in properties) {
          setState(() {
            allCheckedProperties.contains(property.name)
                ? null
                : allCheckedProperties.add(property.name);
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

  toggleGroupCheckBox1(
    bool? value,
  ) {
    if (value == null) {
      return;
    }
    setState(() {
      // setState(() {
      checkallHeaders.value = value;
      for (var property in properties.where((element) => element.index < 7)) {
        property.value = value;
      }
      if (value == true) {
        for (var property in properties.where((element) => element.index < 7)) {
          setState(() {
            allCheckedProperties.contains(property.name)
                ? null
                : allCheckedProperties.add(property.name);
          });
        }
      } else {
        setState(() {
          for (var item in properties.where((element) => element.index < 7)) {
            if (allCheckedProperties.contains(item.name)) {
              setState(() {
                allCheckedProperties.remove(item.name);
                checkAllProperties.value = value;
              });
            }
          }
        });
      }
      // });
    });
  }

  toggleGroupCheckBox2(
    bool? value,
  ) {
    if (value == null) {
      return;
    }
    setState(() {
      // setState(() {
      checkalltransactions.value = value;
      for (var property in properties
          .where((element) => element.index > 6 && element.index < 14)) {
        property.value = value;
      }
      if (value == true) {
        for (var property in properties
            .where((element) => element.index > 7 && element.index < 14)) {
          setState(() {
            allCheckedProperties.contains(property.name)
                ? null
                : allCheckedProperties.add(property.name);
          });
        }
      } else {
        setState(() {
          for (var item in properties
              .where((element) => element.index > 7 && element.index < 14)) {
            if (allCheckedProperties.contains(item.name)) {
              setState(() {
                allCheckedProperties.remove(item.name);
                checkAllProperties.value = value;
              });
            }
          }
        });
      }
      // });
    });
  }

  toggleGroupCheckBox3(
    bool? value,
  ) {
    if (value == null) {
      return;
    }
    setState(() {
      // setState(() {
      checkallfooterDetails.value = value;
      for (var property in properties.where((element) => element.index > 12)) {
        property.value = value;
      }
      if (value == true) {
        for (var property
            in properties.where((element) => element.index > 12)) {
          setState(() {
            allCheckedProperties.contains(property.name)
                ? null
                : allCheckedProperties.add(property.name);
          });
        }
      } else {
        setState(() {
          for (var item in properties.where((element) => element.index > 12)) {
            if (allCheckedProperties.contains(item.name)) {
              setState(() {
                allCheckedProperties.remove(item.name);
                checkAllProperties.value = value;
              });
            }
          }
        });
      }
      // });
    });
  }
}
