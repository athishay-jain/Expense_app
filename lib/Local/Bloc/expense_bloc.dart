import 'package:expance_app/Local/Bloc/expense_event.dart';
import 'package:expance_app/Local/Bloc/expense_state.dart';
import 'package:expance_app/Local/Database/Dbhelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{
  ExpenseBloc({required this.dbhelper}) : super(ExpenseIntialState()){
    on<AddExpenseEvent>((event,emit){
      emit(ExpenseLoadingState());
    }
    );
  }
  Dbhelper dbhelper;

}