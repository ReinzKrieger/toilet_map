class MapModel {
  final String id;
  final double latitude;
  final double longitude;
  final String title;
  final String description;

  MapModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.description,
  });

  factory MapModel.fromMap(String id, Map<String, dynamic> data) {
    return MapModel(
      id: id,
      latitude: data['latitude'],
      longitude: data['longitude'],
      title: data['title'],
      description: data['description'],
    );
  }
}
