

import 'package:flutter/material.dart';
import 'package:item_tracker/model/item_model.dart';
import 'package:item_tracker/utils/screen_utils.dart';
import 'package:item_tracker/view_model/item_form_widget.dart';
import 'package:item_tracker/view_model/item_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  // Size mcSize = Size();
  // bool isDesktop = false;
  // @override
  // void initState() {
  //   mcSize = MediaQuery.of(context).size;
  //   isDesktop = (mcSize?.width ?? 0) >=600;
  //   super.initState();
  // }



  @override
  Widget build(BuildContext context) {
    //final mcUserViewModelProvider = Provider.of<ItemViewModelProvider>(context);
    //bool isMobile() => mcSize?.width <600;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        isDesktop ()=> (constraints.maxWidth) >= 600;
        return Scaffold(resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title:const Text('Item Tracker'),
          ),
          body: Consumer<ItemViewModelProvider>(builder: (BuildContext context, mcUserViewModelProviderWatch, Widget? child) {
             return SizedBox(
                height: ScreenUtils.height * 0.95,
                width:  ScreenUtils.width * 0.95,
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,children: [
                  if(isDesktop())
                    Container(width: ScreenUtils.width * 0.25, height: ScreenUtils.height,color: Colors.yellow.shade300,
                      child: ItemFormWidget(isDesktop: isDesktop(),),),
                    Flexible(child: Container(
                    // width: ScreenUtils.width * 0.75,
                    //color: Colors.black12,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: mcUserViewModelProviderWatch.mcItemListModel.length,
                        itemBuilder: (BuildContext context,index){
                          ItemModel lcItemModel = mcUserViewModelProviderWatch.mcItemListModel[index];
                          GlobalKey globalKey = GlobalKey();
                          return
                            Container(
                              key: globalKey,
                              //width: ScreenUtils.width * 0.7,
                              //height: ScreenUtils.height * 0.1,
                              margin: const EdgeInsets.all(
                                  8.0), // just to make the contianer stand out, you can remove it
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((index+1).toString()),
                                  SizedBox(width: 15),
                                  Expanded(
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(lcItemModel.name ?? ""),
                                            Text(lcItemModel.description ?? ""),
                                          ])),
                                  SizedBox(width: 10),
                                  IconButton(onPressed: (){
                                    mcUserViewModelProviderWatch.editActionTypeFunction(lcItemModel);
                                    mcUserViewModelProviderWatch.isSetActionType(false);
                                    if(!isDesktop())
                                    oepnModelBottomShit(context,isDesktop());
                                  },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(onPressed: (){
                                    mcUserViewModelProviderWatch.removeItemFromList(lcItemModel.uid ?? "");
                                  },
                                      icon: const Icon(Icons.delete_forever)),
                                  IconButton(onPressed: (){
                                   calculateSizeAndPosition(globalKey);
                                  },
                                      icon: const Icon(Icons.info))
                                ],
                              ),
                            );
                        }),
                  ))
                ],),
            );
          },
          ),
          floatingActionButton:
          (!isDesktop()) ?
          FloatingActionButton(
            onPressed: (){
              oepnModelBottomShit(context,isDesktop());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ) : null,
        );
      },

    );
  }

  oepnModelBottomShit(context, bool isDesktop){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
         return SingleChildScrollView(child: ItemFormWidget(isDesktop: isDesktop));
    });
  }

  calculateSizeAndPosition(GlobalKey globalKey) {
    RenderBox renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
    final height = renderBox.size.height;
    final width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Widget info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Height : $height"),
          Text("Width : $width"),
          Text("Dx : ${offset.dx}"),
          Text("Dy : ${offset.dy}"),
        ],),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("OK"),
            ),
          ),
        ],
      ),
    );
   // print(height);
    // setState(() {
    //   offset = renderBox.localToGlobal(Offset.zero);
    //   size = renderBox.size;
    //
    //   _isCallBackExecuted = true;
    // });

  }
}
