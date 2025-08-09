enum Role {
  individual,
  organizer;

  static Role? tryFrom(String value) {
    for (Role role in Role.values) {
      if (role.name == value) return role;
    }
    return null;
  }

  static Role from(String value) {
    final role = tryFrom(value);
    if (role == null) {
      throw ArgumentError('Invalid role: $value');
    }
    return role;
  }
}
