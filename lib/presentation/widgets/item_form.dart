import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_cubit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormDialog {
  late AwesomeDialog dialog;
  final formKey = GlobalKey<FormState>();
  bool _isEdit = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController qualityController = TextEditingController();
  TextEditingController sellInController = TextEditingController();

  /// Opens a dialog to add or edit an [Item]
  void openDialog({required BuildContext context, Item? item, int index = 0}) {
    if (item != null) {
      _isEdit = true;
      nameController.text = item.name;
      qualityController.text = item.quality.toString();
      sellInController.text = item.sellIn.toString();
    }
    dialog = AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      keyboardAware: true,
      btnCancelText: 'Cancel',
      btnOkText: _isEdit ? 'Save' : 'Add',
      autoDismiss: false,
      onDismissCallback: (type) {
        // clear text fields on dismissing the dialog
        Navigator.of(context).pop();
        nameController.text = '';
        qualityController.text = '';
        sellInController.text = '';
      },
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Text(
                _isEdit ? 'Edit Item' : 'New Item',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                elevation: 0,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                  autofocus: true,
                  minLines: 1,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.title),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                elevation: 0,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Quality',
                    prefixIcon: Icon(Icons.numbers),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                elevation: 0,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                child: TextFormField(
                  controller: sellInController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Sell In',
                    prefixIcon: Icon(Icons.numbers),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: AnimatedButton(
                          color: Theme.of(context).colorScheme.secondary,
                          isFixedHeight: false,
                          text: 'Close',
                          pressEvent: () {
                            dialog.dismiss();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: AnimatedButton(
                          isFixedHeight: false,
                          text: _isEdit ? 'Edit' : 'Add',
                          pressEvent: () {
                            if (formKey.currentState!.validate()) {
                              if (_isEdit) {
                                context.read<GildedRoseCubit>().editItem(
                                      name: nameController.text,
                                      quality: int.parse(qualityController.text),
                                      sellIn: int.parse(sellInController.text),
                                      index: index,
                                    );
                              } else {
                                context.read<GildedRoseCubit>().addItem(
                                      name: nameController.text,
                                      quality: int.parse(qualityController.text),
                                      sellIn: int.parse(sellInController.text),
                                    );
                              }
                              dialog.dismiss();
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    dialog.show();
  }
}
