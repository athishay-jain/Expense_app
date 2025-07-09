

import 'expense_model.dart';

class FilterdExpenseModel {
  String title;
  num bal;
  List<ExpenseModel> allExpense;
  num? expense= 0;
  num? income=0;

  FilterdExpenseModel({
    required this.title,
    required this.allExpense,
    required this.bal,
    this.expense,
    this.income,
  });
}
