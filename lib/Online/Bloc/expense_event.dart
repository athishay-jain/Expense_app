


import '../Models/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}
class UpdateExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  UpdateExpenseEvent({required this.newExpense});
}
class DeleteExpenseEvent extends ExpenseEvent{
  String uId;
  DeleteExpenseEvent({required this.uId});
}
class Setexpenselimit extends ExpenseEvent{
  double limit;
  Setexpenselimit({required this.limit});
}
class GetIntialExpense extends ExpenseEvent{
int filtertype;
GetIntialExpense({required this.filtertype});
}