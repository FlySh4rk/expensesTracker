// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

class $CategoriesTable extends Categories with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = VerificationMeta('id');
  static const VerificationMeta _nameMeta = VerificationMeta('name');
  static const VerificationMeta _iconKeyMeta = VerificationMeta('iconKey');
  static const VerificationMeta _isEnabledMeta = VerificationMeta('isEnabled');
  static const VerificationMeta _sortOrderMeta = VerificationMeta('sortOrder');

  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );

  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );

  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );

  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultValue: const Constant(true),
  );

  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );

  @override
  List<GeneratedColumn> get $columns => [id, name, iconKey, isEnabled, sortOrder];

  @override
  String get aliasedName => _alias ?? 'categories';

  @override
  String get actualTableName => 'categories';

  @override
  VerificationContext validateIntegrity(Insertable<Category> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(_iconKeyMeta, iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta));
    } else if (isInserting) {
      context.missing(_iconKeyMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta, isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta, sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iconKey: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}icon_key'])!,
      isEnabled: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
      sortOrder: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) => $CategoriesTable(attachedDatabase, alias);
}

class Category extends DataClass implements Insertable<Category> {
  const Category({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.isEnabled,
    required this.sortOrder,
  });

  final String id;
  final String name;
  final String iconKey;
  final bool isEnabled;
  final int sortOrder;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon_key'] = Variable<String>(iconKey);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      iconKey: Value(iconKey),
      isEnabled: Value(isEnabled),
      sortOrder: Value(sortOrder),
    );
  }
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> iconKey;
  final Value<bool> isEnabled;
  final Value<int> sortOrder;

  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });

  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String iconKey,
    this.isEnabled = const Value.absent(),
    required int sortOrder,
  })  : id = Value(id),
        name = Value(name),
        iconKey = Value(iconKey),
        sortOrder = Value(sortOrder);

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<String>(id.value);
    if (name.present) map['name'] = Variable<String>(name.value);
    if (iconKey.present) map['icon_key'] = Variable<String>(iconKey.value);
    if (isEnabled.present) map['is_enabled'] = Variable<bool>(isEnabled.value);
    if (sortOrder.present) map['sort_order'] = Variable<int>(sortOrder.value);
    return map;
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = VerificationMeta('id');
  static const VerificationMeta _amountCentsMeta = VerificationMeta('amountCents');
  static const VerificationMeta _currencyMeta = VerificationMeta('currency');
  static const VerificationMeta _occurredAtMeta = VerificationMeta('occurredAt');
  static const VerificationMeta _categoryIdMeta = VerificationMeta('categoryId');
  static const VerificationMeta _merchantMeta = VerificationMeta('merchant');
  static const VerificationMeta _noteMeta = VerificationMeta('note');
  static const VerificationMeta _sourceMeta = VerificationMeta('source');
  static const VerificationMeta _createdAtMeta = VerificationMeta('createdAt');
  static const VerificationMeta _updatedAtMeta = VerificationMeta('updatedAt');
  static const VerificationMeta _deletedAtMeta = VerificationMeta('deletedAt');

  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<int> occurredAt = GeneratedColumn<int>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
    'merchant',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );

  @override
  List<GeneratedColumn> get $columns => [
        id,
        amountCents,
        currency,
        occurredAt,
        categoryId,
        merchant,
        note,
        source,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  @override
  String get aliasedName => _alias ?? 'expenses';

  @override
  String get actualTableName => 'expenses';

  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(_amountCentsMeta, amountCents.isAcceptableOrUnknown(data['amount_cents']!, _amountCentsMeta));
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta, currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(_occurredAtMeta, occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta));
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(_categoryIdMeta, categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('merchant')) {
      context.handle(_merchantMeta, merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta, source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta, deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      amountCents: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount_cents'])!,
      currency: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      occurredAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}occurred_at'])!,
      categoryId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      merchant: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}merchant']),
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      source: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) => $ExpensesTable(attachedDatabase, alias);
}

class Expense extends DataClass implements Insertable<Expense> {
  const Expense({
    required this.id,
    required this.amountCents,
    required this.currency,
    required this.occurredAt,
    required this.categoryId,
    this.merchant,
    this.note,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final int amountCents;
  final String currency;
  final int occurredAt;
  final String categoryId;
  final String? merchant;
  final String? note;
  final String source;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount_cents'] = Variable<int>(amountCents);
    map['currency'] = Variable<String>(currency);
    map['occurred_at'] = Variable<int>(occurredAt);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || merchant != null) {
      map['merchant'] = Variable<String>(merchant!);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note!);
    }
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt!);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      amountCents: Value(amountCents),
      currency: Value(currency),
      occurredAt: Value(occurredAt),
      categoryId: Value(categoryId),
      merchant: Value(merchant),
      note: Value(note),
      source: Value(source),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: Value(deletedAt),
    );
  }
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<int> amountCents;
  final Value<String> currency;
  final Value<int> occurredAt;
  final Value<String> categoryId;
  final Value<String?> merchant;
  final Value<String?> note;
  final Value<String> source;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;

  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.currency = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.merchant = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });

  ExpensesCompanion.insert({
    required String id,
    required int amountCents,
    required String currency,
    required int occurredAt,
    required String categoryId,
    this.merchant = const Value.absent(),
    this.note = const Value.absent(),
    required String source,
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
  })  : id = Value(id),
        amountCents = Value(amountCents),
        currency = Value(currency),
        occurredAt = Value(occurredAt),
        categoryId = Value(categoryId),
        source = Value(source),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<String>(id.value);
    if (amountCents.present) map['amount_cents'] = Variable<int>(amountCents.value);
    if (currency.present) map['currency'] = Variable<String>(currency.value);
    if (occurredAt.present) map['occurred_at'] = Variable<int>(occurredAt.value);
    if (categoryId.present) map['category_id'] = Variable<String>(categoryId.value);
    if (merchant.present) map['merchant'] = Variable<String?>(merchant.value);
    if (note.present) map['note'] = Variable<String?>(note.value);
    if (source.present) map['source'] = Variable<String>(source.value);
    if (createdAt.present) map['created_at'] = Variable<int>(createdAt.value);
    if (updatedAt.present) map['updated_at'] = Variable<int>(updatedAt.value);
    if (deletedAt.present) map['deleted_at'] = Variable<int?>(deletedAt.value);
    return map;
  }
}

class $ExpenseEventsTable extends ExpenseEvents with TableInfo<$ExpenseEventsTable, ExpenseEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseEventsTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = VerificationMeta('id');
  static const VerificationMeta _entityIdMeta = VerificationMeta('entityId');
  static const VerificationMeta _eventTypeMeta = VerificationMeta('eventType');
  static const VerificationMeta _payloadJsonMeta = VerificationMeta('payloadJson');
  static const VerificationMeta _createdAtMeta = VerificationMeta('createdAt');
  static const VerificationMeta _syncedAtMeta = VerificationMeta('syncedAt');

  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumn<int> syncedAt = GeneratedColumn<int>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );

  @override
  List<GeneratedColumn> get $columns => [id, entityId, eventType, payloadJson, createdAt, syncedAt];

  @override
  String get aliasedName => _alias ?? 'expense_events';

  @override
  String get actualTableName => 'expense_events';

  @override
  VerificationContext validateIntegrity(Insertable<ExpenseEvent> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta, entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta, eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta));
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(_payloadJsonMeta, payloadJson.isAcceptableOrUnknown(data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  ExpenseEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseEvent(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      entityId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      eventType: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}event_type'])!,
      payloadJson: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}synced_at']),
    );
  }

  @override
  $ExpenseEventsTable createAlias(String alias) => $ExpenseEventsTable(attachedDatabase, alias);
}

class ExpenseEvent extends DataClass implements Insertable<ExpenseEvent> {
  const ExpenseEvent({
    required this.id,
    required this.entityId,
    required this.eventType,
    required this.payloadJson,
    required this.createdAt,
    this.syncedAt,
  });

  final String id;
  final String entityId;
  final String eventType;
  final String payloadJson;
  final int createdAt;
  final int? syncedAt;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_id'] = Variable<String>(entityId);
    map['event_type'] = Variable<String>(eventType);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<int>(syncedAt!);
    }
    return map;
  }

  ExpenseEventsCompanion toCompanion(bool nullToAbsent) {
    return ExpenseEventsCompanion(
      id: Value(id),
      entityId: Value(entityId),
      eventType: Value(eventType),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
      syncedAt: Value(syncedAt),
    );
  }
}

class ExpenseEventsCompanion extends UpdateCompanion<ExpenseEvent> {
  final Value<String> id;
  final Value<String> entityId;
  final Value<String> eventType;
  final Value<String> payloadJson;
  final Value<int> createdAt;
  final Value<int?> syncedAt;

  const ExpenseEventsCompanion({
    this.id = const Value.absent(),
    this.entityId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });

  ExpenseEventsCompanion.insert({
    required String id,
    required String entityId,
    required String eventType,
    required String payloadJson,
    required int createdAt,
    this.syncedAt = const Value.absent(),
  })  : id = Value(id),
        entityId = Value(entityId),
        eventType = Value(eventType),
        payloadJson = Value(payloadJson),
        createdAt = Value(createdAt);

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<String>(id.value);
    if (entityId.present) map['entity_id'] = Variable<String>(entityId.value);
    if (eventType.present) map['event_type'] = Variable<String>(eventType.value);
    if (payloadJson.present) map['payload_json'] = Variable<String>(payloadJson.value);
    if (createdAt.present) map['created_at'] = Variable<int>(createdAt.value);
    if (syncedAt.present) map['synced_at'] = Variable<int?>(syncedAt.value);
    return map;
  }
}

class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);

  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $ExpenseEventsTable expenseEvents = $ExpenseEventsTable(this);

  @override
  Iterable<TableInfo<Table, dynamic>> get allTables => [categories, expenses, expenseEvents];

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [categories, expenses, expenseEvents];
}
