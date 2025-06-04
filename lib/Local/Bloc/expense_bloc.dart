import 'package:expance_app/Local/Bloc/expense_event.dart';
import 'package:expance_app/Local/Bloc/expense_state.dart';
import 'package:expance_app/Local/Database/Dbhelper.dart';
import 'package:expance_app/Local/Models/expense_model.dart';
import 'package:expance_app/Local/Models/filterExpenseModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../app_constants.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  Dbhelper dbhelper;

  List<FilterdExpenseModel> filterExpenses(
      {required List<ExpenseModel> mExp, int filterType = 1}) {
    Set<String> uniqueDates = {};

    List<FilterdExpenseModel> FiltredData = [];

    List<String> uniqueCat = [];
    List<String> uniqueexp = [];
    Map<String, List<String>> uniqueCats = {};

    DateFormat df = DateFormat();
    if (filterType == 1) {
      df = DateFormat.yMMMEd();
    }
    if (filterType == 2) {
      df = DateFormat.yMMM();
    }
    if (filterType == 3) {
      df = DateFormat.y();
    }
    if (filterType == 4) {
      /*for (ExpenseModel each in mExp) {
        String catint = each.expance_category.toString();
        String expType = each.expence_type.toString();

        // Check if the key already exists in the map
        if (!uniqueCats.containsKey(catint)) {
          uniqueCats[catint] = [];
        }

        // Always add expType, allowing duplicates within each category
        uniqueCats[catint]!.add(expType);
      }

      print("the new logic $uniqueCats");

      for (ExpenseModel each in mExp) {
        String catint = each.expance_category.toString();
        if(!uniqueCat.contains(catint) ){
          uniqueCat.add(catint);
        }
      }
      print("These are the Unique categary are  : $uniqueCat");
*/
      for (Map<String, dynamic> eachCat in AppConstansts.expenseCategoryItems) {
        num bal = 0.0;
        List<ExpenseModel> eachCatExp = [];
        for (ExpenseModel eachExp in mExp) {
          if (eachExp.expance_category == eachCat["id"]) {
            if (eachExp.expence_type == 1) {
              eachCatExp.add(eachExp);
            }

            if (eachExp.expence_type == 1) {
              bal -= eachExp.expance_amount;
            } else {
              bal += eachExp.expance_amount;
            }
          }
        }
        if (eachCatExp.isNotEmpty) {
          FiltredData.add(FilterdExpenseModel(
              title: eachCat["title"], allExpense: eachCatExp, bal: bal));
        }
      }
      for (Map<String, dynamic> eachCat in AppConstansts.incomeCategoryItems) {
        num bal = 0.0;
        List<ExpenseModel> eachCatExp = [];
        for (ExpenseModel eachExp in mExp) {
          if (eachExp.expance_category == eachCat["id"]) {
            if (eachExp.expence_type == 0) {
              eachCatExp.add(eachExp);
            }

            if (eachExp.expence_type == 1) {
              bal -= eachExp.expance_amount;
            } else {
              bal += eachExp.expance_amount;
            }
          }
        }
        if (eachCatExp.isNotEmpty) {
          FiltredData.add(FilterdExpenseModel(
              title: eachCat["title"], allExpense: eachCatExp, bal: bal));
        }
      }
    } else {
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
    on<GetIntialExpense>((event, emit) async {
      emit(ExpenseLoadingState());
      var expenses = await dbhelper.fetchExpense();

      emit(ExpenseLoadedlState(
          mExpenses:
              filterExpenses(mExp: expenses, filterType: event.filtertype)));
    });
  }
}
