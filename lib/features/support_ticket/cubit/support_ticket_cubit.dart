import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/contracts/support_ticket_repository.dart';
import '../../../core/helpers/helper.dart';
import '../../../models/support_ticket.dart';

part 'support_ticket_cubit.freezed.dart';
part 'support_ticket_state.dart';

class SupportTicketCubit extends Cubit<SupportTicketState> {
  final SupportTicketRepository repository;

  SupportTicketCubit({required this.repository})
    : super(SupportTicketState.initial());

  Future<void> getAllTickets() async {
    emit(const SupportTicketState.loading());
    try {
      final accessToken = await SharedPrefHelper.getAccessToken();
      log("This is the access token: $accessToken");
      final tickets = await repository.list(accessToken);
      emit(SupportTicketState.ticketsLoaded(tickets));
    } catch (e) {
      emit(SupportTicketState.error(e.toString()));
    }
  }

  Future<void> getTicketById(String id) async {
    emit(const SupportTicketState.loading());
    try {
      final accessToken = await SharedPrefHelper.getAccessToken();
      final ticket = await repository.find(accessToken, id);
      emit(SupportTicketState.ticketLoaded(ticket));
    } catch (e) {
      emit(SupportTicketState.error(e.toString()));
    }
  }

  Future<void> createTicket({
    required String subject,
    required String message,
  }) async {
    emit(const SupportTicketState.loading());
    try {
      final accessToken = await SharedPrefHelper.getAccessToken();
      final ticket = await repository.create(
        accessToken,
        subject: subject,
        message: message,
      );
      emit(SupportTicketState.ticketCreated(ticket));
    } catch (e) {
      log("Error creating ticket: $e");
      emit(SupportTicketState.error(e.toString()));
    }
  }
}
