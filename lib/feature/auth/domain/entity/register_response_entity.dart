class RegisterResponseEntity {
  final bool success;
  final String? message;

  const RegisterResponseEntity({required this.success, this.message});

  bool get isSuccess => success;
  bool get isError => !success;
}
