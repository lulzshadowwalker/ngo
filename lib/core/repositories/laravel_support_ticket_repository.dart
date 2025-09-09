import 'package:ngo/core/repositories/laravel_repository.dart';

import '../../models/support_ticket.dart';
import '../contracts/support_ticket_repository.dart';

final class LaravelSupportTicketRepository extends LaravelRepository
    implements SupportTicketRepository {
  @override
  Future<List<SupportTicket>> list(String accessToken) async {
    final response = await get(
      '/v1/support-tickets',
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final data = response['data'] as List;
    return data
        .map((item) => SupportTicket.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<SupportTicket> find(String accessToken, String id) async {
    final response = await get(
      '/v1/support-tickets/$id',
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final data = response['data'] as Map<String, dynamic>;
    return SupportTicket.fromLaravel(data);
  }

  @override
  Future<SupportTicket> create(
    String accessToken, {
    required String subject,
    required String message,
  }) async {
    final response = await post(
      '/v1/support-tickets',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      data: {
        'data': {
          'attributes': {'subject': subject, 'message': message},
        },
      },
    );

    final data = response['data'] as Map<String, dynamic>;
    return SupportTicket.fromLaravel(data);
  }
}
