import 'dart:io';

import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jaziadigitalid/Functions/firebasefunc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DIRegister extends StatefulWidget {
  DIRegister({Key? key}) : super(key: key);

  @override
  State<DIRegister> createState() => _DIRegisterState();
}

class _DIRegisterState extends State<DIRegister> {
  int _activeStepIndex = 0;
  final personaldetails = GlobalKey<FormState>();
  final parentaldetails = GlobalKey<FormState>();
  final locationdetails = GlobalKey<FormState>();
  final voucherdetails = GlobalKey<FormState>();

  //person's details
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController work = TextEditingController();
  DateTime dob = DateTime.now();
  TextEditingController age = TextEditingController();
  TextEditingController maritalStatus = TextEditingController();
  //parents details
  TextEditingController fathername = TextEditingController();
  TextEditingController mothername = TextEditingController();
  //grandparet details
  TextEditingController grandmothername = TextEditingController();
  TextEditingController grandfathername = TextEditingController();
//location details
  TextEditingController location = TextEditingController();
  TextEditingController sublocation = TextEditingController();
  TextEditingController village = TextEditingController();

  //voucher details
  String selectedVouchertype = "";
  TextEditingController voucheruniqueid = TextEditingController();
  TextEditingController voucherpassword = TextEditingController();

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  List<ImageObject> _imgObjs = [];

  String _selectedMarital = "Marital Status";

  String _selectedVoucher = "Voucher Type";

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        setState(() {
          dob = DateTime.parse(args.value.toString());
        });
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Personal Details'),
          content: Form(
            key: personaldetails,
            child: Column(
              children: [
                Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _imgObjs.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              itemCount: _imgObjs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 2),
                              itemBuilder: (BuildContext context, int index) {
                                final image = _imgObjs[index];
                                return Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Image.file(File(image.modifiedPath),
                                      height: 80, fit: BoxFit.cover),
                                );
                              })
                          : const Text("Please Add Your Picture"),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _imgObjs.isEmpty
                                ? const Text("Add Photo")
                                : const Text("Update Photos"),
                            IconButton(
                              onPressed: () async {
                                var status = await Permission.camera.status;
                                var storagestatus =
                                    await Permission.storage.status;
                                if ((status.isDenied) ||
                                    (storagestatus.isDenied)) {
                                  status.isDenied
                                      ? await Permission.camera.request()
                                      : await Permission.storage.request();
                                  // We didn't ask for permission yet or the permission has been denied before but not permanently.
                                }
                                // Get max 5 images
                                else {
                                  final List<ImageObject>? objects =
                                      await Navigator.of(context).push(
                                          PageRouteBuilder(pageBuilder:
                                              (context, animation, __) {
                                    return const ImagePicker(maxCount: 3);
                                  }));

                                  if ((objects?.length ?? 0) > 0) {
                                    setState(() {
                                      _imgObjs = objects!;
                                    });
                                  }
                                }
                              },
                              icon: _imgObjs.length < 2
                                  ? const Icon(Icons.add)
                                  : const Icon(Icons.update_sharp),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: firstname,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: lastname,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: work,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Work',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Date of Birth",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(
                      DateTime.now().subtract(const Duration(days: 4)),
                      DateTime.now().add(const Duration(days: 3))),
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownButton<String>(
                  hint: Text(_selectedMarital.toString()),
                  items: <String>['Single', 'Married'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMarital = value.toString();
                    });
                  },
                )
              ],
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Parental Details'),
          content: Form(
            key: parentaldetails,
            child: Container(
              child: Column(
                children: [
                  TextField(
                    controller: fathername,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Father Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: mothername,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Mother Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: grandfathername,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full GrandFather Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: grandmothername,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Grandmother Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Location Address'),
            content: Form(
              key: locationdetails,
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: location,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: ' Location',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: sublocation,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sub Location',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: village,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Village',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            )),
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Voucher Details'),
          content: Form(
            key: voucherdetails,
            child: Container(
              child: Column(
                children: [
                  DropdownButton<String>(
                    hint: Text(_selectedVoucher.toString()),
                    items: <String>['Chief', 'Official'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedVoucher = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: voucheruniqueid,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Voucher Uniquie Id',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: voucherpassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Voucher Password',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Full Name : ${firstname.text}  ${lastname.text}'),
                Text('Father Name: ${fathername.text}'),
                //     const Text('Password: *****'),
                Text('Mother Name : ${mothername.text}'),

                Text('Voucher Id : ${voucheruniqueid.text}'),
              ],
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' Digital Identity Registration Form',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () async {
            if (_activeStepIndex < (stepList().length - 1)) {
              setState(() {
                _activeStepIndex += 1;
              });
            } else {
              print('Submited');
//print set a unique 6 random numbers and send them
              //add to the database
              await FirebaseFunc().savePersonDetails(
                  firstname.text.toString(),
                  lastname.value.text.trim(),
                  work.value.text.trim(),
                  dob,
                  fathername.value.text.trim(),
                  mothername.value.text.trim(),
                  grandfathername.value.text.trim(),
                  grandmothername.value.text.trim(),
                  location.value.text.trim(),
                  sublocation.value.text.trim(),
                  village.value.text.trim(),
                  _selectedVoucher,
                  voucheruniqueid.value.text.trim(),
                  await FirebaseFunc().uploadAllImages(_imgObjs));
              //  print(_imgObjs);
              //await FirebaseFunc().uploadAllImages(_imgObjs);
              print('Submited');

              //!TODO:
            }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }
            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeStepIndex = index;
            });
          },
        ),
      ),
    );
  }
}
