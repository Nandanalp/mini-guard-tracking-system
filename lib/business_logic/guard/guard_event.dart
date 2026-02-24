import 'package:equatable/equatable.dart';

abstract class GuardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateLocationEvent extends GuardEvent {
  final double latitude;
  final double longitude;

  UpdateLocationEvent(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}

class ToggleAvailabilityEvent extends GuardEvent {
  final bool isOnline;

  ToggleAvailabilityEvent(this.isOnline);

  @override
  List<Object?> get props => [isOnline];
}

class GetBookingsEvent extends GuardEvent {}

class AcceptBookingEvent extends GuardEvent {
  final String bookingId;

  AcceptBookingEvent(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class RejectBookingEvent extends GuardEvent {
  final String bookingId;

  RejectBookingEvent(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class CompleteBookingEvent extends GuardEvent {
  final String bookingId;

  CompleteBookingEvent(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}
