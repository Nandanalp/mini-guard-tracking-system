class GuardModel {
  final String id;
  final String phoneNumber;
  final String name;
  final bool isOnline;
  final double latitude;
  final double longitude;
  final DateTime lastUpdated;
  final int rating;

  GuardModel({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.isOnline,
    required this.latitude,
    required this.longitude,
    required this.lastUpdated,
    required this.rating,
  });

  // Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'isOnline': isOnline,
      'latitude': latitude,
      'longitude': longitude,
      'lastUpdated': lastUpdated,
      'rating': rating,
    };
  }

  // Create from Firestore document
  factory GuardModel.fromMap(Map<String, dynamic> map) {
    return GuardModel(
      id: map['id'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      name: map['name'] ?? '',
      isOnline: map['isOnline'] ?? false,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      lastUpdated: (map['lastUpdated'] as dynamic)?.toDate() ?? DateTime.now(),
      rating: map['rating'] ?? 0,
    );
  }

  // Copy with modifications
  GuardModel copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    bool? isOnline,
    double? latitude,
    double? longitude,
    DateTime? lastUpdated,
    int? rating,
  }) {
    return GuardModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      isOnline: isOnline ?? this.isOnline,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rating: rating ?? this.rating,
    );
  }
}
