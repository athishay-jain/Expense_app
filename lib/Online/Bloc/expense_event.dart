


import '../Models/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}
class Setexpenselimit extends ExpenseEvent{
  double limit;
  Setexpenselimit({required this.limit});
}
class GetIntialExpense extends ExpenseEvent{
int filtertype;
GetIntialExpense({required this.filtertype});
}