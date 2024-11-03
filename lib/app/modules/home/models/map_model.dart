class MapModel {
  final String id;
  final DateTime dateTime;
  final double latitude;
  final double longitude;
  final double rating;
  final String title;
  final String description;
  final String imageUrl;

  MapModel({
    required this.id,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory MapModel.fromMap(String id, Map<String, dynamic> data) {
    return MapModel(
      id: id,
      dateTime: data['datetime'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      rating: data['rating'],
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
    );
  }
}
  