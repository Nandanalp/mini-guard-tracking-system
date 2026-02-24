import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/guard_repository.dart';
import 'guard_event.dart';
import 'guard_state.dart';
import 'dart:developer' as developer;

class GuardBloc extends Bloc<GuardEvent, GuardState> {
  final GuardRepository repository;

  GuardBloc(this.repository) : super(GuardInitial()) {
    on<UpdateLocationEvent>((event, emit) async {
      emit(GuardLoading());
      try {
        await repository.updateLocation(event.latitude, event.longitude);
        emit(LocationUpdated(event.latitude, event.longitude));
      } catch (e) {
        developer.log('❌ Location update failed: $e');
        emit(GuardError('Failed to update location'));
      }
    });

    on<ToggleAvailabilityEvent>((event, emit) async {
      emit(GuardLoading());
      try {
        await repository.updateAvailability(event.isOnline);
        emit(AvailabilityToggled(event.isOnline));
      } catch (e) {
        developer.log('❌ Availability toggle failed: $e');
        emit(GuardError('Failed to toggle availability'));
      }
    });

    on<GetBookingsEvent>((event, emit) async {
      emit(GuardLoading());
      try {
        final bookings = await repository.getGuardBookings().first;
        emit(BookingsLoaded(bookings));
      } catch (e) {
        developer.log('❌ Failed to fetch bookings: $e');
        emit(GuardError('Failed to fetch bookings'));
      }
    });

    on<AcceptBookingEvent>((event, emit) async {
      try {
        await repository.acceptBooking(event.bookingId);
        emit(BookingAccepted(event.bookingId));
      } catch (e) {
        developer.log('❌ Failed to accept booking: $e');
        emit(GuardError('Failed to accept booking'));
      }
    });

    on<RejectBookingEvent>((event, emit) async {
      try {
        await repository.rejectBooking(event.bookingId);
        emit(BookingRejected(event.bookingId));
      } catch (e) {
        developer.log('❌ Failed to reject booking: $e');
        emit(GuardError('Failed to reject booking'));
      }
    });

    on<CompleteBookingEvent>((event, emit) async {
      try {
        await repository.completeBooking(event.bookingId);
        emit(BookingCompleted(event.bookingId));
      } catch (e) {
        developer.log('❌ Failed to complete booking: $e');
        emit(GuardError('Failed to complete booking'));
      }
    });
  }
}
