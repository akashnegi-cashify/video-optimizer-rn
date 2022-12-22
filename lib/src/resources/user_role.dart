enum UserRole {
  ROLE_STORAGE_MANAGER("STORAGE_MANAGER"),
  ROLE_INVENTORY_MANAGER("INVENTORY_MANAGER"),
  ROLE_RIDER("RIDER"),
  ROLE_QC("PART_QC");

  final String value;

  const UserRole(this.value);

  static UserRole? getUserRole(String data) {
    for (UserRole element in UserRole.values) {
      if (element.value == data) {
        return element;
      }
    }
    return null;
  }
}
