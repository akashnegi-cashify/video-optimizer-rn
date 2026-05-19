extension Op<T> on Stream<T> {
  doAsyncOp(Function(T value) onValue, Function(bool loading) onLoading, Function(dynamic e, dynamic s) handleError) {
    onLoading(true);
    listen((value) {
      onLoading(false);
      onValue(value);
    }, onError: (e, s) {
      onLoading(false);
      handleError(e, s);
    });
  }
}
