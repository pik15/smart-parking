// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ktp.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserKtpCollection on Isar {
  IsarCollection<UserKtp> get userKtps => this.collection();
}

const UserKtpSchema = CollectionSchema(
  name: r'UserKtp',
  id: 4279618714626330423,
  properties: {
    r'apakahDiDalam': PropertySchema(
      id: 0,
      name: r'apakahDiDalam',
      type: IsarType.bool,
    ),
    r'namaPemilik': PropertySchema(
      id: 1,
      name: r'namaPemilik',
      type: IsarType.string,
    ),
    r'statusAktif': PropertySchema(
      id: 2,
      name: r'statusAktif',
      type: IsarType.bool,
    ),
    r'tanggalDaftar': PropertySchema(
      id: 3,
      name: r'tanggalDaftar',
      type: IsarType.dateTime,
    ),
    r'uidKartu': PropertySchema(
      id: 4,
      name: r'uidKartu',
      type: IsarType.string,
    )
  },
  estimateSize: _userKtpEstimateSize,
  serialize: _userKtpSerialize,
  deserialize: _userKtpDeserialize,
  deserializeProp: _userKtpDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userKtpGetId,
  getLinks: _userKtpGetLinks,
  attach: _userKtpAttach,
  version: '3.1.0+1',
);

int _userKtpEstimateSize(
  UserKtp object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.namaPemilik.length * 3;
  bytesCount += 3 + object.uidKartu.length * 3;
  return bytesCount;
}

void _userKtpSerialize(
  UserKtp object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.apakahDiDalam);
  writer.writeString(offsets[1], object.namaPemilik);
  writer.writeBool(offsets[2], object.statusAktif);
  writer.writeDateTime(offsets[3], object.tanggalDaftar);
  writer.writeString(offsets[4], object.uidKartu);
}

UserKtp _userKtpDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserKtp();
  object.apakahDiDalam = reader.readBoolOrNull(offsets[0]);
  object.id = id;
  object.namaPemilik = reader.readString(offsets[1]);
  object.statusAktif = reader.readBool(offsets[2]);
  object.tanggalDaftar = reader.readDateTime(offsets[3]);
  object.uidKartu = reader.readString(offsets[4]);
  return object;
}

P _userKtpDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userKtpGetId(UserKtp object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userKtpGetLinks(UserKtp object) {
  return [];
}

void _userKtpAttach(IsarCollection<dynamic> col, Id id, UserKtp object) {
  object.id = id;
}

extension UserKtpQueryWhereSort on QueryBuilder<UserKtp, UserKtp, QWhere> {
  QueryBuilder<UserKtp, UserKtp, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserKtpQueryWhere on QueryBuilder<UserKtp, UserKtp, QWhereClause> {
  QueryBuilder<UserKtp, UserKtp, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<UserKtp, UserKtp, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterWhereClause> idBetween(
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

extension UserKtpQueryFilter
    on QueryBuilder<UserKtp, UserKtp, QFilterCondition> {
  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> apakahDiDalamIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apakahDiDalam',
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition>
      apakahDiDalamIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apakahDiDalam',
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> apakahDiDalamEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apakahDiDalam',
        value: value,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> namaPemilikEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'namaPemilik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> namaPemilikGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'namaPemilik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> namaPemilikLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'namaPemilik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> namaPemilikBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'namaPemilik',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> namaPemilikStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'namaPemilik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> namaPemilikEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'namaPemilik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> namaPemilikContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'namaPemilik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> namaPemilikMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'namaPemilik',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> namaPemilikIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'namaPemilik',
        value: '',
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition>
      namaPemilikIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'namaPemilik',
        value: '',
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> statusAktifEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusAktif',
        value: value,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> tanggalDaftarEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tanggalDaftar',
        value: value,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition>
      tanggalDaftarGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tanggalDaftar',
        value: value,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> tanggalDaftarLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tanggalDaftar',
        value: value,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> tanggalDaftarBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tanggalDaftar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uidKartu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uidKartu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uidKartu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uidKartu',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uidKartu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uidKartu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uidKartu',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uidKartu',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uidKartu',
        value: '',
      ));
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterFilterCondition> uidKartuIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uidKartu',
        value: '',
      ));
    });
  }
}

extension UserKtpQueryObject
    on QueryBuilder<UserKtp, UserKtp, QFilterCondition> {}

extension UserKtpQueryLinks
    on QueryBuilder<UserKtp, UserKtp, QFilterCondition> {}

extension UserKtpQuerySortBy on QueryBuilder<UserKtp, UserKtp, QSortBy> {
  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByApakahDiDalam() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apakahDiDalam', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByApakahDiDalamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apakahDiDalam', Sort.desc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByNamaPemilik() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPemilik', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByNamaPemilikDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPemilik', Sort.desc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByStatusAktif() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusAktif', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByStatusAktifDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusAktif', Sort.desc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByTanggalDaftar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tanggalDaftar', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByTanggalDaftarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tanggalDaftar', Sort.desc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByUidKartu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uidKartu', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> sortByUidKartuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uidKartu', Sort.desc);
    });
  }
}

extension UserKtpQuerySortThenBy
    on QueryBuilder<UserKtp, UserKtp, QSortThenBy> {
  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByApakahDiDalam() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apakahDiDalam', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByApakahDiDalamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apakahDiDalam', Sort.desc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByNamaPemilik() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPemilik', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByNamaPemilikDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaPemilik', Sort.desc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByStatusAktif() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusAktif', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByStatusAktifDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusAktif', Sort.desc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByTanggalDaftar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tanggalDaftar', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByTanggalDaftarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tanggalDaftar', Sort.desc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByUidKartu() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uidKartu', Sort.asc);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QAfterSortBy> thenByUidKartuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uidKartu', Sort.desc);
    });
  }
}

extension UserKtpQueryWhereDistinct
    on QueryBuilder<UserKtp, UserKtp, QDistinct> {
  QueryBuilder<UserKtp, UserKtp, QDistinct> distinctByApakahDiDalam() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apakahDiDalam');
    });
  }

  QueryBuilder<UserKtp, UserKtp, QDistinct> distinctByNamaPemilik(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'namaPemilik', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserKtp, UserKtp, QDistinct> distinctByStatusAktif() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusAktif');
    });
  }

  QueryBuilder<UserKtp, UserKtp, QDistinct> distinctByTanggalDaftar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tanggalDaftar');
    });
  }

  QueryBuilder<UserKtp, UserKtp, QDistinct> distinctByUidKartu(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uidKartu', caseSensitive: caseSensitive);
    });
  }
}

extension UserKtpQueryProperty
    on QueryBuilder<UserKtp, UserKtp, QQueryProperty> {
  QueryBuilder<UserKtp, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserKtp, bool?, QQueryOperations> apakahDiDalamProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apakahDiDalam');
    });
  }

  QueryBuilder<UserKtp, String, QQueryOperations> namaPemilikProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'namaPemilik');
    });
  }

  QueryBuilder<UserKtp, bool, QQueryOperations> statusAktifProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusAktif');
    });
  }

  QueryBuilder<UserKtp, DateTime, QQueryOperations> tanggalDaftarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tanggalDaftar');
    });
  }

  QueryBuilder<UserKtp, String, QQueryOperations> uidKartuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uidKartu');
    });
  }
}
