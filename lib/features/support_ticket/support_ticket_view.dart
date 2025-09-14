import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/support_ticket/cubit/support_ticket_cubit.dart';
import 'package:ngo/features/support_ticket/support_all_view_ticket.dart';
import 'package:ngo/service_locator.dart';

class SupportTicketView extends HookWidget {
  const SupportTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectController = useTextEditingController();
    final messageController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.help_center),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => sl<SupportTicketCubit>(),
        child: BlocConsumer<SupportTicketCubit, SupportTicketState>(
          listener: (context, state) {
            final type = state.runtimeType.toString().toLowerCase();
            if (type.contains('ticketcreated')) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Support ticket created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              subjectController.clear();
              messageController.clear();
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            } else if (type.contains('error')) {
              final message =
                  (state as dynamic).message ?? 'Error creating ticket.';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state.runtimeType.toString().contains('loading');
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.subject,
                      style: MyFonts.font14BlackBold,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: subjectController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enter_subject,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? AppLocalizations.of(context)!.subject_required
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.message,
                      style: MyFonts.font14BlackBold,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: messageController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(
                          context,
                        )!.describe_your_issue,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? AppLocalizations.of(context)!.message_required
                          : null,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SupportAllViewTicket(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.view_all_tickets,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  context
                                      .read<SupportTicketCubit>()
                                      .createTicket(
                                        subject: subjectController.text.trim(),
                                        message: messageController.text.trim(),
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(AppLocalizations.of(context)!.submit),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
