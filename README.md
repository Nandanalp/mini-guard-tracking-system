# Mini Guard Booking & Live Tracking System

A real-time Guard Booking and Live Tracking system built using Flutter, Firebase, and BLoC Architecture.

---

## 📌 Overview

This system consists of two separate applications:

- 🛡 Guard App  
- 👤 Customer App  

Both apps use the same Firebase backend.

Guards can go online and share live location.  
Customers can book nearby guards and track them in real time using Google Maps.

---

## 🔐 Authentication

- Firebase Phone OTP Login
- After login:
  - Guard → Guard Home
  - Customer → Customer Home

---

## 🛡 Guard App Features

- Profile setup (Name)
- Online / Offline availability toggle
- Background location updates (every 5–10 seconds)
- Location stored in Firestore
- Receive push notifications for bookings
- Accept / Reject booking
- Live tracking after accepting ride
- Stop tracking after ride completion

---

## 👤 Customer App Features

- Fetch nearby guards
- Sort guards by nearest distance
- Book guard with selected date & time
- Ride document created in Firestore
- Push notification when guard accepts
- Live tracking using Google Maps
- Stop tracking when ride is completed

---

## 🏗 Architecture

- BLoC Architecture
- Clean separation of UI & Business Logic
- Proper state handling (Loading, Success, Error)
- Firestore for real-time updates
- Firebase Cloud Messaging (FCM)
- Google Maps Integration

---

## 🛠 Tech Stack

- Flutter
- Firebase Authentication (Phone OTP)
- Cloud Firestore
- Firebase Cloud Messaging
- Google Maps API
- Geolocator
- BLoC

---

## 📂 Project Structure