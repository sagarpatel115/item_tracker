


import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/model/item_model.dart';
import 'package:item_tracker/view_model/item_view_model.dart';

void main() {
  test('Add Item Test Case', () {


    ItemViewModelProvider itemViewModelProvider = ItemViewModelProvider();
    ItemModel lcItem = ItemModel(uid: "1",name: 'item 1 name',description: "item 1 description");
    itemViewModelProvider.addItemIntoList(lcItem);

    expect(itemViewModelProvider.mcItemListModel.contains(lcItem), true);
    expect(itemViewModelProvider.mcItemListModel.any((element) => element.uid == lcItem.uid), true);
    expect(itemViewModelProvider.mcItemListModel[1].name == "second item", true);
    //expect(itemViewModelProvider.mcItemListModel.contains(lcItem), false);

  });
}