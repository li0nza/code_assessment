import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_cubit.dart';
import 'package:code_assesment/presentation/widgets/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// List row showing a `quality`, `name` and `sellIn` values for each [Item]
class ShopItem extends StatefulWidget {
  const ShopItem({super.key, required this.item, required this.index});

  final Item item;
  final int index;

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  /// [_selling] is used to trigger an animation on the row
  bool _selling = false;

  /// Returns a colour depending on the value of `quality`, uses the default
  /// common, rare, epic and legendary theme
  Color _getQualityColor(int quality) {
    if (quality <= 10) return Colors.green;
    if (quality <= 20) return Colors.blue;
    if (quality <= 50) return Colors.purple;
    return Colors.orange;
  }

  /// Returns a more user friendly string to show the user regarding the `sellIn` property. If `sellIn < 0` return `Expired` else return the date
  String _getSellInText(int sellIn) {
    if (sellIn < 0) return 'Expired';
    DateTime date = DateTime.now().add(Duration(days: sellIn));
    return 'Best before: ${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //fix height to 120
      height: 120,
      child: AnimatedOpacity(
        // if _selling is true, set opacity to 0, else set it to false to trigger selling animation
        opacity: _selling == true ? 0 : 1,
        duration: const Duration(milliseconds: 400),
        child: InkWell(
          // on body tap, open up a dialog with the fields prepopulated to edit an item
          onTap: () => FormDialog().openDialog(context: context, item: widget.item, index: widget.index),
          child: Card(
            color: Theme.of(context).colorScheme.onBackground,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //box to show the quality of an item, with the associated colour
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    color: Theme.of(context).colorScheme.background.withOpacity(0.3),
                    child: Center(
                      child: Text(
                        widget.item.quality.toString(),
                        style: TextStyle(
                          fontSize: 40,
                          color: _getQualityColor(widget.item.quality),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 4, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.item.name,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child:
                              Text(_getSellInText(widget.item.sellIn), style: Theme.of(context).textTheme.labelSmall),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FloatingActionButton(
                    heroTag: "sell-button-${widget.item.name}${widget.item.quality}${widget.item.sellIn}",
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      setState(() {
                        _selling = true;
                        //delay action until after animation
                        Future.delayed(
                          const Duration(milliseconds: 400),
                          // "sell" the item, ie. remove it from our list of items
                          () => context.read<GildedRoseCubit>().sellItem(item: widget.item),
                        );
                      });
                    },
                    child: const Text('\$'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
