import 'dart:convert';

class Student {
  String name;
  double caScore;
  double examScore;
  double projectScore;

  Student(this.name, this.caScore, this.examScore, this.projectScore);

  double get totalScore => caScore + examScore + projectScore;

  String get letterGrade {
    final total = totalScore;
    if (total >= 80) return 'A';
    if (total >= 75) return 'B+';
    if (total >= 70) return 'B';
    if (total >= 65) return 'C+';
    if (total >= 60) return 'C';
    if (total >= 55) return 'D+';
    if (total >= 50) return 'D';
    if (total >= 45) return 'E';
    return 'F';
  }
}

void main() {
  print('UENR GRADE CALCULATOR (Batch Mode)');
  print('================================\n');

  final students = <Student>[];

  // Hardcoded student data for demonstration purposes.

  final predefinedStudentData = [
    {
      'name': 'Alice Johnson',
      'ca': 25.0,
      'exam': 40.0,
      'project': 18.0,
    }, // Total: 83.0 (A)
    {
      'name': 'Bob Williams',
      'ca': 15.0,
      'exam': 30.0,
      'project': 10.0,
    }, // Total: 55.0 (D+)
    {
      'name': 'Charlie Brown',
      'ca': 28.0,
      'exam': 48.0,
      'project': 20.0,
    }, // Total: 96.0 (A)
    {
      'name': 'Diana Prince',
      'ca': 10.0,
      'exam': 25.0,
      'project': 8.0,
    }, // Total: 43.0 (F)
    {
      'name': 'Eve Adams',
      'ca': 22.0,
      'exam': 35.0,
      'project': 15.0,
    }, // Total: 72.0 (B)
  ];

  print('Processing predefined student records...\n');
  for (var data in predefinedStudentData) {
    try {
      final name = data['name'] as String;
      final ca = data['ca'] as double;
      final exam = data['exam'] as double;
      final project = data['project'] as double;
      students.add(Student(name, ca, exam, project));
      print('Added record for: $name');
    } catch (e) {
      print('Error processing data for student: $data - $e');
    }
  }
  print('\nAll predefined records processed.');

  if (students.isEmpty) {
    print('No student records processed. Exiting.');
    return;
  }

  _displayResults(students);
  _exportToJson(students);
}

void _displayResults(List<Student> students) {
  print('\nGRADE REPORT');
  print('============');
  for (var student in students) {
    print('Name: ${student.name}');
    print('CA: ${student.caScore.toStringAsFixed(2)}');
    print('Exam: ${student.examScore.toStringAsFixed(2)}');
    print('Project: ${student.projectScore.toStringAsFixed(2)}');
    print('Total: ${student.totalScore.toStringAsFixed(2)}');
    print('Grade: ${student.letterGrade}');
    print('----------------');
  }
}

void _exportToJson(List<Student> students) {
  final records = students
      .map(
        (s) => {
          'name': s.name,
          'caScore': s.caScore,
          'examScore': s.examScore,
          'projectScore': s.projectScore,
          'totalScore': s.totalScore,
          'letterGrade': s.letterGrade,
          'timestamp': DateTime.now().toIso8601String(),
        },
      )
      .toList();

  // Due to environment limitations (no dart:io support for File operations),
  // the JSON report will be printed directly to the console instead of a file.
  print('\nJSON Export (to console):');
  try {
    const encoder = JsonEncoder.withIndent('  '); // Pretty print JSON
    print(encoder.convert(records));
    print('\nJSON report successfully generated and printed to console.');
  } catch (e) {
    print('\nError generating JSON report: $e');
  }
}
