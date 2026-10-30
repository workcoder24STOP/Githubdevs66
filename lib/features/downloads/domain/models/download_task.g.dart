// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_task.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDownloadTaskCollection on Isar {
  IsarCollection<DownloadTask> get downloadTasks => this.collection();
}

const DownloadTaskSchema = CollectionSchema(
  name: r'DownloadTask',
  id: -8326932930248620171,
  properties: {
    r'bookmarks': PropertySchema(
      id: 0,
      name: r'bookmarks',
      type: IsarType.longList,
    ),
    r'catalogKey': PropertySchema(
      id: 1,
      name: r'catalogKey',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'downloadedBytes': PropertySchema(
      id: 3,
      name: r'downloadedBytes',
      type: IsarType.long,
    ),
    r'episodeNumber': PropertySchema(
      id: 4,
      name: r'episodeNumber',
      type: IsarType.double,
    ),
    r'errorReason': PropertySchema(
      id: 5,
      name: r'errorReason',
      type: IsarType.string,
    ),
    r'externalIdsJson': PropertySchema(
      id: 6,
      name: r'externalIdsJson',
      type: IsarType.string,
    ),
    r'fileName': PropertySchema(
      id: 7,
      name: r'fileName',
      type: IsarType.string,
    ),
    r'headers': PropertySchema(
      id: 8,
      name: r'headers',
      type: IsarType.objectList,

      target: r'DownloadHeader',
    ),
    r'imported': PropertySchema(id: 9, name: r'imported', type: IsarType.bool),
    r'isM3u8': PropertySchema(id: 10, name: r'isM3u8', type: IsarType.bool),
    r'isManga': PropertySchema(id: 11, name: r'isManga', type: IsarType.bool),
    r'itemId': PropertySchema(id: 12, name: r'itemId', type: IsarType.string),
    r'itemTitle': PropertySchema(
      id: 13,
      name: r'itemTitle',
      type: IsarType.string,
    ),
    r'localPages': PropertySchema(
      id: 14,
      name: r'localPages',
      type: IsarType.stringList,
    ),
    r'mediaId': PropertySchema(id: 15, name: r'mediaId', type: IsarType.string),
    r'mediaTitle': PropertySchema(
      id: 16,
      name: r'mediaTitle',
      type: IsarType.string,
    ),
    r'pagesJson': PropertySchema(
      id: 17,
      name: r'pagesJson',
      type: IsarType.string,
    ),
    r'playbackMs': PropertySchema(
      id: 18,
      name: r'playbackMs',
      type: IsarType.long,
    ),
    r'progress': PropertySchema(
      id: 19,
      name: r'progress',
      type: IsarType.double,
    ),
    r'readingPage': PropertySchema(
      id: 20,
      name: r'readingPage',
      type: IsarType.long,
    ),
    r'requiresProxy': PropertySchema(
      id: 21,
      name: r'requiresProxy',
      type: IsarType.bool,
    ),
    r'savePath': PropertySchema(
      id: 22,
      name: r'savePath',
      type: IsarType.string,
    ),
    r'scanlator': PropertySchema(
      id: 23,
      name: r'scanlator',
      type: IsarType.string,
    ),
    r'season': PropertySchema(id: 24, name: r'season', type: IsarType.long),
    r'sourceBaseUrl': PropertySchema(
      id: 25,
      name: r'sourceBaseUrl',
      type: IsarType.string,
    ),
    r'sourceId': PropertySchema(
      id: 26,
      name: r'sourceId',
      type: IsarType.string,
    ),
    r'sourceName': PropertySchema(
      id: 27,
      name: r'sourceName',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 28,
      name: r'status',
      type: IsarType.byte,
      enumMap: _DownloadTaskstatusEnumValueMap,
    ),
    r'subtitles': PropertySchema(
      id: 29,
      name: r'subtitles',
      type: IsarType.objectList,

      target: r'DownloadSubtitle',
    ),
    r'titleKey': PropertySchema(
      id: 30,
      name: r'titleKey',
      type: IsarType.string,
    ),
    r'totalBytes': PropertySchema(
      id: 31,
      name: r'totalBytes',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 32,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'url': PropertySchema(id: 33, name: r'url', type: IsarType.string),
  },

  estimateSize: _downloadTaskEstimateSize,
  serialize: _downloadTaskSerialize,
  deserialize: _downloadTaskDeserialize,
  deserializeProp: _downloadTaskDeserializeProp,
  idName: r'id',
  indexes: {
    r'url': IndexSchema(
      id: -5756857009679432345,
      name: r'url',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'url',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'catalogKey': IndexSchema(
      id: 3392008383781132312,
      name: r'catalogKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'catalogKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'titleKey': IndexSchema(
      id: -8851891994416812020,
      name: r'titleKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'titleKey',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {
    r'DownloadHeader': DownloadHeaderSchema,
    r'DownloadSubtitle': DownloadSubtitleSchema,
  },

  getId: _downloadTaskGetId,
  getLinks: _downloadTaskGetLinks,
  attach: _downloadTaskAttach,
  version: '3.3.2',
);

int _downloadTaskEstimateSize(
  DownloadTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bookmarks.length * 8;
  bytesCount += 3 + object.catalogKey.length * 3;
  {
    final value = object.errorReason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.externalIdsJson.length * 3;
  bytesCount += 3 + object.fileName.length * 3;
  bytesCount += 3 + object.headers.length * 3;
  {
    final offsets = allOffsets[DownloadHeader]!;
    for (var i = 0; i < object.headers.length; i++) {
      final value = object.headers[i];
      bytesCount += DownloadHeaderSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.itemId.length * 3;
  bytesCount += 3 + object.itemTitle.length * 3;
  bytesCount += 3 + object.localPages.length * 3;
  {
    for (var i = 0; i < object.localPages.length; i++) {
      final value = object.localPages[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.mediaId.length * 3;
  bytesCount += 3 + object.mediaTitle.length * 3;
  bytesCount += 3 + object.pagesJson.length * 3;
  bytesCount += 3 + object.savePath.length * 3;
  bytesCount += 3 + object.scanlator.length * 3;
  bytesCount += 3 + object.sourceBaseUrl.length * 3;
  bytesCount += 3 + object.sourceId.length * 3;
  bytesCount += 3 + object.sourceName.length * 3;
  bytesCount += 3 + object.subtitles.length * 3;
  {
    final offsets = allOffsets[DownloadSubtitle]!;
    for (var i = 0; i < object.subtitles.length; i++) {
      final value = object.subtitles[i];
      bytesCount += DownloadSubtitleSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.titleKey.length * 3;
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _downloadTaskSerialize(
  DownloadTask object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.bookmarks);
  writer.writeString(offsets[1], object.catalogKey);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeLong(offsets[3], object.downloadedBytes);
  writer.writeDouble(offsets[4], object.episodeNumber);
  writer.writeString(offsets[5], object.errorReason);
  writer.writeString(offsets[6], object.externalIdsJson);
  writer.writeString(offsets[7], object.fileName);
  writer.writeObjectList<DownloadHeader>(
    offsets[8],
    allOffsets,
    DownloadHeaderSchema.serialize,
    object.headers,
  );
  writer.writeBool(offsets[9], object.imported);
  writer.writeBool(offsets[10], object.isM3u8);
  writer.writeBool(offsets[11], object.isManga);
  writer.writeString(offsets[12], object.itemId);
  writer.writeString(offsets[13], object.itemTitle);
  writer.writeStringList(offsets[14], object.localPages);
  writer.writeString(offsets[15], object.mediaId);
  writer.writeString(offsets[16], object.mediaTitle);
  writer.writeString(offsets[17], object.pagesJson);
  writer.writeLong(offsets[18], object.playbackMs);
  writer.writeDouble(offsets[19], object.progress);
  writer.writeLong(offsets[20], object.readingPage);
  writer.writeBool(offsets[21], object.requiresProxy);
  writer.writeString(offsets[22], object.savePath);
  writer.writeString(offsets[23], object.scanlator);
  writer.writeLong(offsets[24], object.season);
  writer.writeString(offsets[25], object.sourceBaseUrl);
  writer.writeString(offsets[26], object.sourceId);
  writer.writeString(offsets[27], object.sourceName);
  writer.writeByte(offsets[28], object.status.index);
  writer.writeObjectList<DownloadSubtitle>(
    offsets[29],
    allOffsets,
    DownloadSubtitleSchema.serialize,
    object.subtitles,
  );
  writer.writeString(offsets[30], object.titleKey);
  writer.writeLong(offsets[31], object.totalBytes);
  writer.writeDateTime(offsets[32], object.updatedAt);
  writer.writeString(offsets[33], object.url);
}

DownloadTask _downloadTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DownloadTask();
  object.bookmarks = reader.readLongList(offsets[0]) ?? [];
  object.catalogKey = reader.readString(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.downloadedBytes = reader.readLong(offsets[3]);
  object.episodeNumber = reader.readDouble(offsets[4]);
  object.errorReason = reader.readStringOrNull(offsets[5]);
  object.externalIdsJson = reader.readString(offsets[6]);
  object.fileName = reader.readString(offsets[7]);
  object.headers =
      reader.readObjectList<DownloadHeader>(
        offsets[8],
        DownloadHeaderSchema.deserialize,
        allOffsets,
        DownloadHeader(),
      ) ??
      [];
  object.id = id;
  object.imported = reader.readBool(offsets[9]);
  object.isM3u8 = reader.readBool(offsets[10]);
  object.isManga = reader.readBool(offsets[11]);
  object.itemId = reader.readString(offsets[12]);
  object.itemTitle = reader.readString(offsets[13]);
  object.localPages = reader.readStringList(offsets[14]) ?? [];
  object.mediaId = reader.readString(offsets[15]);
  object.mediaTitle = reader.readString(offsets[16]);
  object.pagesJson = reader.readString(offsets[17]);
  object.playbackMs = reader.readLong(offsets[18]);
  object.progress = reader.readDouble(offsets[19]);
  object.readingPage = reader.readLong(offsets[20]);
  object.requiresProxy = reader.readBool(offsets[21]);
  object.savePath = reader.readString(offsets[22]);
  object.scanlator = reader.readString(offsets[23]);
  object.season = reader.readLong(offsets[24]);
  object.sourceBaseUrl = reader.readString(offsets[25]);
  object.sourceId = reader.readString(offsets[26]);
  object.sourceName = reader.readString(offsets[27]);
  object.status =
      _DownloadTaskstatusValueEnumMap[reader.readByteOrNull(offsets[28])] ??
      DownloadStatus.pending;
  object.subtitles =
      reader.readObjectList<DownloadSubtitle>(
        offsets[29],
        DownloadSubtitleSchema.deserialize,
        allOffsets,
        DownloadSubtitle(),
      ) ??
      [];
  object.titleKey = reader.readString(offsets[30]);
  object.totalBytes = reader.readLong(offsets[31]);
  object.updatedAt = reader.readDateTime(offsets[32]);
  object.url = reader.readString(offsets[33]);
  return object;
}

P _downloadTaskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readObjectList<DownloadHeader>(
                offset,
                DownloadHeaderSchema.deserialize,
                allOffsets,
                DownloadHeader(),
              ) ??
              [])
          as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readStringList(offset) ?? []) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readDouble(offset)) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    case 21:
      return (reader.readBool(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    case 24:
      return (reader.readLong(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readString(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (_DownloadTaskstatusValueEnumMap[reader.readByteOrNull(offset)] ??
              DownloadStatus.pending)
          as P;
    case 29:
      return (reader.readObjectList<DownloadSubtitle>(
                offset,
                DownloadSubtitleSchema.deserialize,
                allOffsets,
                DownloadSubtitle(),
              ) ??
              [])
          as P;
    case 30:
      return (reader.readString(offset)) as P;
    case 31:
      return (reader.readLong(offset)) as P;
    case 32:
      return (reader.readDateTime(offset)) as P;
    case 33:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DownloadTaskstatusEnumValueMap = {
  'pending': 0,
  'downloading': 1,
  'paused': 2,
  'completed': 3,
  'failed': 4,
  'canceled': 5,
};
const _DownloadTaskstatusValueEnumMap = {
  0: DownloadStatus.pending,
  1: DownloadStatus.downloading,
  2: DownloadStatus.paused,
  3: DownloadStatus.completed,
  4: DownloadStatus.failed,
  5: DownloadStatus.canceled,
};

Id _downloadTaskGetId(DownloadTask object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _downloadTaskGetLinks(DownloadTask object) {
  return [];
}

void _downloadTaskAttach(
  IsarCollection<dynamic> col,
  Id id,
  DownloadTask object,
) {
  object.id = id;
}

extension DownloadTaskQueryWhereSort
    on QueryBuilder<DownloadTask, DownloadTask, QWhere> {
  QueryBuilder<DownloadTask, DownloadTask, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DownloadTaskQueryWhere
    on QueryBuilder<DownloadTask, DownloadTask, QWhereClause> {
  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause> urlEqualTo(
    String url,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'url', value: [url]),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause> urlNotEqualTo(
    String url,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'url',
                lower: [],
                upper: [url],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'url',
                lower: [url],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'url',
                lower: [url],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'url',
                lower: [],
                upper: [url],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause> catalogKeyEqualTo(
    String catalogKey,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'catalogKey', value: [catalogKey]),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause>
  catalogKeyNotEqualTo(String catalogKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'catalogKey',
                lower: [],
                upper: [catalogKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'catalogKey',
                lower: [catalogKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'catalogKey',
                lower: [catalogKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'catalogKey',
                lower: [],
                upper: [catalogKey],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause> titleKeyEqualTo(
    String titleKey,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'titleKey', value: [titleKey]),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterWhereClause>
  titleKeyNotEqualTo(String titleKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'titleKey',
                lower: [],
                upper: [titleKey],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'titleKey',
                lower: [titleKey],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'titleKey',
                lower: [titleKey],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'titleKey',
                lower: [],
                upper: [titleKey],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension DownloadTaskQueryFilter
    on QueryBuilder<DownloadTask, DownloadTask, QFilterCondition> {
  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'bookmarks', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bookmarks',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bookmarks',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bookmarks',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'bookmarks', length, true, length, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'bookmarks', 0, true, 0, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'bookmarks', 0, false, 999999, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'bookmarks', 0, true, length, include);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'bookmarks', length, include, 999999, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  bookmarksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bookmarks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'catalogKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'catalogKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'catalogKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'catalogKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'catalogKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'catalogKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'catalogKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'catalogKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'catalogKey', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  catalogKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'catalogKey', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  downloadedBytesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'downloadedBytes', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  downloadedBytesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'downloadedBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  downloadedBytesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'downloadedBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  downloadedBytesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'downloadedBytes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  episodeNumberEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'episodeNumber',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  episodeNumberGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'episodeNumber',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  episodeNumberLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'episodeNumber',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  episodeNumberBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'episodeNumber',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'errorReason'),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'errorReason'),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'errorReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'errorReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'errorReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'errorReason',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'errorReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'errorReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'errorReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'errorReason',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'errorReason', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  errorReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'errorReason', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'externalIdsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'externalIdsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'externalIdsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'externalIdsJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'externalIdsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'externalIdsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'externalIdsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'externalIdsJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'externalIdsJson', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  externalIdsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'externalIdsJson', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fileName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fileName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fileName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fileName', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  fileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fileName', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  headersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'headers', length, true, length, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  headersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'headers', 0, true, 0, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  headersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'headers', 0, false, 999999, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  headersLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'headers', 0, true, length, include);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  headersLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'headers', length, include, 999999, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  headersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  importedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'imported', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> isM3u8EqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isM3u8', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  isMangaEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isManga', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> itemIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'itemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'itemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'itemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> itemIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'itemId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'itemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'itemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'itemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> itemIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'itemId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'itemId', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'itemId', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'itemTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'itemTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'itemTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'itemTitle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'itemTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'itemTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'itemTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'itemTitle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'itemTitle', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  itemTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'itemTitle', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'localPages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'localPages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'localPages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'localPages',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'localPages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'localPages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'localPages',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'localPages',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localPages', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'localPages', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'localPages', length, true, length, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'localPages', 0, true, 0, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'localPages', 0, false, 999999, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'localPages', 0, true, length, include);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'localPages', length, include, 999999, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  localPagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'localPages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mediaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mediaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mediaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mediaId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mediaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mediaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mediaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mediaId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mediaId', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mediaId', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mediaTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mediaTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mediaTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mediaTitle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mediaTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mediaTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mediaTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mediaTitle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mediaTitle', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  mediaTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mediaTitle', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pagesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pagesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pagesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pagesJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'pagesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'pagesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'pagesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'pagesJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pagesJson', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  pagesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'pagesJson', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  playbackMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'playbackMs', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  playbackMsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playbackMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  playbackMsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playbackMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  playbackMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playbackMs',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  progressEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'progress',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  progressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'progress',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  progressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'progress',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  progressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'progress',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  readingPageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'readingPage', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  readingPageGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'readingPage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  readingPageLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'readingPage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  readingPageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'readingPage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  requiresProxyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'requiresProxy', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'savePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'savePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'savePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'savePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'savePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'savePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'savePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'savePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'savePath', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  savePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'savePath', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'scanlator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scanlator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scanlator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scanlator',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'scanlator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'scanlator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'scanlator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'scanlator',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scanlator', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  scanlatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'scanlator', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> seasonEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'season', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  seasonGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'season',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  seasonLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'season',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> seasonBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'season',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sourceBaseUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sourceBaseUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sourceBaseUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sourceBaseUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sourceBaseUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sourceBaseUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sourceBaseUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sourceBaseUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sourceBaseUrl', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceBaseUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sourceBaseUrl', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sourceId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sourceId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sourceId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sourceId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sourceId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sourceId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sourceId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sourceId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sourceId', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sourceId', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sourceName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sourceName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sourceName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sourceName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sourceName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sourceName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sourceName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sourceName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sourceName', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  sourceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sourceName', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> statusEqualTo(
    DownloadStatus value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  statusGreaterThan(DownloadStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  statusLessThan(DownloadStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> statusBetween(
    DownloadStatus lower,
    DownloadStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  subtitlesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'subtitles', length, true, length, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  subtitlesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'subtitles', 0, true, 0, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  subtitlesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'subtitles', 0, false, 999999, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  subtitlesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'subtitles', 0, true, length, include);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  subtitlesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'subtitles', length, include, 999999, true);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  subtitlesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subtitles',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'titleKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'titleKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'titleKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'titleKey',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'titleKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'titleKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'titleKey',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'titleKey',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'titleKey', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  titleKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'titleKey', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  totalBytesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalBytes', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  totalBytesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  totalBytesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  totalBytesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalBytes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'url',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> urlContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> urlMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'url',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'url', value: ''),
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'url', value: ''),
      );
    });
  }
}

extension DownloadTaskQueryObject
    on QueryBuilder<DownloadTask, DownloadTask, QFilterCondition> {
  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  headersElement(FilterQuery<DownloadHeader> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'headers');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterFilterCondition>
  subtitlesElement(FilterQuery<DownloadSubtitle> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'subtitles');
    });
  }
}

extension DownloadTaskQueryLinks
    on QueryBuilder<DownloadTask, DownloadTask, QFilterCondition> {}

extension DownloadTaskQuerySortBy
    on QueryBuilder<DownloadTask, DownloadTask, QSortBy> {
  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByCatalogKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catalogKey', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByCatalogKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catalogKey', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByDownloadedBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedBytes', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByDownloadedBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedBytes', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByEpisodeNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeNumber', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByEpisodeNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeNumber', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByErrorReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorReason', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByErrorReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorReason', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByExternalIdsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalIdsJson', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByExternalIdsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalIdsJson', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByImported() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imported', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByImportedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imported', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByIsM3u8() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isM3u8', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByIsM3u8Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isM3u8', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByIsManga() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManga', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByIsMangaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManga', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByItemTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemTitle', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByItemTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemTitle', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByMediaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByMediaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByPagesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagesJson', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByPagesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagesJson', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByPlaybackMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackMs', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByPlaybackMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackMs', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByReadingPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingPage', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByReadingPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingPage', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByRequiresProxy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresProxy', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByRequiresProxyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresProxy', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortBySavePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savePath', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortBySavePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savePath', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByScanlator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanlator', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByScanlatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanlator', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortBySeason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortBySeasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortBySourceBaseUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceBaseUrl', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortBySourceBaseUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceBaseUrl', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByTitleKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleKey', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByTitleKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleKey', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByTotalBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBytes', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  sortByTotalBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBytes', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension DownloadTaskQuerySortThenBy
    on QueryBuilder<DownloadTask, DownloadTask, QSortThenBy> {
  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByCatalogKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catalogKey', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByCatalogKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catalogKey', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByDownloadedBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedBytes', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByDownloadedBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedBytes', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByEpisodeNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeNumber', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByEpisodeNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeNumber', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByErrorReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorReason', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByErrorReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorReason', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByExternalIdsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalIdsJson', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByExternalIdsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalIdsJson', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByImported() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imported', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByImportedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imported', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByIsM3u8() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isM3u8', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByIsM3u8Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isM3u8', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByIsManga() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManga', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByIsMangaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManga', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByItemTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemTitle', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByItemTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemTitle', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByMediaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByMediaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByPagesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagesJson', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByPagesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pagesJson', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByPlaybackMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackMs', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByPlaybackMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playbackMs', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByReadingPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingPage', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByReadingPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readingPage', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByRequiresProxy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresProxy', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByRequiresProxyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requiresProxy', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenBySavePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savePath', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenBySavePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savePath', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByScanlator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanlator', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByScanlatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanlator', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenBySeason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenBySeasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenBySourceBaseUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceBaseUrl', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenBySourceBaseUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceBaseUrl', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByTitleKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleKey', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByTitleKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleKey', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByTotalBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBytes', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy>
  thenByTotalBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBytes', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension DownloadTaskQueryWhereDistinct
    on QueryBuilder<DownloadTask, DownloadTask, QDistinct> {
  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByBookmarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarks');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByCatalogKey({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'catalogKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct>
  distinctByDownloadedBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downloadedBytes');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct>
  distinctByEpisodeNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episodeNumber');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByErrorReason({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorReason', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct>
  distinctByExternalIdsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'externalIdsJson',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByFileName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByImported() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imported');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByIsM3u8() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isM3u8');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByIsManga() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isManga');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByItemId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByItemTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByLocalPages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localPages');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByMediaId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByMediaTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByPagesJson({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pagesJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByPlaybackMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playbackMs');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByReadingPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'readingPage');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct>
  distinctByRequiresProxy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requiresProxy');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctBySavePath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'savePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByScanlator({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scanlator', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctBySeason() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'season');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctBySourceBaseUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'sourceBaseUrl',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctBySourceId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctBySourceName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByTitleKey({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titleKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByTotalBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalBytes');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<DownloadTask, DownloadTask, QDistinct> distinctByUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }
}

extension DownloadTaskQueryProperty
    on QueryBuilder<DownloadTask, DownloadTask, QQueryProperty> {
  QueryBuilder<DownloadTask, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DownloadTask, List<int>, QQueryOperations> bookmarksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarks');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> catalogKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'catalogKey');
    });
  }

  QueryBuilder<DownloadTask, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<DownloadTask, int, QQueryOperations> downloadedBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downloadedBytes');
    });
  }

  QueryBuilder<DownloadTask, double, QQueryOperations> episodeNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodeNumber');
    });
  }

  QueryBuilder<DownloadTask, String?, QQueryOperations> errorReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorReason');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations>
  externalIdsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'externalIdsJson');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> fileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileName');
    });
  }

  QueryBuilder<DownloadTask, List<DownloadHeader>, QQueryOperations>
  headersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'headers');
    });
  }

  QueryBuilder<DownloadTask, bool, QQueryOperations> importedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imported');
    });
  }

  QueryBuilder<DownloadTask, bool, QQueryOperations> isM3u8Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isM3u8');
    });
  }

  QueryBuilder<DownloadTask, bool, QQueryOperations> isMangaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isManga');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> itemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemId');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> itemTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemTitle');
    });
  }

  QueryBuilder<DownloadTask, List<String>, QQueryOperations>
  localPagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localPages');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> mediaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaId');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> mediaTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaTitle');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> pagesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pagesJson');
    });
  }

  QueryBuilder<DownloadTask, int, QQueryOperations> playbackMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playbackMs');
    });
  }

  QueryBuilder<DownloadTask, double, QQueryOperations> progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<DownloadTask, int, QQueryOperations> readingPageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'readingPage');
    });
  }

  QueryBuilder<DownloadTask, bool, QQueryOperations> requiresProxyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requiresProxy');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> savePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'savePath');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> scanlatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scanlator');
    });
  }

  QueryBuilder<DownloadTask, int, QQueryOperations> seasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'season');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> sourceBaseUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceBaseUrl');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> sourceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceId');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> sourceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceName');
    });
  }

  QueryBuilder<DownloadTask, DownloadStatus, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<DownloadTask, List<DownloadSubtitle>, QQueryOperations>
  subtitlesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subtitles');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> titleKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titleKey');
    });
  }

  QueryBuilder<DownloadTask, int, QQueryOperations> totalBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalBytes');
    });
  }

  QueryBuilder<DownloadTask, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<DownloadTask, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DownloadHeaderSchema = Schema(
  name: r'DownloadHeader',
  id: 1302927990834472110,
  properties: {
    r'key': PropertySchema(id: 0, name: r'key', type: IsarType.string),
    r'value': PropertySchema(id: 1, name: r'value', type: IsarType.string),
  },

  estimateSize: _downloadHeaderEstimateSize,
  serialize: _downloadHeaderSerialize,
  deserialize: _downloadHeaderDeserialize,
  deserializeProp: _downloadHeaderDeserializeProp,
);

int _downloadHeaderEstimateSize(
  DownloadHeader object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.key.length * 3;
  bytesCount += 3 + object.value.length * 3;
  return bytesCount;
}

void _downloadHeaderSerialize(
  DownloadHeader object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.key);
  writer.writeString(offsets[1], object.value);
}

DownloadHeader _downloadHeaderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DownloadHeader();
  object.key = reader.readString(offsets[0]);
  object.value = reader.readString(offsets[1]);
  return object;
}

P _downloadHeaderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DownloadHeaderQueryFilter
    on QueryBuilder<DownloadHeader, DownloadHeader, QFilterCondition> {
  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyLessThan(String value, {bool include = false, bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'key',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'key',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'key',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'key', value: ''),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'key', value: ''),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'value',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'value',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'value',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'value', value: ''),
      );
    });
  }

  QueryBuilder<DownloadHeader, DownloadHeader, QAfterFilterCondition>
  valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'value', value: ''),
      );
    });
  }
}

extension DownloadHeaderQueryObject
    on QueryBuilder<DownloadHeader, DownloadHeader, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DownloadSubtitleSchema = Schema(
  name: r'DownloadSubtitle',
  id: -1217517709127904216,
  properties: {
    r'label': PropertySchema(id: 0, name: r'label', type: IsarType.string),
    r'language': PropertySchema(
      id: 1,
      name: r'language',
      type: IsarType.string,
    ),
    r'url': PropertySchema(id: 2, name: r'url', type: IsarType.string),
  },

  estimateSize: _downloadSubtitleEstimateSize,
  serialize: _downloadSubtitleSerialize,
  deserialize: _downloadSubtitleDeserialize,
  deserializeProp: _downloadSubtitleDeserializeProp,
);

int _downloadSubtitleEstimateSize(
  DownloadSubtitle object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.label.length * 3;
  bytesCount += 3 + object.language.length * 3;
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _downloadSubtitleSerialize(
  DownloadSubtitle object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.label);
  writer.writeString(offsets[1], object.language);
  writer.writeString(offsets[2], object.url);
}

DownloadSubtitle _downloadSubtitleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DownloadSubtitle();
  object.label = reader.readString(offsets[0]);
  object.language = reader.readString(offsets[1]);
  object.url = reader.readString(offsets[2]);
  return object;
}

P _downloadSubtitleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DownloadSubtitleQueryFilter
    on QueryBuilder<DownloadSubtitle, DownloadSubtitle, QFilterCondition> {
  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'label',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'label',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'label',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'label',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'label',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'label',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'label',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'label',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'label', value: ''),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'label', value: ''),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'language',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'language',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'language',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'language', value: ''),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  languageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'language', value: ''),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlLessThan(String value, {bool include = false, bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'url',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'url',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'url', value: ''),
      );
    });
  }

  QueryBuilder<DownloadSubtitle, DownloadSubtitle, QAfterFilterCondition>
  urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'url', value: ''),
      );
    });
  }
}

extension DownloadSubtitleQueryObject
    on QueryBuilder<DownloadSubtitle, DownloadSubtitle, QFilterCondition> {}
