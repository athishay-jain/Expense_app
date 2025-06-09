import 'package:expance_app/Local/Models/filterExpenseModel.dart';

abstract class ExpenseState {}
class ExpenseIntialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{}
class ExpenseLoadedlState extends ExpenseState{
  List<FilterdExpenseModel> mExpenses;
  ExpenseLoadedlState({required this.mExpenses});
}
class ExpenseErrorState extends ExpenseState{
  String errorMes;

  ExpenseErrorState({required this.errorMes});
}