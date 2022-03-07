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
  late List<CheckBoxState> allHeaderDetails;

  late List<CheckBoxState> allTransactionDetails;

  late List<CheckBoxState> allfooterDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    properties = allProperties;
    allHeaderDetails = headerDetails;
    allTransactionDetails = transactiondetails;
    allfooterDetails = footerdetails;
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
                buildGroupCheckbox(checkallHeaders),
                const Divider(
                  color: Colors.white,
                ),
                ...allHeaderDetails.map(buildSingleCheckbox).toList(),
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
                buildGroupCheckbox(checkalltransactions),
                const Divider(
                  color: Colors.white,
                ),
                ...allTransactionDetails.map(buildSingleCheckbox).toList(),
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
                buildGroupCheckbox(checkallfooterDetails),
                const Divider(
                  color: Colors.white,
                ),
                ...allfooterDetails.map(buildSingleCheckbox).toList(),
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
              allProperties.every((notification) => notification.value);
          allCheckedProperties.contains(checkbox.title)
              ? allCheckedProperties.remove(checkbox.title)
              : allCheckedProperties.add(checkbox.title);
          //  allCheckedProperties.add(checkbox.title);
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
  Widget buildGroupCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.red,
        title: Text(
          checkbox.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        value: checkbox.value,
        onChanged: toggleGroupCheckBox,
      );
  void toggleGroupAllCheckBox(bool? value) {
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

  toggleGroupCheckBox(
    bool? value,
  ) {
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

  toggleGroupCheckBox1(
    bool? value,
  ) {
    if (value == null) {
      return;
    }
    setState(() {
      // setState(() {
      checkallHeaders.value = value;
      for (var property in allProperties) {
        property.value = value;
      }
      if (value == true) {
        for (var property in allHeaderDetails) {
          setState(() {
            allCheckedProperties.contains(property.index)
                ? null
                : allCheckedProperties.add(property.index);
          });
        }
      } else {
        setState(() {
          for (var item in allHeaderDetails) {
            if (allCheckedProperties.contains(item.index)) {
              setState(() {
                allCheckedProperties.remove(item.index);
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
      for (var property in allTransactionDetails) {
        property.value = value;
      }
      if (value == true) {
        for (var property in allTransactionDetails) {
          setState(() {
            allCheckedProperties.contains(property.index)
                ? null
                : allCheckedProperties.add(property.index);
          });
        }
      } else {
        setState(() {
          for (var item in allTransactionDetails) {
            if (allCheckedProperties.contains(item.index)) {
              setState(() {
                allCheckedProperties.remove(item.index);
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
      for (var property in allfooterDetails) {
        property.value = value;
      }
      if (value == true) {
        for (var property in allfooterDetails) {
          setState(() {
            allCheckedProperties.contains(property.index)
                ? null
                : allCheckedProperties.add(property.index);
          });
        }
      } else {
        setState(() {
          for (var item in allfooterDetails) {
            if (allCheckedProperties.contains(item.index)) {
              setState(() {
                allCheckedProperties.remove(item.index);
              });
            }
          }
        });
      }
      // });
    });
  }
}
