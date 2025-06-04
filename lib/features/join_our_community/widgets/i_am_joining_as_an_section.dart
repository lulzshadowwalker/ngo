import 'package:hugeicons/hugeicons.dart';
import 'package:ngo/export_tools.dart';

import '../../../core/core_export.dart';
import '../../components/text_component.dart';

class IamJoiningAsAnSection extends StatelessWidget {
  const IamJoiningAsAnSection({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String description;
  final IconData icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: MyColors.darkGrayColor.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HugeIcon(icon: icon, color: MyColors.primaryColor, size: 30),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(title: title, style: MyFonts.font16BlackBold),
                  const SizedBox(height: 5),
                  TextComponent(
                    title: description,
                    style: MyFonts.font14Black.copyWith(
                      color: MyColors.darkGrayColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
