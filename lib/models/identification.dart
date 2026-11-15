import 'package:cloud_firestore/cloud_firestore.dart';

class Identification {
  const Identification({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    this.confidence = 0.942,
    this.location = 'Location not added',
    this.note = '',
  });

  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final double confidence;
  final String location;
  final String note;

  Map<String, Object?> toMap() => {
        'title': title,
        'category': category,
        'description': description,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.fromDate(createdAt),
        'confidence': confidence,
        'location': location,
        'note': note,
      };

  factory Identification.fromMap(String id, Map<String, dynamic> map) => Identification(
        id: id,
        title: map['title'] as String? ?? 'Untitled observation',
        category: map['category'] as String? ?? 'Other',
        description: map['description'] as String? ?? '',
        imageUrl: map['imageUrl'] as String? ?? '',
        createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        confidence: (map['confidence'] as num?)?.toDouble() ?? 0,
        location: map['location'] as String? ?? 'Location not added',
        note: map['note'] as String? ?? '',
      );
}
