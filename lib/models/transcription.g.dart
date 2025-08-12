// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcription.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTranscriptionCollection on Isar {
  IsarCollection<Transcription> get transcriptions => this.collection();
}

const TranscriptionSchema = CollectionSchema(
  name: r'Transcription',
  id: -783038334787647454,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'fullText': PropertySchema(
      id: 1,
      name: r'fullText',
      type: IsarType.string,
    ),
    r'originalUrl': PropertySchema(
      id: 2,
      name: r'originalUrl',
      type: IsarType.string,
    ),
    r'remoteId': PropertySchema(
      id: 3,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'sourceType': PropertySchema(
      id: 4,
      name: r'sourceType',
      type: IsarType.string,
      enumMap: _TranscriptionsourceTypeEnumValueMap,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.string,
      enumMap: _TranscriptionstatusEnumValueMap,
    ),
    r'summaryText': PropertySchema(
      id: 6,
      name: r'summaryText',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 7,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'videoTitle': PropertySchema(
      id: 8,
      name: r'videoTitle',
      type: IsarType.string,
    )
  },
  estimateSize: _transcriptionEstimateSize,
  serialize: _transcriptionSerialize,
  deserialize: _transcriptionDeserialize,
  deserializeProp: _transcriptionDeserializeProp,
  idName: r'id',
  indexes: {
    r'remoteId': IndexSchema(
      id: 6301175856541681032,
      name: r'remoteId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'remoteId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _transcriptionGetId,
  getLinks: _transcriptionGetLinks,
  attach: _transcriptionAttach,
  version: '3.1.0+1',
);

int _transcriptionEstimateSize(
  Transcription object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.fullText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.originalUrl.length * 3;
  bytesCount += 3 + object.remoteId.length * 3;
  bytesCount += 3 + object.sourceType.name.length * 3;
  bytesCount += 3 + object.status.name.length * 3;
  {
    final value = object.summaryText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.videoTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _transcriptionSerialize(
  Transcription object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.fullText);
  writer.writeString(offsets[2], object.originalUrl);
  writer.writeString(offsets[3], object.remoteId);
  writer.writeString(offsets[4], object.sourceType.name);
  writer.writeString(offsets[5], object.status.name);
  writer.writeString(offsets[6], object.summaryText);
  writer.writeDateTime(offsets[7], object.updatedAt);
  writer.writeString(offsets[8], object.videoTitle);
}

Transcription _transcriptionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Transcription();
  object.createdAt = reader.readDateTimeOrNull(offsets[0]);
  object.fullText = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.originalUrl = reader.readString(offsets[2]);
  object.remoteId = reader.readString(offsets[3]);
  object.sourceType = _TranscriptionsourceTypeValueEnumMap[
          reader.readStringOrNull(offsets[4])] ??
      SourceType.youtube;
  object.status =
      _TranscriptionstatusValueEnumMap[reader.readStringOrNull(offsets[5])] ??
          TranscriptionStatus.pending;
  object.summaryText = reader.readStringOrNull(offsets[6]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[7]);
  object.videoTitle = reader.readStringOrNull(offsets[8]);
  return object;
}

P _transcriptionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (_TranscriptionsourceTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          SourceType.youtube) as P;
    case 5:
      return (_TranscriptionstatusValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TranscriptionStatus.pending) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TranscriptionsourceTypeEnumValueMap = {
  r'youtube': r'youtube',
  r'bilibili': r'bilibili',
  r'other': r'other',
};
const _TranscriptionsourceTypeValueEnumMap = {
  r'youtube': SourceType.youtube,
  r'bilibili': SourceType.bilibili,
  r'other': SourceType.other,
};
const _TranscriptionstatusEnumValueMap = {
  r'pending': r'pending',
  r'processing': r'processing',
  r'completed': r'completed',
  r'failed': r'failed',
};
const _TranscriptionstatusValueEnumMap = {
  r'pending': TranscriptionStatus.pending,
  r'processing': TranscriptionStatus.processing,
  r'completed': TranscriptionStatus.completed,
  r'failed': TranscriptionStatus.failed,
};

Id _transcriptionGetId(Transcription object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transcriptionGetLinks(Transcription object) {
  return [];
}

void _transcriptionAttach(
    IsarCollection<dynamic> col, Id id, Transcription object) {
  object.id = id;
}

extension TranscriptionByIndex on IsarCollection<Transcription> {
  Future<Transcription?> getByRemoteId(String remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  Transcription? getByRemoteIdSync(String remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<Transcription?>> getAllByRemoteId(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<Transcription?> getAllByRemoteIdSync(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'remoteId', values);
  }

  Future<int> deleteAllByRemoteId(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'remoteId', values);
  }

  int deleteAllByRemoteIdSync(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'remoteId', values);
  }

  Future<Id> putByRemoteId(Transcription object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(Transcription object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<Transcription> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(List<Transcription> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension TranscriptionQueryWhereSort
    on QueryBuilder<Transcription, Transcription, QWhere> {
  QueryBuilder<Transcription, Transcription, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TranscriptionQueryWhere
    on QueryBuilder<Transcription, Transcription, QWhereClause> {
  QueryBuilder<Transcription, Transcription, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<Transcription, Transcription, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterWhereClause> idBetween(
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

  QueryBuilder<Transcription, Transcription, QAfterWhereClause> remoteIdEqualTo(
      String remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteId',
        value: [remoteId],
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterWhereClause>
      remoteIdNotEqualTo(String remoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TranscriptionQueryFilter
    on QueryBuilder<Transcription, Transcription, QFilterCondition> {
  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fullText',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fullText',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullText',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      fullTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullText',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
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

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originalUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originalUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originalUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'originalUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'originalUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'originalUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'originalUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      originalUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'originalUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeEqualTo(
    SourceType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeGreaterThan(
    SourceType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeLessThan(
    SourceType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeBetween(
    SourceType lower,
    SourceType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceType',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      sourceTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceType',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusEqualTo(
    TranscriptionStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusGreaterThan(
    TranscriptionStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusLessThan(
    TranscriptionStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusBetween(
    TranscriptionStatus lower,
    TranscriptionStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'summaryText',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'summaryText',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summaryText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'summaryText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'summaryText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'summaryText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'summaryText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'summaryText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'summaryText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'summaryText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summaryText',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      summaryTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'summaryText',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
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

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
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

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'videoTitle',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'videoTitle',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'videoTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'videoTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'videoTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'videoTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'videoTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'videoTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'videoTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'videoTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'videoTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterFilterCondition>
      videoTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'videoTitle',
        value: '',
      ));
    });
  }
}

extension TranscriptionQueryObject
    on QueryBuilder<Transcription, Transcription, QFilterCondition> {}

extension TranscriptionQueryLinks
    on QueryBuilder<Transcription, Transcription, QFilterCondition> {}

extension TranscriptionQuerySortBy
    on QueryBuilder<Transcription, Transcription, QSortBy> {
  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      sortByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortByOriginalUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalUrl', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      sortByOriginalUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalUrl', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortBySourceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      sortBySourceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortBySummaryText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summaryText', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      sortBySummaryTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summaryText', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> sortByVideoTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoTitle', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      sortByVideoTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoTitle', Sort.desc);
    });
  }
}

extension TranscriptionQuerySortThenBy
    on QueryBuilder<Transcription, Transcription, QSortThenBy> {
  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      thenByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenByOriginalUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalUrl', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      thenByOriginalUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalUrl', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenBySourceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      thenBySourceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenBySummaryText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summaryText', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      thenBySummaryTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summaryText', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy> thenByVideoTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoTitle', Sort.asc);
    });
  }

  QueryBuilder<Transcription, Transcription, QAfterSortBy>
      thenByVideoTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoTitle', Sort.desc);
    });
  }
}

extension TranscriptionQueryWhereDistinct
    on QueryBuilder<Transcription, Transcription, QDistinct> {
  QueryBuilder<Transcription, Transcription, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Transcription, Transcription, QDistinct> distinctByFullText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transcription, Transcription, QDistinct> distinctByOriginalUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transcription, Transcription, QDistinct> distinctByRemoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transcription, Transcription, QDistinct> distinctBySourceType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transcription, Transcription, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transcription, Transcription, QDistinct> distinctBySummaryText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summaryText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transcription, Transcription, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Transcription, Transcription, QDistinct> distinctByVideoTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'videoTitle', caseSensitive: caseSensitive);
    });
  }
}

extension TranscriptionQueryProperty
    on QueryBuilder<Transcription, Transcription, QQueryProperty> {
  QueryBuilder<Transcription, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Transcription, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Transcription, String?, QQueryOperations> fullTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullText');
    });
  }

  QueryBuilder<Transcription, String, QQueryOperations> originalUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalUrl');
    });
  }

  QueryBuilder<Transcription, String, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<Transcription, SourceType, QQueryOperations>
      sourceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceType');
    });
  }

  QueryBuilder<Transcription, TranscriptionStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Transcription, String?, QQueryOperations> summaryTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summaryText');
    });
  }

  QueryBuilder<Transcription, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Transcription, String?, QQueryOperations> videoTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'videoTitle');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transcription _$TranscriptionFromJson(Map<String, dynamic> json) =>
    Transcription()
      ..remoteId = json['id'] as String
      ..videoTitle = json['video_title'] as String?
      ..originalUrl = json['original_url'] as String
      ..sourceType = $enumDecode(_$SourceTypeEnumMap, json['source_type'])
      ..fullText = json['full_text'] as String?
      ..summaryText = json['summary_text'] as String?
      ..status = $enumDecode(_$TranscriptionStatusEnumMap, json['status'])
      ..createdAt = json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String)
      ..updatedAt = json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String);

Map<String, dynamic> _$TranscriptionToJson(Transcription instance) =>
    <String, dynamic>{
      'id': instance.remoteId,
      'video_title': instance.videoTitle,
      'original_url': instance.originalUrl,
      'source_type': _$SourceTypeEnumMap[instance.sourceType]!,
      'full_text': instance.fullText,
      'summary_text': instance.summaryText,
      'status': _$TranscriptionStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$SourceTypeEnumMap = {
  SourceType.youtube: 'YOUTUBE',
  SourceType.bilibili: 'BILIBILI',
  SourceType.other: 'OTHER',
};

const _$TranscriptionStatusEnumMap = {
  TranscriptionStatus.pending: 'PENDING',
  TranscriptionStatus.processing: 'PROCESSING',
  TranscriptionStatus.completed: 'COMPLETED',
  TranscriptionStatus.failed: 'FAILED',
};

TaskInfo _$TaskInfoFromJson(Map<String, dynamic> json) => TaskInfo(
      taskId: json['task_id'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$TaskInfoToJson(TaskInfo instance) => <String, dynamic>{
      'task_id': instance.taskId,
      'status': instance.status,
    };

TranscriptionCreate _$TranscriptionCreateFromJson(Map<String, dynamic> json) =>
    TranscriptionCreate(
      url: json['url'] as String,
      summarize: json['summarize'] as bool? ?? false,
      asrEngine: json['asr_engine'] as String?,
    );

Map<String, dynamic> _$TranscriptionCreateToJson(
        TranscriptionCreate instance) =>
    <String, dynamic>{
      'url': instance.url,
      'summarize': instance.summarize,
      'asr_engine': instance.asrEngine,
    };
