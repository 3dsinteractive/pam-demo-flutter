import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/repositories/product_repository.dart';

abstract class IRepositories {
  ProductRepository productRepository(IConfig config);
}
