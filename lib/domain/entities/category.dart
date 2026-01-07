class Category {
  const Category({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.isEnabled,
    required this.sortOrder,
  });

  final String id;
  final String name;
  final String iconKey;
  final bool isEnabled;
  final int sortOrder;

  Category copyWith({
    String? name,
    String? iconKey,
    bool? isEnabled,
    int? sortOrder,
  }) {
    return Category(
      id: id,
      name: name ?? this.name,
      iconKey: iconKey ?? this.iconKey,
      isEnabled: isEnabled ?? this.isEnabled,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
