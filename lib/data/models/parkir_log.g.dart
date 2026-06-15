// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parkir_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetParkirLogCollection on Isar {
  IsarCollection<ParkirLog> get parkirLogs => this.collection();
}

const ParkirLogSchema = CollectionSchema(
  name: r'ParkirLog',
  id: 8702052590294407845,
  properties: {
    r'jenisAksi': PropertySchema(
      id: 0,
      name: r'jenisAksi',
      type: IsarType.string,
    ),
    r'sisaSlotSaatItu': PropertySchema(
      id: 1,
      name: r'sisaSlotSaatItu',
      type: IsarType.long,
    ),
    r'waktuKejadian': PropertySchema(
      id: 2,
      name: r'waktuKejadian',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _parkirLogEstimateSize,
  serialize: _parkirLogSerialize,
  deserialize: _parkirLogDeserialize,
  deserializeProp: _parkirLogDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _parkirLogGetId,
  getLinks: _parkirLogGetLinks,
  attach: _parkirLogAttach,
  version: '3.1.0+1',
);

int _parkirLogEstimateSize(
  ParkirLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.jenisAksi.length * 3;
  return bytesCount;
}

void _parkirLogSerialize(
  ParkirLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.jenisAksi);
  writer.writeLong(offsets[1], object.sisaSlotSaatItu);
  writer.writeDateTime(offsets[2], object.waktuKejadian);
}

ParkirLog _parkirLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ParkirLog();
  object.id = id;
  object.jenisAksi = reader.readString(offsets[0]);
  object.sisaSlotSaatItu = reader.readLong(offsets[1]);
  object.waktuKejadian = reader.readDateTime(offsets[2]);
  return object;
}

P _parkirLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _parkirLogGetId(ParkirLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _parkirLogGetLinks(ParkirLog object) {
  return [];
}

void _parkirLogAttach(IsarCollection<dynamic> col, Id id, ParkirLog object) {
  object.id = id;
}

extension ParkirLogQueryWhereSort
    on QueryBuilder<ParkirLog, ParkirLog, QWhere> {
  QueryBuilder<ParkirLog, ParkirLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ParkirLogQueryWhere
    on QueryBuilder<ParkirLog, ParkirLog, QWhereClause> {
  QueryBuilder<ParkirLog, ParkirLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ParkirLog, ParkirLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterWhereClause> idBetween(
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

extension ParkirLogQueryFilter
    on QueryBuilder<ParkirLog, ParkirLog, QFilterCondition> {
  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> jenisAksiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jenisAksi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      jenisAksiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jenisAksi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> jenisAksiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jenisAksi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> jenisAksiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jenisAksi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> jenisAksiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jenisAksi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> jenisAksiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jenisAksi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> jenisAksiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jenisAksi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> jenisAksiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jenisAksi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition> jenisAksiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jenisAksi',
        value: '',
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      jenisAksiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jenisAksi',
        value: '',
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      sisaSlotSaatItuEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sisaSlotSaatItu',
        value: value,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      sisaSlotSaatItuGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sisaSlotSaatItu',
        value: value,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      sisaSlotSaatItuLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sisaSlotSaatItu',
        value: value,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      sisaSlotSaatItuBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sisaSlotSaatItu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      waktuKejadianEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waktuKejadian',
        value: value,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      waktuKejadianGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waktuKejadian',
        value: value,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      waktuKejadianLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waktuKejadian',
        value: value,
      ));
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterFilterCondition>
      waktuKejadianBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waktuKejadian',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ParkirLogQueryObject
    on QueryBuilder<ParkirLog, ParkirLog, QFilterCondition> {}

extension ParkirLogQueryLinks
    on QueryBuilder<ParkirLog, ParkirLog, QFilterCondition> {}

extension ParkirLogQuerySortBy on QueryBuilder<ParkirLog, ParkirLog, QSortBy> {
  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> sortByJenisAksi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jenisAksi', Sort.asc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> sortByJenisAksiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jenisAksi', Sort.desc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> sortBySisaSlotSaatItu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sisaSlotSaatItu', Sort.asc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> sortBySisaSlotSaatItuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sisaSlotSaatItu', Sort.desc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> sortByWaktuKejadian() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waktuKejadian', Sort.asc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> sortByWaktuKejadianDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waktuKejadian', Sort.desc);
    });
  }
}

extension ParkirLogQuerySortThenBy
    on QueryBuilder<ParkirLog, ParkirLog, QSortThenBy> {
  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> thenByJenisAksi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jenisAksi', Sort.asc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> thenByJenisAksiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jenisAksi', Sort.desc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> thenBySisaSlotSaatItu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sisaSlotSaatItu', Sort.asc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> thenBySisaSlotSaatItuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sisaSlotSaatItu', Sort.desc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> thenByWaktuKejadian() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waktuKejadian', Sort.asc);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QAfterSortBy> thenByWaktuKejadianDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waktuKejadian', Sort.desc);
    });
  }
}

extension ParkirLogQueryWhereDistinct
    on QueryBuilder<ParkirLog, ParkirLog, QDistinct> {
  QueryBuilder<ParkirLog, ParkirLog, QDistinct> distinctByJenisAksi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jenisAksi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QDistinct> distinctBySisaSlotSaatItu() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sisaSlotSaatItu');
    });
  }

  QueryBuilder<ParkirLog, ParkirLog, QDistinct> distinctByWaktuKejadian() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waktuKejadian');
    });
  }
}

extension ParkirLogQueryProperty
    on QueryBuilder<ParkirLog, ParkirLog, QQueryProperty> {
  QueryBuilder<ParkirLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ParkirLog, String, QQueryOperations> jenisAksiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jenisAksi');
    });
  }

  QueryBuilder<ParkirLog, int, QQueryOperations> sisaSlotSaatItuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sisaSlotSaatItu');
    });
  }

  QueryBuilder<ParkirLog, DateTime, QQueryOperations> waktuKejadianProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waktuKejadian');
    });
  }
}
