import 'package:uuid/uuid.dart';

class UuidGenerator {
  const UuidGenerator([Uuid? uuid]) : _uuid = uuid ?? const Uuid();

  final Uuid _uuid;

  String newId() => _uuid.v4();
}
