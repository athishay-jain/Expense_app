import 'package:expance_app/Local/Bloc/expense_event.dart';
import 'package:expance_app/Local/Bloc/expense_state.dart';
import 'package:expance_app/Local/Database/Dbhelper.dart';
import 'package:expance_app/Local/Models/expense_model.dart';
import 'package:expance_app/Local/Models/filterExpenseModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_constants.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  Dbhelper dbhelper;

  List<FilterdExpenseModel> filterExpenses(
      {required List<ExpenseModel> mExp, int filterType = 1}) {
    DateFormat df = DateFormat();
if(filterType == 1){
   df = DateFormat.yMMMEd();
}
if(filterType == 2){
   df = DateFormat.yMMM();
}
if(filterType == 3){
  df = DateFormat.y();
}

    Set<String> uniqueDates = {};

    List<FilterdExpenseModel> FiltredData = [];

    for (ExpenseModel eachExp in mExp) {
      String eachDate = df
          .format(DateTime.fromMillisecondsSinceEpoch(
          int.parse(eachExp.expance_date)))
          .toString();

        uniqueDates.add(eachDate);

    }
      print("These are the Unique dates : $uniqueDates");
      for (String eachDate in uniqueDates) {
        num bal = 0.0;
        List<ExpenseModel> selectedExpense = [];

        for (ExpenseModel eachExp in mExp) {
          String expeDate = df.format(DateTime.fromMillisecondsSinceEpoch(
              int.parse(eachExp.expance_date)));

          if (eachDate == expeDate) {
            selectedExpense.add(eachExp);

            if (eachExp.expence_type == 1) {
              bal -= eachExp.expance_amount;
            } else {
              bal += eachExp.expance_amount;
            }
          }
        }
        print(" $eachDate : $bal ${selectedExpense.length}");
        FiltredData.add(FilterdExpenseModel(
            title: eachDate, allExpense: selectedExpense, bal: bal));
      }

    return FiltredData;
  }

  ExpenseBloc({required this.dbhelper}) : super(ExpenseIntialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      bool check = await dbhelper.addExpense(newexpense: event.newExpense);
      if (check) {
        var expenses = await dbhelper.fetchExpense();
        emit(ExpenseLoadedlState(mExpenses: filterExpenses(mExp: expenses)));
      } else {
        emit(ExpenseErrorStete(
            errorMes: "Something went wrong transaction didn't add"));
      }
    });
    on<GetIntialExpense>((event,emit)async{
      emit(ExpenseLoadingState());
      var expenses = await dbhelper.fetchExpense();

      emit(ExpenseLoadedlState(mExpenses: filterExpenses(mExp: expenses,filterType: event.filtertype)));
    });
  }
}
