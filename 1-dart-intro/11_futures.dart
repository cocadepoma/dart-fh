void main() {
  print('Starting app');
  
  print('Closing app');
  httpGet('https://frs.com').then((value) {
    print(value);
  }).catchError((err) {
    print('Error: $err');
  });
}

Future<String> httpGet (String url) {
  
  return Future.delayed(Duration(seconds: 1), () {
    throw 'Error in the request';
    // return 'Response of the http request';
  });
}