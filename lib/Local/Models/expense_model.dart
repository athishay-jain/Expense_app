import 'package:expance_app/Local/Database/Dbhelper.dart';

class ExpenseModel {
  String? expence_id;
  String expance_title;
  String expance_description;
  String expance_amount;
  String expance_balance;
  String expance_category;
  String expance_date;
  String expence_type;
  int? user_id;

  ExpenseModel({
    required this.expance_title,
    required this.expance_description,
    required this.expance_amount,
    required this.expance_balance,
    required this.expance_category,
    required this.expance_date,
    required this.expence_type,
    this.user_id,
    this.expence_id,
  });

  factory ExpenseModel.frommap(Map<String, dynamic> map) => ExpenseModel(
        expence_id: map[Dbhelper.expence_id],
        expance_title: map[Dbhelper.expance_title],
        expance_description: map[Dbhelper.expance_description],
        expance_amount: map[Dbhelper.expance_amount],
        expance_balance: map[Dbhelper.expance_balance],
        expance_category: map[Dbhelper.expance_category],
        expance_date: map[Dbhelper.expance_date],
        expence_type: map[Dbhelper.expence_type],
        user_id: map[Dbhelper.user_id],
      );

  Map<String, dynamic> tomap() => {
        Dbhelper.expance_title: expance_title,
        Dbhelper.expance_description: expance_description,
        Dbhelper.expance_amount: expance_amount,
        Dbhelper.expance_balance: expance_balance,
        Dbhelper.expance_category: expance_category,
        Dbhelper.expance_date: expance_date,
        Dbhelper.expence_type: expence_type,
        Dbhelper.user_id: user_id,
      };
}
