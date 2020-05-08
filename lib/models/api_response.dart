class APIResponse<T>{
  T data;
  bool error;
  String eroorMessage;
  APIResponse({this.data,this.error=false,this.eroorMessage=""});

}