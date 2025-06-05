import 'package:ngo/models/skill.dart';

abstract interface class SkillsRepository {
  Future<List<Skill>> fetchAll({String language});
  Future<Skill> fetch(String id, {String language});
}
