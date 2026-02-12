// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSettingsModelCollection on Isar {
  IsarCollection<SettingsModel> get settingsModels => this.collection();
}

const SettingsModelSchema = CollectionSchema(
  name: r'SettingsModel',
  id: 4013777327486952,
  properties: {
    r'graceDayEnabled': PropertySchema(
      id: 0,
      name: r'graceDayEnabled',
      type: IsarType.bool,
    ),
    r'graceDaysPer30': PropertySchema(
      id: 1,
      name: r'graceDaysPer30',
      type: IsarType.long,
    ),
    r'supabaseAnonKey': PropertySchema(
      id: 2,
      name: r'supabaseAnonKey',
      type: IsarType.string,
    ),
    r'supabaseUrl': PropertySchema(
      id: 3,
      name: r'supabaseUrl',
      type: IsarType.string,
    ),
    r'syncEnabled': PropertySchema(
      id: 4,
      name: r'syncEnabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _settingsModelEstimateSize,
  serialize: _settingsModelSerialize,
  deserialize: _settingsModelDeserialize,
  deserializeProp: _settingsModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _settingsModelGetId,
  getLinks: _settingsModelGetLinks,
  attach: _settingsModelAttach,
  version: '3.3.0',
);

int _settingsModelEstimateSize(
  SettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.supabaseAnonKey.length * 3;
  bytesCount += 3 + object.supabaseUrl.length * 3;
  return bytesCount;
}

void _settingsModelSerialize(
  SettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.graceDayEnabled);
  writer.writeLong(offsets[1], object.graceDaysPer30);
  writer.writeString(offsets[2], object.supabaseAnonKey);
  writer.writeString(offsets[3], object.supabaseUrl);
  writer.writeBool(offsets[4], object.syncEnabled);
}

SettingsModel _settingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SettingsModel(
    graceDayEnabled: reader.readBool(offsets[0]),
    graceDaysPer30: reader.readLong(offsets[1]),
    supabaseAnonKey: reader.readString(offsets[2]),
    supabaseUrl: reader.readString(offsets[3]),
    syncEnabled: reader.readBool(offsets[4]),
  );
  object.id = id;
  return object;
}

P _settingsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _settingsModelGetId(SettingsModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _settingsModelGetLinks(SettingsModel object) {
  return [];
}

void _settingsModelAttach(
    IsarCollection<dynamic> col, Id id, SettingsModel object) {
  object.id = id;
}

extension SettingsModelQueryWhereSort
    on QueryBuilder<SettingsModel, SettingsModel, QWhere> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SettingsModelQueryWhere
    on QueryBuilder<SettingsModel, SettingsModel, QWhereClause> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterWhereClause> idBetween(
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
}

extension SettingsModelQueryFilter
    on QueryBuilder<SettingsModel, SettingsModel, QFilterCondition> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      graceDayEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'graceDayEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      graceDaysPer30EqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'graceDaysPer30',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      graceDaysPer30GreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'graceDaysPer30',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      graceDaysPer30LessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'graceDaysPer30',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      graceDaysPer30Between(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'graceDaysPer30',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseAnonKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supabaseAnonKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supabaseAnonKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supabaseAnonKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supabaseAnonKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supabaseAnonKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supabaseAnonKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supabaseAnonKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseAnonKey',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseAnonKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supabaseAnonKey',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supabaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supabaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supabaseUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supabaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supabaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supabaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supabaseUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      supabaseUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supabaseUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterFilterCondition>
      syncEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncEnabled',
        value: value,
      ));
    });
  }
}

extension SettingsModelQueryObject
    on QueryBuilder<SettingsModel, SettingsModel, QFilterCondition> {}

extension SettingsModelQueryLinks
    on QueryBuilder<SettingsModel, SettingsModel, QFilterCondition> {}

extension SettingsModelQuerySortBy
    on QueryBuilder<SettingsModel, SettingsModel, QSortBy> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortByGraceDayEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDayEnabled', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortByGraceDayEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDayEnabled', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortByGraceDaysPer30() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDaysPer30', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortByGraceDaysPer30Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDaysPer30', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortBySupabaseAnonKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseAnonKey', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortBySupabaseAnonKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseAnonKey', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy> sortBySupabaseUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUrl', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortBySupabaseUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUrl', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy> sortBySyncEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncEnabled', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      sortBySyncEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncEnabled', Sort.desc);
    });
  }
}

extension SettingsModelQuerySortThenBy
    on QueryBuilder<SettingsModel, SettingsModel, QSortThenBy> {
  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenByGraceDayEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDayEnabled', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenByGraceDayEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDayEnabled', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenByGraceDaysPer30() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDaysPer30', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenByGraceDaysPer30Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceDaysPer30', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenBySupabaseAnonKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseAnonKey', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenBySupabaseAnonKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseAnonKey', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy> thenBySupabaseUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUrl', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenBySupabaseUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUrl', Sort.desc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy> thenBySyncEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncEnabled', Sort.asc);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QAfterSortBy>
      thenBySyncEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncEnabled', Sort.desc);
    });
  }
}

extension SettingsModelQueryWhereDistinct
    on QueryBuilder<SettingsModel, SettingsModel, QDistinct> {
  QueryBuilder<SettingsModel, SettingsModel, QDistinct>
      distinctByGraceDayEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'graceDayEnabled');
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QDistinct>
      distinctByGraceDaysPer30() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'graceDaysPer30');
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QDistinct>
      distinctBySupabaseAnonKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseAnonKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QDistinct> distinctBySupabaseUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SettingsModel, SettingsModel, QDistinct>
      distinctBySyncEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncEnabled');
    });
  }
}

extension SettingsModelQueryProperty
    on QueryBuilder<SettingsModel, SettingsModel, QQueryProperty> {
  QueryBuilder<SettingsModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SettingsModel, bool, QQueryOperations>
      graceDayEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'graceDayEnabled');
    });
  }

  QueryBuilder<SettingsModel, int, QQueryOperations> graceDaysPer30Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'graceDaysPer30');
    });
  }

  QueryBuilder<SettingsModel, String, QQueryOperations>
      supabaseAnonKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseAnonKey');
    });
  }

  QueryBuilder<SettingsModel, String, QQueryOperations> supabaseUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseUrl');
    });
  }

  QueryBuilder<SettingsModel, bool, QQueryOperations> syncEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncEnabled');
    });
  }
}
