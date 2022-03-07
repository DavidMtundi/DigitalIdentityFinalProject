class CheckBoxState {
  final String title;
  bool value;
  int index;
  CheckBoxState({
    required this.title,
    this.value = false,
    required this.index
  });
}

final checkAllProperties = CheckBoxState(
  title: "All Properties",
  index: 23
);
final checkallHeaders = CheckBoxState(title: "All Header Details", index: 1);
final headerDetails = [
  CheckBoxState(title: "Statement Date", index: 4),
  CheckBoxState(title: "Account  Number", index: 5),
  CheckBoxState(title: "Bank Statement Number", index: 6),
  CheckBoxState(title: "Opening Balance", index: 7),
];
final checkalltransactions = CheckBoxState(title: "All Transaction Details", index: 2);
final transactiondetails = [
  CheckBoxState(title: "Transaction Date", index: 8),
  CheckBoxState(title: "Posting  Date",index: 9),
  CheckBoxState(title: "is Credit", index: 10),
  CheckBoxState(title: "Currency", index: 11),
  CheckBoxState(title: "Transaction Code", index: 12),
  CheckBoxState(title: "Transaction Type", index: 13),
];

final checkallfooterDetails = CheckBoxState(title: "All Footer Details", index: 3);
final footerdetails = [
  CheckBoxState(title: " Date", index: 14),
  CheckBoxState(title: "Currency", index: 15),
  CheckBoxState(title: "Amount", index: 16),
  CheckBoxState(title: "is Credit", index: 17),
  CheckBoxState(title: "Available Balance", index: 18),
  CheckBoxState(title: "is Credit", index: 19),
  CheckBoxState(title: "Currency", index: 20),
  CheckBoxState(title: "Amount", index: 21),
];

final allCheckedProperties = [];
final allProperties = [
  CheckBoxState(title: "Statement Date", index: 4),
  CheckBoxState(title: "Account  Number", index: 5),
  CheckBoxState(title: "Bank Statement Number", index: 6),
  CheckBoxState(title: "Opening Balance", index: 7),
  CheckBoxState(title: "Transaction Date", index: 8),
  CheckBoxState(title: "Posting  Date", index: 9),
  CheckBoxState(title: "is Credit", index: 10),
  CheckBoxState(title: "Currency", index: 11),
  CheckBoxState(title: "Transaction Code", index: 12),
  CheckBoxState(title: "Transaction Type", index: 13),
  CheckBoxState(title: " Date", index: 14),
  CheckBoxState(title: "Currency", index: 15),
  CheckBoxState(title: "Amount", index: 16),
  CheckBoxState(title: "is Credit", index: 17),
  CheckBoxState(title: "Available Balance", index: 18),
  CheckBoxState(title: "is Credit", index: 19),
  CheckBoxState(title: "Currency", index: 20),
  CheckBoxState(title: "Amount", index: 21),
];
