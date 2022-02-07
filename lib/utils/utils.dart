bool isNull(Object? data) {
  if (data == null) return true;

  if (data is Map) return data.isEmpty;

  if (data is String) return data.isEmpty;

  if (data is List) return data.isEmpty;

  if (data is Set) return data.isEmpty;

  return false;
}

bool isNotNull(var data) {
  return !isNull(data);
}

String transformView(int data) {
  if (data > 9999) return "${data ~/ 10000}万";
  return '$data';
}
