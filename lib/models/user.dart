class User {
  final String id;
  final String name;
  final String level;
  final String points;
  final String completedLectures;
  final List<String> enrolledCourses;

  User({
    this.name,
    this.id,
    this.completedLectures,
    this.enrolledCourses,
    this.level,
    this.points,
  });

  factory User.fromDoc(doc) {
    return User(
      name: doc['name'],
      level: doc['level'],
      points: doc['points'],
      completedLectures: doc.collection('completedLectures').length,
      enrolledCourses: doc['enrolledCourses'],
      id: doc.documentID,
    );
  }
}
