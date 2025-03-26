int? intParse(String? value) {
  if (value == null) return null;
  try {
    return int.parse(value);
  } catch (_) {
    return null;
  }
}
