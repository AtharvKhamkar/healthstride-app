// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

class SyncHealthDataRequest {
  final String source;
  final List<HealthDataPoint> records;
  SyncHealthDataRequest({required this.source, required this.records});

  SyncHealthDataRequest copyWith({
    String? source,
    List<HealthDataPoint>? records,
  }) {
    return SyncHealthDataRequest(
      source: source ?? this.source,
      records: records ?? this.records,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source,
      'records': records.map((x) => x.toJson()).toList(),
    };
  }

  factory SyncHealthDataRequest.fromMap(Map<String, dynamic> map) {
    return SyncHealthDataRequest(
      source: map['source'] as String,
      records: List<HealthDataPoint>.from(
        (map['records'] as List<int>).map<HealthDataPoint>(
          (x) => HealthDataPoint.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SyncHealthDataRequest.fromJson(String source) =>
      SyncHealthDataRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'SyncHealthDataRequest(source: $source, records: $records)';

  @override
  bool operator ==(covariant SyncHealthDataRequest other) {
    if (identical(this, other)) return true;

    return other.source == source && listEquals(other.records, records);
  }

  @override
  int get hashCode => source.hashCode ^ records.hashCode;
}
