import 'package:cloud_firestore/cloud_firestore.dart';

class MapModel {
  final String id;
  final DateTime dateTime;
  final double latitude;
  final double longitude;
  final double rating;
  final String title;
  final String description;
  final String imageUrl;
  final String userId;

  MapModel({
    required this.id,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.userId,
  });

  factory MapModel.fromMap(String id, Map<String, dynamic> data) {
    return MapModel(
      id: id,
      dateTime: (data['datetime'] as Timestamp?)?.toDate() ?? DateTime.now(), // Convert Firestore Timestamp to DateTime
      latitude: (data['latitude'] as num?)?.toDouble() ?? -7.0, // Default to -7.0 if null
      longitude: (data['longitude'] as num?)?.toDouble() ?? 110.0, // Default to 110.0 if null
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
      title: data['title'] as String? ?? 'Untitled', // Default title if missing
      description: data['description'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }
}
