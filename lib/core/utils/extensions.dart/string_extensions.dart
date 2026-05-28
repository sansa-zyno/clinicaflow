extension MyStringExtension on String {
  String get capitalize {
    if (isEmpty) return this;

    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String get capitalizeAll {
    return split(' ')
        .map(
          (e) => e.capitalize,
        )
        .join(' ');
  }
}
