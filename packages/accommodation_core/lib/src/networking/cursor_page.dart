class CursorPage<T> {
  const CursorPage({required this.items, this.totalCount, this.nextCursor});

  final List<T> items;
  final int? totalCount;
  final String? nextCursor;

  bool get hasNextPage => nextCursor != null;
}
