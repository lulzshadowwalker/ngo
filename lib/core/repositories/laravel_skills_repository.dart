import 'package:ngo/core/contracts/skills_repository.dart';
import 'package:ngo/core/repositories/laravel_repository.dart';
import 'package:ngo/models/skill.dart';

final class LaravelSkillsRepository extends LaravelRepository
    implements SkillsRepository {

  @override
  Future<List<Skill>> fetchAll({String language = 'en'}) async {
    print('LaravelSkillsRepository: Fetching skills with language: $language');
    
    final response = await get('/v1/skills' , headers: {
      'Accept-Language': language,
    });

    print('LaravelSkillsRepository: Response received: $response');
    
    final data = response['data'] as List<dynamic>;
    print('LaravelSkillsRepository: Found ${data.length} skills');
    
    return data
        .map((item) => Skill.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Skill> fetch(String id, {String language = 'en'}) async {
    final response = await get('/v1/skills/$id' , headers: {
      'Accept-Language': language,
    });
    final data = response['data'] as Map<String, dynamic>;
    return Skill.fromLaravel(data);
  }
}
