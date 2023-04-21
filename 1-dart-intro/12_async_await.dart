void main() async {
  print('Starting app');
  
  try {
    final resp = await httpGet('https://frs.com');
    print(resp);
  } catch (err) {
    print('Error: $err');
  }

  print('Closing app');
}

Future<String> httpGet (String url) async {
  await Future.delayed(Duration(seconds: 1));
  throw 'error in the request';
  // return 'Response of the http request';
}