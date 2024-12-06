import 'package:intl/intl.dart';

class FormattedDateAndTimeServices {
  // Method to format date, including month, day, year, and time
  String formatDateTime(String dateTimeString) {
    DateTime time = DateTime.parse(
        dateTimeString); // Parse the passed time string into DateTime

    // Format the date: Month Day, Year (e.g., January 1, 2024)
    String formattedDate = DateFormat('MMMM d, yyyy').format(time);

    // Format the time: Hour:Minute AM/PM (e.g., 12:30 PM)
    String formattedTime = DateFormat('hh:mm a').format(time);

    // Return combined formatted date and time
    return '$formattedDate at $formattedTime'; // Example: January 1, 2024 at 12:30 PM
  }

  String formatDate(String dateTimeString) {
    DateTime time = DateTime.parse(
        dateTimeString); // Parse the passed time string into DateTime

    // Format the date: Month Day, Year (e.g., January 1, 2024)
    String formattedDate = DateFormat('MMMM d').format(time);

    return formattedDate;
  }
}
