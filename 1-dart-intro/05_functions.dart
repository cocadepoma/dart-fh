void main() { 
  print(greetEveryone());
  
  print('Suma: ${addTwoNumbers(10, 20)}');
  
  print(greetPerson(name: 'Paco', message: 'Yepaa'));
}

String greetEveryone(){
  return 'Hello everyone';
}

String greetEvery() => 'Hello Every';

int addTwoNumbers(int a, int b) => a + b;

int addTwoNumbersOptional(int a, [int b = 0]) {
  return a + b;
}

String greetPerson({required String name, String? message = 'Hola'}) {
  
  return '$message $name';
}