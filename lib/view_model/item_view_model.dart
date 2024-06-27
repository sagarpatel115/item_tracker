
import 'package:flutter/material.dart';
import 'package:item_tracker/model/item_model.dart';

class ItemViewModelProvider extends ChangeNotifier{

  final List<ItemModel> _mcItemListModel = [ItemModel(uid: "1",name: 'item 1',description: "item one description",)];

  List<ItemModel> get mcItemListModel => _mcItemListModel;
  ItemModel? _editItemModel;
  ItemModel? get editItemModel => _editItemModel;

  bool _isActionType = true;
  bool get isActionType => _isActionType;

  void isSetActionType(bool value) {
    _isActionType = value;
    notifyListeners();
  }

  addItemIntoList(ItemModel lcItem){
    _mcItemListModel.add(lcItem);
    notifyListeners();
  }

  editItemIntoList(ItemModel lcItem){
    ItemModel lcItemModel =_mcItemListModel.firstWhere((element) => element.uid == lcItem.uid);
    lcItemModel.name = lcItem.name;
    lcItemModel.description = lcItem.description;
    notifyListeners();
  }

  removeItemFromList(String lcId){
    _mcItemListModel.removeWhere((element) => element.uid == lcId);
    notifyListeners();
  }

  editActionTypeFunction(ItemModel lcItem){
    _editItemModel = lcItem;
    notifyListeners();
  }

  clearEditForm(){
    isSetActionType(true);
    _editItemModel=null;
  }


}