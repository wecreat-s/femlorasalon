class BookingModel {
  final String userName;
  final String userEmail;
  final String serviceName;
  final String date;
  final String time;
  final String price;

  BookingModel({
    required this.userName,
    required this.userEmail,
    required this.serviceName,
    required this.date,
    required this.time,
    required this.price,
  });
}

// ⭐ Global list storing all bookings
List<BookingModel> allBookings = [];

