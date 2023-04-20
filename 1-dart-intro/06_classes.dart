void main() { 
  // final Hero wolverine = Hero('Logan', 'Regeneration');
  final Hero wolverine = Hero(name: 'Logan', power: 'Regeneration');

  print(wolverine);
  print(wolverine.name);
  print(wolverine.power);
  
}

class Hero {
  String name;
  String power;
  
  // Hero(String pName, String pPower)
    // : name = pName,
     // power = pPower;
  
  // Hero(this.name, this.power);
  Hero({required this.name, required this.power});

  @override
  String toString() {
    return 'Name: $name - Power: $power';
  }
}