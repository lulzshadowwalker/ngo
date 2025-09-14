import 'package:hugeicons/hugeicons.dart';

import '../../export_tools.dart';
import '../theme/my_colors.dart';

class BackButtonWidgets extends StatelessWidget {
  const BackButtonWidgets({super.key, required this.lang});

  final AppLocalizations lang;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: HugeIcon(
        icon: lang.localeName == "ar"
            ? HugeIcons.strokeRoundedArrowRight01
            : HugeIcons.strokeRoundedArrowLeft01,
        color: MyColors.primaryColor,
        size: 30,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
