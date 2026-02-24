import 'package:equatable/equatable.dart';
import '../../data/models/booking_model.dart';

abstract class GuardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GuardInitial extends GuardState {}

class GuardLoading extends GuardState {}

class LocationUpdated extends GuardState {
  final double latitude;
  final double longitude;

  LocationUpdated(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}

class AvailabilityToggled extends GuardState {
  final bool isOnline;

  AvailabilityToggled(this.isOnline);

  @override
  List<Object?> get props => [isOnline];
}

class BookingsLoaded extends GuardState {
  final List<BookingModel> bookings;

  BookingsLoaded(this.bookings);

  @override
  List<Object?> get props => [bookings];
}

class BookingAccepted extends GuardState {
  final String bookingId;

  BookingAccepted(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class BookingRejected extends GuardState {
  final String bookingId;

  BookingRejected(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class BookingCompleted extends GuardState {
  final String bookingId;

  BookingCompleted(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class GuardError extends GuardState {
  final String message;

  GuardError(this.message);

  @override
  List<Object?> get props => [message];
}
