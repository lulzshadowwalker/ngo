import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/support_ticket/cubit/support_ticket_cubit.dart';
import 'package:ngo/models/support_ticket.dart';
import 'package:ngo/service_locator.dart';

import 'show_detalis_support_all_view_ticket.dart';

class SupportAllViewTicket extends HookWidget {
  const SupportAllViewTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SupportTicketCubit>()..getAllTickets(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Support Tickets'),
          centerTitle: true,
        ),
        body: BlocBuilder<SupportTicketCubit, SupportTicketState>(
          builder: (context, state) {
            final type = state.runtimeType.toString().toLowerCase();
            if (type.contains('loading')) {
              return const Center(child: CircularProgressIndicator());
            } else if (type.contains('error')) {
              final message = (state as dynamic).message ?? 'Error loading tickets.';
              return Center(
                child: Text(
                  message,
                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (type.contains('ticketsloaded')) {
              final tickets = (state as dynamic).tickets as List<SupportTicket>;
              if (tickets.isEmpty) {
                return Center(child: Text('No support tickets found.', style: MyFonts.font14Black));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: tickets.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  return ListTile(
                    title: Text(ticket.subject, style: MyFonts.font14BlackBold),
                    subtitle: Text(ticket.message, maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: Text(
                      ticket.status.value,
                      style: MyFonts.font12Black.copyWith(color: ticket.status.color),
                    ),
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowDetalisSupportAllViewTicket(
                      id: ticket.id,
                    )));
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
