import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

abstract class IContext {
  IRepositories repositories();
}

class Context implements IContext {
  final IConfig config;
  IRepositories? _repositories;

  Context({
    required this.config,
  });

  @override
  IRepositories repositories() {
    if (this._repositories == null) {
      this._repositories = NewRepository(
        config: config,
      );
    }
    return this._repositories!;
  }
}
