/// Extensions to change case of strings.
extension StringCaseExtensions on String {
  String sentenceCase() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String titleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((String str) => str.sentenceCase())
      .join(' ');
}
