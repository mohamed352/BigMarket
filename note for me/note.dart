vildatepassors() {
  (String value) {
    if (value.isEmpty) {
      return 'Field is required.';
    }
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    if (!RegExp(pattern).hasMatch(value)) {
      return """
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      """;
    }
    return null;
  };
}

vildateemail() {
  (String value) {
    if (value.isEmpty) {
      return 'Field is required.';
    }
    String pattern = r'\w+@\w+\.\w+';
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Invalid E-mail Address format.';
    }
    return null;
  };
}
