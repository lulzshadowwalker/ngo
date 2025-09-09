

import '../../models/support_ticket.dart';

abstract interface class SupportTicketRepository {
  Future<List<SupportTicket>> list(String accessToken);
  Future<SupportTicket> find(String accessToken, String id);
  Future<SupportTicket> create(
    String accessToken, {
    required String subject,
    required String message,
  });
}
