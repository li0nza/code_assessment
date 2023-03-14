import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_cubit.dart';
import 'package:code_assesment/presentation/widgets/dotted_curve_animation/end_of_day_animation.dart';
import 'package:code_assesment/presentation/widgets/fab_menu.dart';
import 'package:code_assesment/presentation/widgets/item_form.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget for the expandable FAB that contains the `add` and `end of day` FABs.
/// requires a list of `images` that is used for the loading page
class GildedRoseFAB extends StatelessWidget {
  const GildedRoseFAB({
    super.key,
    required this.images,
  });

  final List<ui.Image> images;

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 112.0,
      children: [
        FloatingActionButton(
          heroTag: "end-of-day-fab",
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () => endOfDayFab(context).show(),
          child: const Icon(Icons.arrow_forward),
        ),
        FloatingActionButton(
          heroTag: "add-fab",
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            //by not passing an Item, it opens the form with no prepopulated data
            FormDialog().openDialog(context: context);
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  AwesomeDialog endOfDayFab(BuildContext context) {
    return AwesomeDialog(
      context: context,
      keyboardAware: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      btnCancelText: "Not yet",
      btnCancelColor: Theme.of(context).colorScheme.secondary,
      btnOkText: "Yes, end the day",
      btnOkColor: Theme.of(context).colorScheme.primary,
      title: 'End the day?',
      desc:
          'You are about to end your day.\nItem values will be adjusted.\n\nTotal gold collected: ${context.read<GildedRoseCubit>().goldCollected}',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        showGeneralDialog<void>(
          context: context,
          barrierDismissible: false,
          pageBuilder: (BuildContext context, _, __) => EndOfDayAnimation(
            message: 'Accelerating time...',
            images: images,
          ),
        );
        context.read<GildedRoseCubit>().updateQuality();
        Future.delayed(const Duration(milliseconds: 5800), () {
          Navigator.of(context).pop();
        });
      },
    );
  }
}
