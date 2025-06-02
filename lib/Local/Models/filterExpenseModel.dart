import 'package:expance_app/Local/Models/expense_model.dart';

class FilterdExpenseModel {
  String title;
  num bal;
  List<ExpenseModel> allExpense;

  FilterdExpenseModel({
    required this.title,
    required this.allExpense,
    required this.bal,
  });
}
