import 'package:code_assesment/data/helpers/failure.dart';
import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_cubit.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_gilded_rose_model.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetGildedRoseData mockGetGildedRoseData;
  late GildedRoseCubit gildedRoseCubit;

  setUp(() {
    mockGetGildedRoseData = MockGetGildedRoseData();
    gildedRoseCubit = GildedRoseCubit(mockGetGildedRoseData);
  });

  const GildedRoseModel tGildedRoseModel = TestGildedRoseModel.tGildedRoseModel;

  test(
    'Initial state should be empty',
    () {
      expect(gildedRoseCubit.state.data, null);
    },
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Should return "loading -> data found" when data has been fetched successfully',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data'))
          .thenAnswer((_) async => const Right(tGildedRoseModel));
      return gildedRoseCubit;
    },
    act: (cubit) => cubit.fetchGildedRoseData(),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null),
      gildedRoseCubit.state,
    ],
    verify: (bloc) {
      verify(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data'));
    },
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Normal items should update correctly',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'foo', sellIn: 10, quality: 5),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'foo', sellIn: 10, quality: 5),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'foo', sellIn: 9, quality: 4),
          ],
        ),
      ),
    ],
  );
  blocTest<GildedRoseCubit, GildedRoseState>(
    'Normal items should update correctly when expired',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'foo', sellIn: 0, quality: 5),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'foo', sellIn: 0, quality: 5),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'foo', sellIn: -1, quality: 3),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Brie items should update correctly',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Aged Brie', sellIn: 5, quality: 10),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Aged Brie', sellIn: 5, quality: 10),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Aged Brie', sellIn: 4, quality: 11),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Brie items should update correctly when expired',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Aged Brie', sellIn: 0, quality: 10),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Aged Brie', sellIn: 0, quality: 10),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Aged Brie', sellIn: -1, quality: 12),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Sulfuras items should not change',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Sulfuras, Hand of Ragnaros', sellIn: 0, quality: 80),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Sulfuras, Hand of Ragnaros', sellIn: 0, quality: 80),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Backstage items should update correctly',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 15, quality: 20),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 15, quality: 20),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 14, quality: 21),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Backstage items should update correctly when sellIn < 10',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 9, quality: 20),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 9, quality: 20),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 8, quality: 22),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Backstage items should update correctly when sellIn < 5',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 4, quality: 20),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 4, quality: 20),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 3, quality: 23),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Backstage items should update correctly when sellIn < 0',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 0, quality: 20),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: 0, quality: 20),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Backstage passes to a TAFKAL80ETC concert', sellIn: -1, quality: 0),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Conjured items should update correctly',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Conjured Mana Cake', sellIn: 3, quality: 6),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Conjured Mana Cake', sellIn: 3, quality: 6),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Conjured Mana Cake', sellIn: 2, quality: 4),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Conjured items should update correctly',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Conjured Mana Cake', sellIn: 0, quality: 6),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.updateQuality();
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Conjured Mana Cake', sellIn: 0, quality: 6),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Conjured Mana Cake', sellIn: -1, quality: 2),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Selling an item should remove it from the list',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Conjured Mana Cake', sellIn: 1, quality: 6),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.sellItem(item: cubit.state.data!.items[0]);
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Conjured Mana Cake', sellIn: 1, quality: 6),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Adding an item should add it to the list',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data')).thenAnswer(
        (_) async => Right(
          tGildedRoseModel.copyWith(
            items: [
              const Item(name: 'Conjured Mana Cake', sellIn: 1, quality: 6),
            ],
          ),
        ),
      );
      return gildedRoseCubit;
    },
    act: (cubit) async {
      await cubit.fetchGildedRoseData();
      await cubit.addItem(name: 'Conjured Mana Cake', sellIn: 1, quality: 6);
    },
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, data: null, hasError: false),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Conjured Mana Cake', sellIn: 1, quality: 6),
          ],
        ),
      ),
      gildedRoseCubit.state.copyWith(
        isLoading: false,
        data: tGildedRoseModel.copyWith(
          items: [
            const Item(name: 'Conjured Mana Cake', sellIn: 1, quality: 6),
            const Item(name: 'Conjured Mana Cake', sellIn: 1, quality: 6),
          ],
        ),
      ),
    ],
  );

  blocTest<GildedRoseCubit, GildedRoseState>(
    'Should return "loading -> hasError" when fetching data fails',
    build: () {
      when(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data'))
          .thenAnswer((_) async => const Left(FetchDataFailure('')));
      return gildedRoseCubit;
    },
    act: (cubit) => cubit.fetchGildedRoseData(),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      gildedRoseCubit.state.copyWith(isLoading: true, hasError: false),
      gildedRoseCubit.state,
    ],
    verify: (bloc) {
      verify(mockGetGildedRoseData.execute(fileName: 'gilded_rose_data'));
    },
  );
}
