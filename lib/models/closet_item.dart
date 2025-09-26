class ClosetItem {
  final String name, category, thickness;
  final String? image;

  ClosetItem.fromJson(Map<String, dynamic> json)
    : category = json['category'],
      thickness = json['thickness'],
      image = json['image'],
      name = json['name'];
}
