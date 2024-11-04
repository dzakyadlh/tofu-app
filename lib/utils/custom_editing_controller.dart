import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A custom TextEditingController for handling integer input.
class IntegerTextEditingController extends TextEditingController {
  /// Initializes the controller with an optional initial integer value.
  IntegerTextEditingController({int? initialValue}) {
    if (initialValue != null) {
      setValue(initialValue);
    }
    // Add a listener to parse input changes
    addListener(_parseInput);
  }

  int? _integerValue;

  /// Gets the current integer value of the controller.
  int? get integerValue => _integerValue;

  /// Parses the input text to update the integer value.
  void _parseInput() {
    if (text.isEmpty) {
      _integerValue = null;
    } else {
      final rawText = text.trim().replaceAll(',', '');
      final intValue = int.tryParse(rawText);
      if (intValue != null) {
        _integerValue = intValue;
      } else {
        _integerValue = null;
      }
    }
  }

  /// Sets the integer value and updates the text.
  void setValue(int value) {
    _integerValue = value;
    text = value.toString();
  }
}

class DoubleTextEditingController extends TextEditingController {
  /// Initializes the controller with an optional initial double value.
  DoubleTextEditingController({double? initialValue}) {
    if (initialValue != null) {
      setValue(initialValue);
    }
    // Add a listener to parse input changes
    addListener(_parseInput);
  }

  double? _doubleValue;

  /// Gets the current double value of the controller.
  double? get doubleValue => _doubleValue;

  /// Parses the input text to update the double value.
  void _parseInput() {
    if (text.isEmpty) {
      _doubleValue = null;
    } else {
      final rawText = text.trim().replaceAll(',', '');
      final doubleValue = double.tryParse(rawText);
      if (doubleValue != null) {
        _doubleValue = doubleValue;
      } else {
        _doubleValue = null;
      }
    }
  }

  /// Sets the double value and updates the text.
  void setValue(double value) {
    _doubleValue = value;
    text = value.toString();
  }
}

class DateTextEditingController extends TextEditingController {
  /// Initializes the controller with an optional initial date and time.
  DateTextEditingController({DateTime? date}) {
    _dateTime = date;
    _updateText();
  }

  DateTime? _dateTime;

  /// Gets the current date and time of the controller.
  DateTime? get dateTime => _dateTime;

  /// Gets the current date in the format 'dd MMM yyyy'.
  String get date =>
      _dateTime != null ? DateFormat('dd MMM yyyy').format(_dateTime!) : '';

  /// Gets the current time in the format 'hh:mm a'.
  String get time =>
      _dateTime != null ? DateFormat('hh:mm a').format(_dateTime!) : '';

  /// Sets the date part of the controller's date and time.
  void setDate(DateTime date) {
    _dateTime = _dateTime != null
        ? _dateTime!.copyWith(year: date.year, month: date.month, day: date.day)
        : DateTime(date.year, date.month, date.day);
    _updateText();
  }

  /// Sets the time part of the controller's date and time.
  void setTime(TimeOfDay time) {
    _dateTime = _dateTime != null
        ? _dateTime!.copyWith(hour: time.hour, minute: time.minute)
        : DateTime(0, 1, 1, time.hour, time.minute);
    _updateText();
  }

  /// Sets the entire date and time of the controller.
  void setDateTime(DateTime dateTime) {
    _dateTime = dateTime;
    _updateText();
  }

  /// Updates the text of the controller based on the current date and time.
  void _updateText() {
    text =
        _dateTime != null ? DateFormat('dd MMM yyyy').format(_dateTime!) : '';
  }
}
