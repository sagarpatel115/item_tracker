import 'package:flutter/material.dart';
import 'package:item_tracker/model/item_model.dart';
import 'package:item_tracker/view_model/item_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ItemFormWidget extends StatefulWidget {
  bool isDesktop;

  ItemFormWidget({super.key,required this.isDesktop});

  @override
  State<ItemFormWidget> createState() => _ItemFormWidgetState();
}


class _ItemFormWidgetState extends State<ItemFormWidget> {
  TextEditingController mcNameController = TextEditingController();
  TextEditingController mcDescriptionController = TextEditingController();
  bool isActionTypeIsAdd=true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25,left: 20,right: 20),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Consumer<ItemViewModelProvider>(
        builder: (BuildContext context, value, Widget? child) {
          if(value.editItemModel != null && !(value.isActionType)){
            isActionTypeIsAdd = value.isActionType;
            mcNameController.text = value.editItemModel?.name ?? "";
            mcDescriptionController.text = value.editItemModel?.description ?? "";
          }else{
            isActionTypeIsAdd = true;
            mcNameController.clear();
            mcDescriptionController.clear();
          }
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${isActionTypeIsAdd ? "Add" : "Edit"} Item Details"),
                const SizedBox(height: 20 ,),
                TextFormField(
                  key: const ValueKey('NameKey'),
                  controller: mcNameController,
                  decoration: InputDecoration(
                    label: const Text('Name'),
                    hintText: 'Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter name';
                    }
                    return null;
                  },
                ),
               const SizedBox(height: 15,),
                TextFormField(
                  key: const ValueKey('DescriptionKey'),
                  controller: mcDescriptionController,
                  decoration: InputDecoration(
                    label: const Text('Description'),
                    hintText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){

                      final isValid = _formKey.currentState?.validate();
                      if (!isValid!) {
                        return;
                      }
                      _formKey.currentState?.save();
                      if(isActionTypeIsAdd){
                        var uuid = const Uuid();
                        var lcItemModel = ItemModel(
                          uid:uuid.v1(),
                          name:mcNameController.text,
                          description:mcDescriptionController.text,
                        );
                        context.read<ItemViewModelProvider>().addItemIntoList(lcItemModel);
                      }
                      else{
                        var lcItemModel = ItemModel(
                          uid:value.editItemModel?.uid,
                          name:mcNameController.text,
                          description:mcDescriptionController.text,
                        );
                        value.editItemIntoList(lcItemModel);
                        value.clearEditForm();
                      }
                      if(!widget.isDesktop) {
                        Navigator.of(context).pop();
                      }
                    },
                        child: Text(isActionTypeIsAdd ? "Add" : "Edit")),
                    if(!isActionTypeIsAdd)
                      const Spacer(),
                    if(!isActionTypeIsAdd)
                      ElevatedButton(onPressed: (){
                        value.clearEditForm();
                        if(!widget.isDesktop) {
                          Navigator.of(context).pop();
                        }
                      },
                          child: const Text("Clear"))
                  ],
                ),
                const SizedBox(height: 20 ,),

              ],
            ),
          );
        },),
    );
  }
}
