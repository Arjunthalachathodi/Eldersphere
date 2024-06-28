class Volunteer {
  final String name;
  final String uid;

  Volunteer(this.name, this.uid);

  // Override == operator to compare Volunteer objects based on both name and uid
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Volunteer &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              uid == other.uid;

  // Override hashCode to be consistent with the overridden == operator
  @override
  int get hashCode => name.hashCode ^ uid.hashCode;
}