import 'dart:isolate';

class _IsolateMessage<T, P> {
  final T Function(P param) task; //hàm cần thực thi
  final P param; //dữ liệu cần sử lý
  final SendPort sendPort; //cổng gửi để isolate gửi kết quả về

  _IsolateMessage({
    required this.task,
    required this.param,
    required this.sendPort,
  });
}

class IsolateHelper {
  //Trong run() T là kiểu trả về của hàm, P là kiểu tham số truyền vào
  static Future<T> run<T, P>(T Function(P parama) task, P param) async {
    final receiverPort = ReceivePort();
    //Chạy isolate và truyền một object _JsolateMassage vào
    await Isolate.spawn<_IsolateMessage<T, P>>(
      _isolateEntry<T, P>,
      _IsolateMessage<T, P>(
        task: task,
        param: param,
        sendPort: receiverPort.sendPort,
      ),
    );

    final result = await receiverPort.first as T;
    receiverPort.close();
    return result;
  }

  static void _isolateEntry<T, P>(_IsolateMessage<T, P> message) {
    final result = message.task(message.param);
    message.sendPort.send(result);
  }
}