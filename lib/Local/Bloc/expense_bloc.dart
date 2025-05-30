import 'package:expance_app/Local/Bloc/expense_event.dart';
import 'package:expance_app/Local/Bloc/expense_state.dart';
import 'package:expance_app/Local/Database/Dbhelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_constants.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{
  Dbhelper dbhelper;
  ExpenseBloc({required this.dbhelper}) : super(ExpenseIntialState()){
    on<AddExpenseEvent>((event,emit)async{
      emit(ExpenseLoadingState());
      bool check = await dbhelper.addExpense(newexpense: event.newExpense);
      if(check){
        /// adding the last balance is Prefs
       SharedPreferences Prefs = await SharedPreferences.getInstance();
        Prefs.setDouble(AppConstansts.lastBalance, event.newExpense.expance_balance ?? 0);
       emit( ExpenseSuccefullState());
      }
      else{
       emit (ExpenseErrorStete(errorMes: "Something went wrong transaction didn't add"));
      }
    }
    );
  }

}