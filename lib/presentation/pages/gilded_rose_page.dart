import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_cubit.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_state.dart';
import 'package:code_assesment/presentation/widgets/gilded_rose_fab.dart';
import 'package:code_assesment/presentation/widgets/loading.dart';
import 'package:code_assesment/presentation/widgets/shop_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:ui' as ui;

/// Page containing all the elements needed for a complete [GildedRosePage].
/// The page includes a `listview` with list tiles containing the `quality` of an [Item], a `name`
/// and the `sellIn` value
class GildedRosePage extends StatefulWidget {
  const GildedRosePage({Key? key}) : super(key: key);

  @override
  State<GildedRosePage> createState() => _GildedRosePageState();
}

class _GildedRosePageState extends State<GildedRosePage> {
  List<ui.Image> images = [];

  @override
  void initState() {
    super.initState();
    /// Fetch [GildedRoseModel] as soon as poage is initializing
    context.read<GildedRoseCubit>().fetchGildedRoseData();

    /// Load svg images used for the loading animation to end the day, ideally we would want to initialize these in
    /// the startup of the app (before the splash screen is removed). But due to the simplicity of the app we do it here
    vg.loadPicture(const SvgAssetLoader('assets/moon.svg'), null).then((pictureInfo) async {
      images.add(await pictureInfo.picture.toImage(520, 520));
    });
    vg.loadPicture(const SvgAssetLoader('assets/sun.svg'), null).then((pictureInfo) async {
      images.add(await pictureInfo.picture.toImage(256, 256));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Items',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      floatingActionButton: GildedRoseFAB(images: images),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverFillRemaining(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: BlocBuilder<GildedRoseCubit, GildedRoseState>(
                builder: (context, state) {
                  /// If [state.isLoading] is `true` show the [GenericLoading] widget
                  if (state.isLoading) return const GenericLoader(message: 'Loading shop contents...');
                  /// If [state.hasError] is `true` show an error message
                  if (state.hasError) {
                  // TODO: implement a reload button
                  // Skipping for now because we are only loading data from a json file
                    return const Center(
                      key: Key('error_widget_key'),
                      child: Text(
                        'Something went wrong, try again.',
                      ),
                    );
                  }
                  /// If [state] has content, and [hasError] and [isLoading] is false, show the content
                  return Container(
                    color: Theme.of(context).colorScheme.background,
                    child: ListView.builder(
                      key: const Key('gilded_rose_page_list_view'),
                      itemCount: state.data?.items.length,
                      itemBuilder: (context, index) {
                        Item item = state.data!.items[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: index == state.data!.items.length - 1 ? 50 : 0),
                          child: ShopItem(
                            key: Key('shop-item-${item.name}-$index-${item.quality}-${item.sellIn}'),
                            item: item,
                            index: index,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}