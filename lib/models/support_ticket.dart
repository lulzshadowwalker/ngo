import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_ticket.freezed.dart';

@freezed
abstract class SupportTicket with _$SupportTicket {
  const factory SupportTicket({
    required String id,
    required String number,
    required String subject,
    required String message,
    required SupportTicketStatus status,
  }) = _SupportTicket;

  factory SupportTicket.fromLaravel(Map<String, dynamic> json) {
    return SupportTicket(
      id: json['id'] as String,
      number: json['attributes']['number'],
      subject: json['attributes']['subject'],
      message: json['attributes']['message'],
      status: SupportTicketStatus.tryFrom(json['attributes']['status'])!,
    );
  }
}

enum SupportTicketStatus {
  open,
  inProgress,
  resolved;

  String get value {
    switch (this) {
      case SupportTicketStatus.open:
        return 'open';
      case SupportTicketStatus.inProgress:
        return 'in-progress';
      case SupportTicketStatus.resolved:
        return 'resolved';
    }
  }

  /// Converts a string to a [SupportTicketStatus] enum value.
  static SupportTicketStatus? tryFrom(String value) {
    for (SupportTicketStatus status in SupportTicketStatus.values) {
      if (status.value == value) return status;
    }

    return null;
  }

  static SupportTicketStatus from(String value) {
    final status = tryFrom(value);
    if (status == null) {
      throw ArgumentError('Invalid support ticket status: $value');
    }
    return status;
  }
}

extension SupportTicketStatusExtension on SupportTicketStatus {
  Color get color {
    switch (this) {
      case SupportTicketStatus.open:
        return Colors.orange;
      case SupportTicketStatus.inProgress:
        return Colors.blue;
      case SupportTicketStatus.resolved:
        return Colors.green;
    }
  }
}
