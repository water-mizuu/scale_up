mixin ForgotPasswordValidatorMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r"^\S+@\S+\.\S+$");
    if (!emailRegex.hasMatch(value)) {
      return "Invalid email format";
    }
    return null;
  }
}
