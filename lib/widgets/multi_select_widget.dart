import 'package:b2b/Model/businessCategoruModel.dart';
import 'package:b2b/color.dart';
import 'package:flutter/material.dart';

List <String>_selectedUserItems = [];


class MultiSelect extends StatefulWidget {
  final List <SellerTypeData>? sellerList ;
  // required this.type
  MultiSelect({Key? key, this.sellerList }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}
class _MultiSelectState extends State<MultiSelect> {



  void _itemChange(SellerTypeData itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        setState(() {
          _selectedUserItems.add(itemValue.name ?? '');
        });
      } else {
        setState(() {
          _selectedUserItems.remove(itemValue.name ?? '');
        });
      }
    });
    print("this is selected values ${_selectedUserItems.toString()}");
  }
  void _cancel() {
    Navigator.pop(context);
  }
  /*void _submit() {
    List selectedItem = _selectedItems2.map((item) => item).toList();
    //Navigator.pop(context);
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_selectedItems2.clear();
  }
  String finalList = '';

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState)
        {
          return
            AlertDialog(
              title: const Text('Select User'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: widget.sellerList!
                      .map((SellerTypeData data) =>
                      CheckboxListTile(
                        activeColor: colors.primary,
                        value: _selectedUserItems.contains(data.name),
                        title: Text(data.name ?? ''),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) => _itemChange(data, isChecked!),

                      )
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: _cancel,
                  child: const Text('Cancel',
                    style: TextStyle(color: colors.primary),),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: colors.primary
                    ),
                    child: const Text('Submit'),
                    onPressed: () {
                      //_submit();

                      Navigator.pop(context, _selectedUserItems);

                    }
                ),
              ],
            );
        }
    );
  }

}