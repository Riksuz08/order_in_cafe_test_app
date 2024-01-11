import 'package:hive/hive.dart';
import '../models/cart.dart'; // Import the Cart class

class CartAdapter extends TypeAdapter<Cart> {
  @override
  final typeId = 1; // Unique identifier for the Cart class

  @override
  Cart read(BinaryReader reader) {
    // Implement how to read a Cart object from binary
    return Cart(
      // Deserialize the object
      name: reader.read(),
      price: reader.read(),
      imagePath: reader.read(),
      rating: reader.read(),
      quantity: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Cart obj) {
    // Implement how to write a Cart object to binary
    writer.write(obj.name);
    writer.write(obj.price);
    writer.write(obj.imagePath);
    writer.write(obj.rating);
    writer.write(obj.quantity);
  }
}
