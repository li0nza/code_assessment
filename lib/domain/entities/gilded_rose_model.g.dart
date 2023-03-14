// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gilded_rose_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GildedRoseModel _$$_GildedRoseModelFromJson(Map<String, dynamic> json) =>
    _$_GildedRoseModel(
      maxQuantity: json['maxQuantity'] as int,
      normalQuantityChange: json['normalQuantityChange'] as int,
      expiredMultiplier: json['expiredMultiplier'] as int,
      conjuredMultiplier: json['conjuredMultiplier'] as int,
      fiveDayMultiplier: json['fiveDayMultiplier'] as int,
      tenDayMultiplier: json['tenDayMultiplier'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GildedRoseModelToJson(_$_GildedRoseModel instance) =>
    <String, dynamic>{
      'maxQuantity': instance.maxQuantity,
      'normalQuantityChange': instance.normalQuantityChange,
      'expiredMultiplier': instance.expiredMultiplier,
      'conjuredMultiplier': instance.conjuredMultiplier,
      'fiveDayMultiplier': instance.fiveDayMultiplier,
      'tenDayMultiplier': instance.tenDayMultiplier,
      'items': instance.items,
    };

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      name: json['name'] as String,
      sellIn: json['sellIn'] as int,
      quality: json['quality'] as int,
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'name': instance.name,
      'sellIn': instance.sellIn,
      'quality': instance.quality,
    };
