import 'dart:async';

import 'package:singh_architecture/repositories/base_repository.dart';

abstract class BasePageRepository extends BaseUIRepository {
  StreamController<int> get pageIndexSC;

  StreamController<int> get pageSizeSC;

  void initial({Function? callback});

  void setPageSize(int size);

  void jumpTo(int index);

  void nextPage();

  void prevPage();

  void notifyValueChange();

  void dispose();
}

class PageRepository extends BasePageRepository {
  int _pageIndex = 0;
  int _pageSize = 0;

  late StreamController<int> _pageIndexSC;
  late StreamController<int> _pageSizeSC;

  int get currentPage => this._pageIndex;

  int get pageSize => this._pageSize;

  StreamController<int> get pageIndexSC => this._pageIndexSC;

  StreamController<int> get pageSizeSC => this._pageSizeSC;

  @override
  void initial({Function? callback}) {
    this._pageIndex = 0;
    this._pageIndexSC = StreamController<int>.broadcast();
    this._pageSizeSC = StreamController<int>.broadcast();

    this.notifyValueChange();
    callback?.call();
  }

  @override
  void setPageSize(int size) {
    this._pageSize = size;
    this.notifyValueChange();
  }

  @override
  void jumpTo(int index) {
    this._pageIndex = index;
    this.notifyValueChange();
  }

  @override
  void nextPage() {
    this._pageIndex++;
    this.notifyValueChange();
  }

  @override
  void prevPage() {
    this._pageIndex--;
    this.notifyValueChange();
  }

  @override
  void notifyValueChange() {
    this._pageIndexSC.add(this._pageIndex);
    this._pageSizeSC.add(this._pageSize);
  }

  @override
  void dispose() {
    super.dispose();

    this._pageIndexSC.close();
    this._pageSizeSC.close();
  }
}
