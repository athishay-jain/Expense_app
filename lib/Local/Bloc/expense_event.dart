import 'package:expance_app/Local/Models/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}
class GetIntialExpense extends ExpenseEvent{
int filtertype;
GetIntialExpense({required this.filtertype});
}