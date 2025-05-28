abstract class ExpenseState {}
class ExpenseIntialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{}
class ExpenseSuccefullState extends ExpenseState{}
class ExpenseErrorStete extends ExpenseState{
  String errorMes;
  ExpenseErrorStete({required this.errorMes});
}