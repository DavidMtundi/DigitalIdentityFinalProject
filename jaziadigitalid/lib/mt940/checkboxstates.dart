class CheckBoxState {
  final String title;
  bool value;
  CheckBoxState({
    required this.title,
    this.value = false,
  });
}

final checkAllProperties = CheckBoxState(
  title: "All Properties",
);
final allCheckedProperties = [];
final allProperties = [
  CheckBoxState(title: "Transaction"),
  CheckBoxState(title: "Opening Balance"),
  CheckBoxState(title: "Closing Balance"),
  CheckBoxState(title: "Date Received"),
  CheckBoxState(title: "Amount Deposited"),
  CheckBoxState(title: "Transaction"),
  CheckBoxState(title: "Opening Balance"),
  CheckBoxState(title: "Closing Balance"),
  CheckBoxState(title: "Date Received"),
  CheckBoxState(title: "Amount Deposited"),
  CheckBoxState(title: "Transaction"),
  CheckBoxState(title: "Opening Balance"),
  CheckBoxState(title: "Closing Balance"),
  CheckBoxState(title: "Date Received"),
  CheckBoxState(title: "Amount Deposited"),
  CheckBoxState(title: "Amount Deposited"),
  CheckBoxState(title: "Transaction"),
  CheckBoxState(title: "Opening Balance"),
  CheckBoxState(title: "Closing Balance"),
  CheckBoxState(title: "Date Received"),
  CheckBoxState(title: "Amount Deposited")
];
