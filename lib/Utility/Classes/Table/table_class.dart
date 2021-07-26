class AppColumnData<T> {
  final String id;
  final String title;
  final T value;
  final String valueAsString;
  final Function()? clickEvent;

  AppColumnData({
    required this.id,
    required this.title,
    required this.value,
    required this.valueAsString,
    this.clickEvent,
  });

  @override
  bool operator ==(Object columnData) => columnData is AppColumnData && columnData.id == id;

  @override
  int get hashCode => id.hashCode;
}

class AppRowData {
  final List<AppColumnData> columnDataList;
  final AppColumnData primaryColumnData;

  AppRowData({
    required this.columnDataList,
    required this.primaryColumnData,
  });

  List<AppColumnData> get filteredList {
    return columnDataList
        .where((element) => element != primaryColumnData)
        .toList();
  }
}
