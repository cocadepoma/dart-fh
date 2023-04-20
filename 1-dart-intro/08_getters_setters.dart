void main() {
  final mySquare = Square(side: 3);
  
  mySquare.side = 20;
  print('área: ${mySquare.area}');

}
class Square {
 
  double _side;
  Square({required double side})
    : assert(side > 0, 'Side must be greater than 0'),
      _side = side;
  
  set side(double value) {
    if(value < 0) throw 'Value must be greater than 0';
    
    _side = value;
  }
  
  double get area {
    return _side * _side;  
  }
  
  double calculateArea() {
    return _side * _side;
  }
}