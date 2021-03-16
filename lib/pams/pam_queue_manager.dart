import 'package:singh_architecture/pams/types.dart';

class PamQueueManager {
  bool _isProcessing = false;
  List<ITrackingQueue> _trackingQueue =
      List<ITrackingQueue>.empty(growable: true);
  final Future<void> Function(
    String eventName,
    Map<String, dynamic> payload, {
    bool deleteLoginContactAfterPost,
  })? callback;

  PamQueueManager({
    this.callback,
  });

  void enqueue(String eventName,
      {Map<String, dynamic>? payload,
      bool deleteLoginContactAfterPost = false}) {
    Map<String, dynamic> newPayload = {};
    if (payload != null) {
      newPayload = payload;
    }

    this._trackingQueue.add(
          ITrackingQueue(
              eventName: eventName,
              payload: newPayload,
              deleteLoginContactAfterPost: deleteLoginContactAfterPost),
        );
    if (!this._isProcessing) {
      this.nextQueue();
    }
  }

  void nextQueue() {
    if (_trackingQueue.length > 0) {
      _isProcessing = true;
      ITrackingQueue task = _trackingQueue.removeLast();
      this.callback?.call(
            task.eventName,
            task.payload,
            deleteLoginContactAfterPost: task.deleteLoginContactAfterPost,
          );
    } else {
      _isProcessing = false;
    }
  }
}
