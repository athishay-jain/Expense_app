import 'package:expance_app/Local/Models/filterExpenseModel.dart';

abstract class ExpenseState {}

class ExpenseIntialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseLoadedlState extends ExpenseState {
  List<FilterdExpenseModel> mExpenses;
  List<FilterdExpenseModel> expenseLimit;
  double? prefsLimit = 0;

  ExpenseLoadedlState(
      {required this.mExpenses, required this.expenseLimit, this.prefsLimit});
}

class ExpenseErrorState extends ExpenseState {
  String errorMes;

  ExpenseErrorState({required this.errorMes});
}
