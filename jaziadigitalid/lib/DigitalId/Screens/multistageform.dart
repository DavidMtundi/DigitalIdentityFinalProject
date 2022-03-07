import 'dart:io';

import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jaziadigitalid/DigitalId/Functions/constants.dart';
import 'package:jaziadigitalid/DigitalId/Screens/customDrawer.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Functions/firebasefunc.dart';
import '../Widgets/InputField.dart';

class DIRegister extends StatefulWidget {
  DIRegister({Key? key}) : super(key: key);

  @override
  State<DIRegister> createState() => _DIRegisterState();
}

class _DIRegisterState extends State<DIRegister> {
  int _activeStepIndex = 0;
  bool isloading = false;

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

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

  final TextEditingController _textFieldController = TextEditingController();

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (_formKeys[_activeStepIndex].currentState!.validate()) {
      setState(() {
        // isloading =true;
      });
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
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Personal Details'),
          content: Form(
            key: _formKeys[0],
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
                      InkWell(
                        onTap: () async {
                          var status = await Permission.camera.status;
                          var storagestatus = await Permission.storage.status;
                          if ((status.isDenied) || (storagestatus.isDenied)) {
                            status.isDenied
                                ? await Permission.camera.request()
                                : await Permission.storage.request();
                            // We didn't ask for permission yet or the permission has been denied before but not permanently.
                          }
                          // Get max 5 images
                          else {
                            final List<ImageObject>? objects =
                                await Navigator.of(context).push(
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation, __) {
                              return const ImagePicker(maxCount: 3);
                            }));

                            if ((objects?.length ?? 0) > 0) {
                              setState(() {
                                _imgObjs = objects!;
                              });
                            }
                          }
                        },
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _imgObjs.isEmpty
                                  ? const Text(
                                      "Add Photo",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Text("Update Photos"),
                              Icon(
                                _imgObjs.length < 2
                                    ? Icons.add
                                    : Icons.update_sharp,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                EditText(title: "First Name", textEditingController: firstname),
                const SizedBox(
                  height: 8,
                ),
                EditText(title: "Last Name", textEditingController: lastname),
                const SizedBox(
                  height: 8,
                ),
                EditText(title: "Work", textEditingController: work),
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
                // DropdownButton<String>(
                //   hint: Text(_selectedMarital.toString()),
                //   items: <String>['Single', 'Married'].map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedMarital = value.toString();
                //     });
                //   },
                // )
              ],
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Parental Details'),
          content: Form(
            key: _formKeys[1],
            child: Container(
              child: Column(
                children: [
                  EditText(
                      title: "Father's Name",
                      textEditingController: fathername),
                  const SizedBox(
                    height: 8,
                  ),
                  EditText(
                      title: "Mother's Name",
                      textEditingController: mothername),
                  const SizedBox(
                    height: 8,
                  ),
                  EditText(
                      title: "GrandFather Name",
                      textEditingController: grandfathername),
                  const SizedBox(
                    height: 8,
                  ),
                  EditText(
                      title: "GrandMother Name",
                      textEditingController: grandmothername),
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
              key: _formKeys[2],
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    EditText(
                        title: "Location", textEditingController: location),
                    const SizedBox(
                      height: 8,
                    ),
                    EditText(
                        title: "Sub Location",
                        textEditingController: sublocation),
                    const SizedBox(
                      height: 8,
                    ),
                    EditText(
                        title: "Village Name", textEditingController: village),
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
            key: _formKeys[3],
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
                  EditText(
                      title: "Voucher ID",
                      textEditingController: voucheruniqueid),
                  const SizedBox(
                    height: 8,
                  ),
                  EditText(
                      title: "Voucher Password",
                      textEditingController: voucherpassword),
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white12,
          title: const Text(
            ' Digital Identity Registration Form',
            style: TextStyle(fontSize: 16),
          ),
        ),
        backgroundColor: Colors.white,
        drawer: const SafeArea(
          child: CustomDrawer(),
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
                setState(() {
                  isloading = true;
                });
                print('Submited');

                await performOperations();
                //print set a unique 6 random numbers and send them
                //add to the database
                setState(() {
                  isloading = false;
                });
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
      ),
    );
  }

  Future saveDetails() async {
    setState(() {
      isloading = true;
    });
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
    setState(() {
      isloading = false;
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Verify the Input Code'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "verify code"),
            ),
            actions: [
              isloading
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          isloading = true;
                        });
                        validatecode(_textFieldController.value.text
                                .trim()
                                .toString())
                            ? saveDetails()
                            : Fluttertoast.showToast(
                                msg: "Incorrect Code Inputed");
                        setState(() {
                          isloading = false;
                        });
                      },
                      child: const Text("Validate ")),
            ],
          );
        });
  }

  ///Load the ima
  performOperations() async {
    randomNumber = getRandomNumber();

    ///get the randomnumber and send it to the chief
    await SendTwilioMessage("+254740204736",
        "Please Confirm that you're the one registering this person named ${firstname.value.text.trim()}  ${lastname.value.text.trim()}   \n Fathers Name : ${fathername.value.text.trim()} \n Mother name ${mothername.value.text.trim()} \n GrandFather Name : ${grandfathername.value.text.trim()} \n GrandMother name : ${grandmothername.value.text.trim()} \n Location : ${location.value.text.trim()} \n Sublocation : ${sublocation.value.text.trim()} \nVillage Name : ${village.value.text.trim()} \n Validation Code ${randomNumber.toString()}");
    await _displayTextInputDialog(context);
    //display a popup box
  }
}
