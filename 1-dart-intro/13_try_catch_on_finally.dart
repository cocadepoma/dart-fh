void main() async {
  print('Starting app');
  
  try {
    final resp = await httpGet('https://frs.com');
    print('Success $resp');
  } on Exception catch(err) {
    print('We had an exception $err');
  } catch (err) {
    print('Error: $err');
  } finally {
    print('End of try catch');
  }

  print('Closing app');
}

Future<String> httpGet (String url) async {
  await Future.delayed(Duration(seconds: 1));
  throw Exception('No parameters in the URL');
  // throw 'error in the request';
  // return 'Response of the http request';
}