mixin class SelectableListProvider<T>{

  bool isSelectItemOpened = false;
  final List<T> selectedItems = [];
  bool get isOneItemSelected => selectedItems.length == 1;
  

  void openCloseSelectItem({T? id }) {
    isSelectItemOpened = !isSelectItemOpened;
    if(!isSelectItemOpened){
      selectedItems.clear();
    }
    if(id != null){
      selectedItems.add(id);
    }
  }

  void selectItem({ required T id}){
    if(selectedItems.contains(id)){
      selectedItems.removeWhere((element) => element == id);
    }else{
      selectedItems.add(id);
    }
  }

}