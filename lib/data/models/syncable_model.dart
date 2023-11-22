abstract class SyncableModel{
  final int isRemoved;
  final int isSync;

  SyncableModel({
    this.isRemoved = 0, 
    this.isSync = 0,
  });

  bool get isRemovedAsBool => isRemoved == 1;
  bool get isSyncAsBool => isSync == 1;
}