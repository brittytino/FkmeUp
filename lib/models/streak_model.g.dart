// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStreakModelCollection on Isar {
  IsarCollection<StreakModel> get streakModels => this.collection();
}

const StreakModelSchema = CollectionSchema(
  name: r'StreakModel',
  id: -1150190822398184,
  properties: {
    r'currentStreak': PropertySchema(
      id: 0,
      name: r'currentStreak',
      type: IsarType.long,
    ),
    r'graceDaysUsed': PropertySchema(
      id: 1,
      name: r'graceDaysUsed',
      type: IsarType.long,
    ),
    r'lastCompletionDate': PropertySchema(
      id: 2,
      name: r'lastCompletionDate',
      type: IsarType.dateTime,
    ),
    r'longestStreak': PropertySchema(
      id: 3,
      name: r'longestStreak',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 4,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 5,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _streakModelEstimateSize,
  serialize: _streakModelSerialize,
  deserialize: _streakModelDeserialize,
  deserializeProp: _streakModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374,
      name: r'userId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _streakModelGetId,
  getLinks: _streakModelGetLinks,
  attach: _streakModelAttach,
  version: '3.3.0',
);

int _streakModelEstimateSize(
  StreakModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _streakModelSerialize(
  StreakModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.currentStreak);
  writer.writeLong(offsets[1], object.graceDaysUsed);
  writer.writeDateTime(offsets[2], object.lastCompletionDate);
  writer.writeLong(offsets[3], object.longestStreak);
  writer.writeDateTime(offsets[4], object.updatedAt);
  writer.writeString(offsets[5], object.userId);
}

StreakModel _streakModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StreakModel(
    currentStreak: reader.readLong(offsets[0]),
    graceDaysUsed: reader.readLong(offsets[1]),
    lastCompletionDate: reader.readDateTimeOrNull(offsets[2]),
    longestStreak: reader.readLong(offsets[3]),
    updatedAt: reader.readDateTime(offsets[4]),
    userId: reader.readString(offsets[5]),
  );
  object.id = id;
  return object;
}

P _streakModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _streakModelGetId(StreakModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _streakModelGetLinks(StreakModel object) {
  return [];
}

void _streakModelAttach(
    IsarCollection<dynamic> col, Id id, StreakModel object) {
  object.id = id;
}

extension StreakModelByIndex on IsarCollection<StreakModel> {
  Future<StreakModel?> getByUserId(String userId) {
    return getByIndex(r'userId', [userId]);
  }

  StreakModel? getByUserIdSync(String userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<StreakModel?>> getAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<StreakModel?> getAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(StreakModel object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(StreakModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<StreakModel> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<StreakModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension StreakModelQueryWhereSort
    on QueryBuilder<StreakModel, StreakModel, QWhere> {
  QueryBuilder<StreakModel, StreakModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StreakModelQueryWhere
    on QueryBuilder<StreakModel, StreakModel, QWhereClause> {
  QueryBuilder<StreakModel, StreakModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterWhereClause> userIdEqualTo(
      String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterWhereClause> userIdNotEqualTo(
      String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension StreakModelQueryFilter
    on QueryBuilder<StreakModel, StreakModel, QFilterCondition> {
  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      currentStreakEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      currentStreakGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      currentStreakLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      currentStreakBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStreak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      graceDaysUsedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'graceDaysUsed',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      graceDaysUsedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'graceDaysUsed',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      graceDaysUsedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'graceDaysUsed',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      graceDaysUsedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'graceDaysUsed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      lastCompletionDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastCompletionDate',
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      lastCompletionDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastCompletionDate',
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      lastCompletionDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastCompletionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      lastCompletionDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastCompletionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      lastCompletionDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastCompletionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      lastCompletionDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastCompletionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      longestStreakEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longestStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      longestStreakGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longestStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      longestStreakLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longestStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      longestStreakBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longestStreak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension StreakModelQueryObject
    on QueryBuilder<StreakModel, StreakModel, QFilterCondition> {}

extension StreakModelQueryLinks
    on QueryBuilder<StreakModel, StreakModel, QFilterCondition> {}

extension StreakModelQuerySortBy
    on QueryBuilder<StreakModel, StreakModel, QSortBy> {
  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> sortByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      sortByCurrentStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> sortByGraceDaysUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDaysUsed', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      sortByGraceDaysUsedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDaysUsed', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      sortByLastCompletionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletionDate', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      sortByLastCompletionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletionDate', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> sortByLongestStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreak', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      sortByLongestStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreak', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension StreakModelQuerySortThenBy
    on QueryBuilder<StreakModel, StreakModel, QSortThenBy> {
  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> thenByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      thenByCurrentStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> thenByGraceDaysUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDaysUsed', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      thenByGraceDaysUsedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDaysUsed', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      thenByLastCompletionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletionDate', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      thenByLastCompletionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletionDate', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> thenByLongestStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreak', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy>
      thenByLongestStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreak', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<StreakModel, StreakModel, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension StreakModelQueryWhereDistinct
    on QueryBuilder<StreakModel, StreakModel, QDistinct> {
  QueryBuilder<StreakModel, StreakModel, QDistinct> distinctByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStreak');
    });
  }

  QueryBuilder<StreakModel, StreakModel, QDistinct> distinctByGraceDaysUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'graceDaysUsed');
    });
  }

  QueryBuilder<StreakModel, StreakModel, QDistinct>
      distinctByLastCompletionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCompletionDate');
    });
  }

  QueryBuilder<StreakModel, StreakModel, QDistinct> distinctByLongestStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longestStreak');
    });
  }

  QueryBuilder<StreakModel, StreakModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<StreakModel, StreakModel, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension StreakModelQueryProperty
    on QueryBuilder<StreakModel, StreakModel, QQueryProperty> {
  QueryBuilder<StreakModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StreakModel, int, QQueryOperations> currentStreakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStreak');
    });
  }

  QueryBuilder<StreakModel, int, QQueryOperations> graceDaysUsedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'graceDaysUsed');
    });
  }

  QueryBuilder<StreakModel, DateTime?, QQueryOperations>
      lastCompletionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCompletionDate');
    });
  }

  QueryBuilder<StreakModel, int, QQueryOperations> longestStreakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longestStreak');
    });
  }

  QueryBuilder<StreakModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<StreakModel, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
