class Sales {
  final String month;
  final String weight;
  // final String colorVal;
  // Sales(this.month,this.weight,this.colorVal);
  Sales(this.month,this.weight);

  Sales.fromMap(Map<String, dynamic> map)
      : assert(map['month'] != null),
        assert(map['weight'] != null),
        // assert(map['colorVal'] != null),
        month = map['month'],
        // colorVal = map['colorVal'],
        weight=map['weight'];

  @override
  // String toString() => "Record<$month:$weight:$colorVal>";
  String toString() => "Record<$month:$weight>";
}