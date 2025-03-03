import 'dart:io';

void main() {
  final rootDirectory = Directory.current;
  final contextFile = File('context.md');

  void processDirectory(Directory directory) {
    for (var fileOrDir in directory.listSync()) {
      if (fileOrDir is File &&
          fileOrDir.path.endsWith('.dart') &&
          !fileOrDir.path.endsWith('.g.dart')) {
        final fileName = fileOrDir.path.split('/').last;
        final fileContent = fileOrDir.readAsStringSync();

        contextFile.writeAsStringSync('# $fileName\n', mode: FileMode.append);
        contextFile.writeAsStringSync('```dart\n', mode: FileMode.append);
        contextFile.writeAsStringSync(fileContent, mode: FileMode.append);
        contextFile.writeAsStringSync('\n```\n', mode: FileMode.append);
      } else if (fileOrDir is Directory) {
        processDirectory(fileOrDir);
      }
    }
  }

  contextFile.writeAsStringSync('# Dart Files\n');
  processDirectory(rootDirectory);
  print('context.md file generated successfully.');
}
