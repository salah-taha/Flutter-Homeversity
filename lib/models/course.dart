class Course {
  final String title;
  final String imageUrl;
  final String teacherName;
  final String lecturesNum;
  final String teacherImageUrl;
  final String targetedLevel;
  final String description;
  final String studentsNum;

  Course({
    this.imageUrl,
    this.description,
    this.studentsNum,
    this.teacherImageUrl,
    this.title,
    this.teacherName,
    this.lecturesNum,
    this.targetedLevel,
  });

  factory Course.fromDoc(doc) {
    return Course(
      title: doc['title'],
      imageUrl: doc['imageUrl'],
      teacherName: doc['teacherName'],
      lecturesNum: doc['lecturesNum'],
      teacherImageUrl: doc['teaacherImageUrl'],
      targetedLevel: doc['level'],
      description: doc['description'],
      studentsNum: doc['studentsNum'],
    );
  }
}
