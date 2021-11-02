class Transaction {
  late String id;
  late String title;
  double amount = 0;
  late DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
