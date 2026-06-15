class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final Map<String, dynamic>? meta;
  final Map<String, List<String>>? errors;

  const ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.meta,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      meta: json['meta'] as Map<String, dynamic>?,
      errors: json['errors'] != null
          ? (json['errors'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                (value as List).map((e) => e.toString()).toList(),
              ),
            )
          : null,
    );
  }

  bool get hasData => data != null;
  bool get hasErrors => errors != null && errors!.isNotEmpty;
  bool get hasMeta => meta != null;

  int? get currentPage => meta?['currentPage'] as int?;
  int? get totalPages => meta?['totalPages'] as int?;
  int? get totalItems => meta?['totalItems'] as int?;
  bool get hasNextPage =>
      currentPage != null && totalPages != null && currentPage! < totalPages!;
}

class PaginatedResponse<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNextPage;

  const PaginatedResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasNextPage,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final data = json['data'] as List? ?? [];
    final meta = json['meta'] as Map<String, dynamic>? ?? {};

    return PaginatedResponse<T>(
      items: data
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      currentPage: meta['currentPage'] as int? ?? 1,
      totalPages: meta['totalPages'] as int? ?? 1,
      totalItems: meta['totalItems'] as int? ?? data.length,
      hasNextPage: meta['hasNextPage'] as bool? ?? false,
    );
  }
}
