import 'package:code_assesment/domain/entities/gilded_rose_model.dart';

 abstract class TestGildedRoseModel {
  static const GildedRoseModel tGildedRoseModel = GildedRoseModel(
    maxQuantity: 50,
    normalQuantityChange: 1,
    expiredMultiplier: 2,
    conjuredMultiplier: 2,
    fiveDayMultiplier: 3,
    tenDayMultiplier: 2,
    items: [
      Item(name: '+5 Dexterity Vest', sellIn: 10, quality: 20),
      Item(name: 'Aged Brie', sellIn: 2, quality: 0),
      Item(name: 'Elixir of the Mongoose', sellIn: 5, quality: 7),
      Item(name: 'Sulfuras, Hand of Ragnaros', sellIn: 0, quality: 80),
      Item(name: 'Sulfuras, Hand of Ragnaros', sellIn: -1, quality: 80),
      Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 15, quality: 20),
      Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 10, quality: 49),
      Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 5, quality: 49),
      Item(name: 'Conjured Mana Cake', sellIn: 3, quality: 6),
    ],
  );
}
