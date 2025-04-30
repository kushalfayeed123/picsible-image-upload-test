class Result<T> {
  final T? value;
  final String? error;

  Result._({this.value, this.error});

  factory Result.success(T value) {
    return Result._(value: value);
  }

  factory Result.error(String error) {
    return Result._(error: error);
  }

  bool get isSuccess => error == null;
  bool get isError => error != null;
}
