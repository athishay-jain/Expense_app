import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expance_app/Online/Firebase/firebase_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../app_constants.dart';
import '../Models/expense_model.dart';
import '../Models/filterExpenseModel.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  FirebaseServices firebase;

  ExpenseBloc({required this.firebase}) : super(ExpenseIntialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
    try{
      await firebase.addData(newExpense: event.newExpense);
        emit(ExpenseSuccessState());
      await emit.forEach(
        firebase.queryExpense(),
        onData: (data) {
          List<FilterdExpenseModel> filter =
          filterExpenses(mExp: data, );
          List<FilterdExpenseModel> limit = ExpenseLimit(mExp: data);
          return ExpenseLoadedlState(mExpenses: filter, expenseLimit: limit);
        },
      );
    }on FirebaseException catch(e){
      emit(ExpenseErrorState(errorMes: e.message??""));
    }catch(e){
      emit(ExpenseErrorState(errorMes: "The could not added : $e"));
    }

    });

    on<UpdateExpenseEvent>((event,emit)async {
      emit(ExpenseLoadingState());

      try {
        print("the uid is ${event.newExpense.expence_id}");
        firebase.updateData(updateExpense: event.newExpense, uid: event.newExpense.expence_id!);
      }
      on FirebaseException catch(e){
        emit(ExpenseErrorState(errorMes: e.message!));
      }
      catch(e){
        emit(ExpenseErrorState(errorMes: e.toString()));
      };
    });
    on<DeleteExpenseEvent>((event,emit){
      try{
        firebase.deleteData(uid: event.uId);
      }
      on FirebaseException catch(e){
        emit(ExpenseErrorState(errorMes: e.message!));
      }
      catch(e){
        emit(ExpenseErrorState(errorMes: e.toString()));
      }
    });
    on<GetIntialExpense>((event, emit) async {
      try {
        await emit.forEach(
          firebase.queryExpense(),
          onData: (data) {
            List<FilterdExpenseModel> filter =
                filterExpenses(mExp: data, filterType: event.filtertype);
            List<FilterdExpenseModel> limit = ExpenseLimit(mExp: data);
            return ExpenseLoadedlState(mExpenses: filter, expenseLimit: limit);
          },
        );
      } on FirebaseException catch (e) {
        emit(ExpenseErrorState(errorMes: e.message ?? ""));
      } catch (e) {
        emit(ExpenseErrorState(errorMes: e.toString()));
      }
    });
    on<Setexpenselimit>((event, emit) async {
      emit(ExpenseLoadingState());

    });
  }

  List<FilterdExpenseModel> ExpenseLimit({required List<ExpenseModel> mExp}) {
    Set<String> uniqueDates = {};
    DateFormat df = DateFormat.yMMM();
    List<FilterdExpenseModel> FiltredData = [];
    for (ExpenseModel eachExp in mExp) {
      String eachDate = df
          .format(DateTime.fromMillisecondsSinceEpoch(
              int.parse(eachExp.expance_date)))
          .toString();

      uniqueDates.add(eachDate);
    }

    for (String eachDate in uniqueDates) {
      num bal = 0.0;
      List<ExpenseModel> selectedExpense = [];
      num expense = 0;
      num income = 0;
      for (ExpenseModel eachExp in mExp) {
        String expeDate = df.format(DateTime.fromMillisecondsSinceEpoch(
            int.parse(eachExp.expance_date)));

        if (eachDate == expeDate) {
          selectedExpense.add(eachExp);

          if (eachExp.expence_type == 1) {
            expense -= eachExp.expance_amount;
            bal -= eachExp.expance_amount;
          } else {
            income += eachExp.expance_amount;
            bal += eachExp.expance_amount;
          }
        }
      }
      FiltredData.add(FilterdExpenseModel(
          title: eachDate,
          allExpense: selectedExpense,
          bal: bal,
          income: income,
          expense: expense));
    }
    return FiltredData;
  }

  List<FilterdExpenseModel> filterExpenses({
    required List<ExpenseModel> mExp,
    int filterType = 1,
  }) {
    Set<String> uniqueDates = {};

    List<FilterdExpenseModel> FiltredData = [];


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
        num expense = 0;
        num income = 0;
        List<ExpenseModel> eachCatExp = [];
        for (ExpenseModel eachExp in mExp) {
          if (eachExp.expance_category == eachCat["id"]) {
            if (eachExp.expence_type == 1) {
              eachCatExp.add(eachExp);
            }

            if (eachExp.expence_type == 1) {
              expense -= eachExp.expance_amount;
              bal -= eachExp.expance_amount;
            } else {
              income += eachExp.expance_amount;
              bal += eachExp.expance_amount;
            }
          }
        }
        if (eachCatExp.isNotEmpty) {
          FiltredData.add(FilterdExpenseModel(
              title: eachCat["title"],
              allExpense: eachCatExp,
              bal: bal,
              income: income,
              expense: expense));
        }
      }
      for (Map<String, dynamic> eachCat in AppConstansts.incomeCategoryItems) {
        num bal = 0.0;
        num expense = 0;
        num income = 0;
        List<ExpenseModel> eachCatExp = [];
        for (ExpenseModel eachExp in mExp) {
          if (eachExp.expance_category == eachCat["id"]) {
            if (eachExp.expence_type == 0) {
              eachCatExp.add(eachExp);
            }

            if (eachExp.expence_type == 1) {
              expense -= eachExp.expance_amount;
              bal -= eachExp.expance_amount;
            } else {
              income += eachExp.expance_amount;
              bal += eachExp.expance_amount;
            }
          }
        }
        if (eachCatExp.isNotEmpty) {
          FiltredData.add(FilterdExpenseModel(
              title: eachCat["title"],
              allExpense: eachCatExp,
              bal: bal,
              income: income,
              expense: expense));
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

      for (String eachDate in uniqueDates) {
        num bal = 0.0;
        List<ExpenseModel> selectedExpense = [];
        num expense = 0;
        num income = 0;
        for (ExpenseModel eachExp in mExp) {
          String expeDate = df.format(DateTime.fromMillisecondsSinceEpoch(
              int.parse(eachExp.expance_date)));

          if (eachDate == expeDate) {
            selectedExpense.add(eachExp);

            if (eachExp.expence_type == 1) {
              expense -= eachExp.expance_amount;
              bal -= eachExp.expance_amount;
            } else {
              income += eachExp.expance_amount;
              bal += eachExp.expance_amount;
            }
          }
        }
        FiltredData.add(FilterdExpenseModel(
            title: eachDate,
            allExpense: selectedExpense,
            bal: bal,
            income: income,
            expense: expense));
      }
    }

    return FiltredData;
  }
}
