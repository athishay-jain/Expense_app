
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_constants.dart';

class ExpenseModel {
  String? expence_id;
  String expance_title;
  String expance_description;
  double expance_amount;
  double? expance_balance;
  int expance_category;
  String expance_date;
  int expence_type;
  ExpenseModel({
    required this.expance_title,
    required this.expance_description,
    required this.expance_amount,
    required this.expance_category,
    required this.expance_date,
    required this.expence_type,
    this.expance_balance,
    this.expence_id,
  });

  factory ExpenseModel.fromMap(DocumentSnapshot map) => ExpenseModel(
        expence_id: map.id,
        expance_title: map[AppConstansts.expance_title],
        expance_description: map[AppConstansts.expance_description],
        expance_amount: map[AppConstansts.expance_amount],
        expance_balance: map[AppConstansts.expance_balance],
        expance_category: map[AppConstansts.expance_category],
        expance_date: map[AppConstansts.expance_date],
        expence_type: map[AppConstansts.expence_type],
      );

  Map<String, dynamic> toMap() => {
    AppConstansts.expance_title: expance_title,
    AppConstansts.expance_description: expance_description,
    AppConstansts.expance_amount: expance_amount,
    AppConstansts.expance_balance: expance_balance,
    AppConstansts.expance_category: expance_category,
    AppConstansts.expance_date: expance_date,
    AppConstansts.expence_type: expence_type,
  };
}
