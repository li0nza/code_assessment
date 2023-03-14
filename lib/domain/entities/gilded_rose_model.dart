import 'package:freezed_annotation/freezed_annotation.dart';

part 'gilded_rose_model.freezed.dart';
part 'gilded_rose_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class GildedRoseModel with _$GildedRoseModel {
  const factory GildedRoseModel({
    required int maxQuantity,
    required int normalQuantityChange,
    required int expiredMultiplier,
    required int conjuredMultiplier,
    required int fiveDayMultiplier,
    required int tenDayMultiplier,
    required List<Item> items,
  }) = _GildedRoseModel;

  factory GildedRoseModel.fromJson(Map<String, dynamic> json) => _$GildedRoseModelFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
    required String name,
    required int sellIn,
    required int quality,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
