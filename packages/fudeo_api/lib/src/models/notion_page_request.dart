class NotionPageRequest {
  const NotionPageRequest({
    required this.pageSize,
    this.cursor,
  });

  final int pageSize;
  final String? cursor;

  Map<String, dynamic> toJson() {
    return {
      'page_size': pageSize,
      if (cursor != null) 'cursor': cursor,
    };
  }
}
