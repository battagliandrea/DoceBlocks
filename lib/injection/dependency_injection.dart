import 'package:doce_blocks/firebase/firebase_datasource.dart';
import 'package:flutter/widgets.dart';
import 'package:doce_blocks/data/repositories.dart';

enum Flavor { DEVEL }

class Injector {
  static final Injector _singleton = new Injector._internal();

  static BuildContext _context;
  static Flavor _flavor;

  static void configure(BuildContext context, Flavor flavor) {
    _context = context;
    _flavor = flavor;
  }

  static Flavor getFlavor() {
    return _flavor;
  }

  static BuildContext getContext() {
    return _context;
  }

  factory Injector() {
    return _singleton;
  }

  static UserRepository provideUserRepository() {
    //TODO: create a static to instance the datasource???
    return new UserRepositoryImpl(new FirebaseDataSource());
  }

  Injector._internal();
}