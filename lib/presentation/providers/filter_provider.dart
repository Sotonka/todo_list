import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterType { all, completed, incompleted }

class FilterViewModel extends StateNotifier<FilterType> {
  FilterViewModel() : super(FilterType.all);

  filterByAll() {
    state = FilterType.all;
  }

  filterByCompleted() {
    state = FilterType.completed;
  }

  filterByIncompleted() {
    state = FilterType.incompleted;
  }

  bool isFilteredByAll() {
    return state == FilterType.all;
  }

  bool isFilteredByCompleted() {
    return state == FilterType.completed;
  }

  bool isFilteredByIncompleted() {
    return state == FilterType.incompleted;
  }
}

final filterProvider =
    StateNotifierProvider.autoDispose<FilterViewModel, FilterType>(
        (_) => FilterViewModel());
