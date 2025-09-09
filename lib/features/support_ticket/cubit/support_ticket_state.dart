part of 'support_ticket_cubit.dart';

@freezed
class SupportTicketState with _$SupportTicketState {
  const factory SupportTicketState.initial() = _Initial;
  const factory SupportTicketState.loading() = _Loading;
  const factory SupportTicketState.error(String message) = _Error;
  const factory SupportTicketState.ticketsLoaded(List<SupportTicket> tickets) =
      _TicketsLoaded;
  const factory SupportTicketState.ticketLoaded(SupportTicket ticket) =
      _TicketLoaded;
  const factory SupportTicketState.ticketCreated(SupportTicket ticket) =
      _TicketCreated;
}
