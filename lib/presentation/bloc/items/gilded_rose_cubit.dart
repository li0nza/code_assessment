import 'dart:convert';

import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:code_assesment/domain/usecases/get_gilded_rose_data.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [Cubit] managing the [GildedRoseState]. Requires the [GetGildedRoseData] `use case`
class GildedRoseCubit extends Cubit<GildedRoseState> {
  final GetGildedRoseData _getGildedRoseData;
  late GildedRoseModel data;
  int _goldCollected = 0;

  GildedRoseCubit(this._getGildedRoseData) : super(const GildedRoseState());

  /// Method to fetch [GildedRose] data with a list of [Item]s.
  Future<void> fetchGildedRoseData() async {
    emit(state.copyWith(isLoading: true, hasError: false));
    final result = await _getGildedRoseData.execute(fileName: 'gilded_rose_data');
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, hasError: true));
      },
      (GildedRoseModel result) {
        data = result;
        emit(state.copyWith(data: result, isLoading: false));
      },
    );
  }

  /// [sellItem] removes the [Item] from the list of items and adds the `quality` to `_goldCollected`
  /// and emits a new state by using `_updateState`
  Future<void> sellItem({required Item item}) async {
    GildedRoseModel deepcopy = _deepCopy(state.data!);
    deepcopy.items.remove(item);
    _goldCollected += item.quality;
    _updateState(deepcopy);
  }

  /// [addItem] adds a new item to the list of [Item]s
  /// and emits a new state by using `_updateState`
  Future<void> addItem({required String name, required int quality, required int sellIn}) async {
    GildedRoseModel deepcopy = _deepCopy(state.data!);
    deepcopy.items.add(Item(name: name, quality: _clamp(quality), sellIn: sellIn));
    _updateState(deepcopy);
  }

  /// [editItem] edits an item in the list of [Item]s
  /// and emits a new state by using `_updateState`
  //TODO: stop it from clamping legendary items to 50 quality
  Future<void> editItem({required String name, required int quality, required int sellIn, required int index}) async {
    GildedRoseModel deepcopy = _deepCopy(state.data!);
    deepcopy.items[index] = deepcopy.items[index].copyWith(name: name, quality: _clamp(quality), sellIn: sellIn);
    _updateState(deepcopy);
  }

  Future<void> updateQuality() async {
    GildedRoseModel deepcopy = _deepCopy(state.data!);
    for (int i = 0; i < deepcopy.items.length; i++) {
      Item item = deepcopy.items[i];
      // Not a big fan of if elses, but using this instead of a switch because of the ability to
      // add new items, and not being able to restrict user input. Therefore need to use contains.
      if (item.name == 'Aged Brie') {
        item = _updateAgedBrie(item);
      } else if (item.name.toLowerCase().contains('backstage pass')) {
        item = _updateBackstagePasses(item);
      } else if (item.name.toLowerCase().contains('conjured')) {
        item = _updateConjuredItems(item);
      } else if (!item.name.toLowerCase().contains('sulfuras')) {
        item = _updateNormalItem(item);
      }
      deepcopy.items[i] = item;
    }

    //TODO: figure out why the state is closed before calling the below in tests
    try {
      _updateState(deepcopy);
    } catch (_) {}
  }

  int get goldCollected => _goldCollected;

  /// Update the value of a normal item, if `sellIn` is `greater than 0` reduce `quality` by `normalQuantityChange`(1)
  /// if `sellIn` is `less than 0` reduce `quality` by `normalQuantityChange(1) * expiredMultiplier(2)`
  /// return a copy of the [Item] with the updated `sellIn` and `quantity`
  Item _updateNormalItem(Item item) {
    var qualityChange = item.sellIn > 0
        ? state.data!.normalQuantityChange
        : state.data!.normalQuantityChange * state.data!.expiredMultiplier;
    return item.copyWith(sellIn: item.sellIn - 1, quality: _clamp(item.quality - qualityChange));
  }

  /// Update the value of brie, if `sellIn` is `greater than 0` increase `quality` by `normalQuantityChange`(1)
  /// if `sellIn` is `less than 0` increase `quality` by `normalQuantityChange(1) * expiredMultiplier(2)`
  /// return a copy of the [Item] with the updated `sellIn` and `quantity`
  Item _updateAgedBrie(Item item) {
    var qualityChange = item.sellIn > 0
        ? state.data!.normalQuantityChange
        : state.data!.normalQuantityChange * state.data!.expiredMultiplier;
    return item.copyWith(sellIn: item.sellIn - 1, quality: _clamp(item.quality + qualityChange));
  }

  /// Update the value of backstage passes, if `sellIn` is `greater than 0 and less than 5` increase `quality` by `normalQuantityChange(1) * fiveDayMultiplier(3)`
  /// if `sellIn` is `greater than 0 and less than 10` increase `quality` by `normalQuantityChange(1) * tenDayMultiplier(2)`
  /// if `sellIn` is `less than 0 or 0` then `quality` is set to `0`
  /// return a copy of the [Item] with the updated `sellIn` and `quantity`
  Item _updateBackstagePasses(Item item) {
    int quality = item.quality;

    if (item.sellIn > 10) {
      quality += state.data!.normalQuantityChange;
    } else if (item.sellIn > 5) {
      quality += state.data!.normalQuantityChange * state.data!.tenDayMultiplier;
    } else if (item.sellIn > 0) {
      quality += state.data!.normalQuantityChange * state.data!.fiveDayMultiplier;
    } else {
      quality = 0;
    }
    return item.copyWith(sellIn: item.sellIn - 1, quality: _clamp(quality));
  }

  /// Update the value of a conured item, if `sellIn` is `greater than 0` reduce `quality` by `normalQuantityChange(1) * conjuredMultiplier(2)`
  /// if `sellIn` is `less than 0` reduce `quality` by `normalQuantityChange(1) * conjuredMultiplier(2) * expiredMultiplier(2)`
  /// return a copy of the [Item] with the updated `sellIn` and `quantity`
  Item _updateConjuredItems(Item item) {
    var qualityChange = item.sellIn > 0
        ? state.data!.normalQuantityChange * state.data!.conjuredMultiplier
        : state.data!.normalQuantityChange * state.data!.expiredMultiplier * state.data!.conjuredMultiplier;
    return item.copyWith(sellIn: item.sellIn - 1, quality: _clamp(item.quality - qualityChange));
  }

  /// Make a deepcopy of [GildedRoseModel]
  GildedRoseModel _deepCopy(GildedRoseModel data) {
    return GildedRoseModel.fromJson(jsonDecode(jsonEncode(data)));
  }

  /// Update state and set `data` to the `newData`
  _updateState(GildedRoseModel newData) {
    data = newData;
    emit(state.copyWith(data: newData));
  }

  /// Ensure `quality` ia always `greater than or equal to 0 and less than or equal to 50`
  int _clamp(int value) {
    return value.clamp(0, state.data!.maxQuantity);
  }
}
