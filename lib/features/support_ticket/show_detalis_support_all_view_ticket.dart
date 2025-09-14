import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/support_ticket/cubit/support_ticket_cubit.dart';
import 'package:ngo/service_locator.dart';

class ShowDetalisSupportAllViewTicket extends HookWidget {
  const ShowDetalisSupportAllViewTicket({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SupportTicketCubit>()..getTicketById(id),
      child: Scaffold(
        appBar: AppBar(title: const Text('Ticket Details'), centerTitle: true),
        body: BlocBuilder<SupportTicketCubit, SupportTicketState>(
          builder: (context, state) {
            final type = state.runtimeType.toString().toLowerCase();
            if (type.contains('loading')) {
              return const Center(child: CircularProgressIndicator());
            } else if (type.contains('error')) {
              final message =
                  (state as dynamic).message ?? 'Error loading ticket.';
              return Center(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (type.contains('ticketloaded')) {
              final ticket = (state as dynamic).ticket;
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('#${ticket.number}', style: MyFonts.font16BlackBold),
                    const SizedBox(height: 12),
                    Text('Subject:', style: MyFonts.font14BlackBold),
                    Text(ticket.subject, style: MyFonts.font14Black),
                    const SizedBox(height: 12),
                    Text('Message:', style: MyFonts.font14BlackBold),
                    Text(ticket.message, style: MyFonts.font14Black),
                    const SizedBox(height: 12),
                    // Text('Status:', style: MyFonts.font14BlackBold),
                    // Text(ticket.status.value, style: MyFonts.font14Black.copyWith(color: ticket.status.color)),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
