import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Utility class for time-slot generation and comparison logic
/// used by the home screen's appointment filter.
class TimeSlotUtils {
  const TimeSlotUtils._();

  /// Returns the current hour's time range, e.g. "2:00 PM - 3:00 PM".
  static String getCurrentTimeRange() {
    final now = DateTime.now();
    final startOfHour = DateTime(now.year, now.month, now.day, now.hour);
    final endOfHour = startOfHour.add(const Duration(hours: 1));

    final startFormatted = DateFormat('h:mm a').format(startOfHour);
    final endFormatted = DateFormat('h:mm a').format(endOfHour);
    return '$startFormatted - $endFormatted';
  }

  /// Generates a list of time-slot labels between [startTime] and [endTime]
  /// spaced by [interval].
  ///
  /// Example: `generateTimeSlots(TimeOfDay(hour: 6, minute: 0), ..., Duration(hours: 1, minutes: 30))`
  /// → `["6:00 AM - 7:30 AM", "7:30 AM - 9:00 AM", ...]`
  static List<String> generateTimeSlots(
    TimeOfDay startTime,
    TimeOfDay endTime,
    Duration interval,
  ) {
    final today = DateTime.now();
    final startDate = DateTime(
      today.year, today.month, today.day,
      startTime.hour, startTime.minute,
    );
    final endDate = DateTime(
      today.year, today.month, today.day,
      endTime.hour, endTime.minute,
    );

    final List<String> slots = [];
    var current = startDate;

    while (current.isBefore(endDate)) {
      final next = current.add(interval);
      slots.add(
        '${DateFormat.jm().format(current)} - ${DateFormat.jm().format(next)}',
      );
      current = next;
    }

    return slots;
  }

  /// Returns `true` if [innerRange] falls entirely within [outerRange].
  ///
  /// Both ranges are formatted as `"h:mm a - h:mm a"`.
  static bool isTimeRangeWithin(String outerRange, String innerRange) {
    final outer = _parseTimeRange(outerRange);
    final inner = _parseTimeRange(innerRange);
    return inner[0] >= outer[0] && inner[1] <= outer[1];
  }

  /// Formats [date] for display — omits year if it's the current year.
  static String formatDate(DateTime date) {
    if (date.year == DateTime.now().year) {
      return DateFormat('MMM dd').format(date);
    }
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Formats [date] as `yyyy-MM-dd` for API calls.
  static String formatDateForApi(DateTime date) {
    return '${date.year}'
        '-${date.month.toString().padLeft(2, '0')}'
        '-${date.day.toString().padLeft(2, '0')}';
  }

  // ── Private helpers ──────────────────────────────────────────────

  static List<int> _parseTimeRange(String range) {
    final parts = range.split(' - ');
    return parts.map((t) => _convertTimeToMinutes(t.trim())).toList();
  }

  static int _convertTimeToMinutes(String time) {
    final normalized = time.trim().toLowerCase();
    final components = normalized.split(RegExp(r'[:\s]'));

    if (components.length != 3) {
      throw FormatException('Invalid time format: $time');
    }

    var hours = int.tryParse(components[0]) ?? 0;
    final minutes = int.tryParse(components[1]) ?? 0;
    final period = components[2];

    if (period == 'pm' && hours != 12) {
      hours += 12;
    } else if (period == 'am' && hours == 12) {
      hours = 0;
    }

    // Treat 12:00 AM as end-of-day (1440 minutes).
    if (hours == 0 && minutes == 0 && period == 'am') {
      return 24 * 60;
    }

    return hours * 60 + minutes;
  }
}
