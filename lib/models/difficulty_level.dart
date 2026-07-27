/// Recommended difficulty for a knowledge site or learning path.
enum DifficultyLevel {
  beginner,
  intermediate,
  advanced,
  allLevels;

  String get label => switch (this) {
    DifficultyLevel.beginner => '입문',
    DifficultyLevel.intermediate => '중급',
    DifficultyLevel.advanced => '심화',
    DifficultyLevel.allLevels => '전 수준',
  };
}
