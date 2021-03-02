class Task {
  final String value;
  final String desc;
  final String color;
  Task(this.desc,this.value,this.color);

  Task.fromMap(Map<String, dynamic> map)
      : assert(map['desc'] != null),
        assert(map['value'] != null),
        assert(map['color'] != null),
        desc = map['desc'],
        value = map['value'],
        color=map['color'];

  @override
  String toString() => "Record<$value:$desc>";
  // String toString() => "Record<$value:$desc>";
}