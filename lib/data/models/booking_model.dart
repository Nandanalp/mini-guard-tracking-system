class BookingModel {
  final String id;
  final String guardId;
  final String customerId;
  final DateTime bookingDate;
  final String status; // pending, accepted, completed, cancelled
  final double pickupLat;
  final double pickupLng;
  final double dropLat;
  final double dropLng;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;

  BookingModel({
    required this.id,
    required this.guardId,
    required this.customerId,
    required this.bookingDate,
    required this.status,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropLat,
    required this.dropLng,
    required this.createdAt,
    this.acceptedAt,
    this.completedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'guardId': guardId,
      'customerId': customerId,
      'bookingDate': bookingDate,
      'status': status,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'dropLat': dropLat,
      'dropLng': dropLng,
      'createdAt': createdAt,
      'acceptedAt': acceptedAt,
      'completedAt': completedAt,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] ?? '',
      guardId: map['guardId'] ?? '',
      customerId: map['customerId'] ?? '',
      bookingDate: (map['bookingDate'] as dynamic)?.toDate() ?? DateTime.now(),
      status: map['status'] ?? 'pending',
      pickupLat: map['pickupLat']?.toDouble() ?? 0.0,
      pickupLng: map['pickupLng']?.toDouble() ?? 0.0,
      dropLat: map['dropLat']?.toDouble() ?? 0.0,
      dropLng: map['dropLng']?.toDouble() ?? 0.0,
      createdAt: (map['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
      acceptedAt: (map['acceptedAt'] as dynamic)?.toDate(),
      completedAt: (map['completedAt'] as dynamic)?.toDate(),
    );
  }
}
