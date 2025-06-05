import 'package:ngo/core/contracts/skills_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/skill.dart';

final class LaravelSkillsRepository extends LaravelRepository
    implements SkillsRepository {

  @override
  Future<List<Skill>> fetchAll({String language = 'en'}) async {
    final response = await get('/$language/skills');

    final data = response['data'] as List<dynamic>;
    return data
        .map((item) => Skill.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }
}
