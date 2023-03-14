// Mocks generated by Mockito 5.3.2 from annotations
// in code_assesment/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:code_assesment/data/datasources/local_data_source.dart' as _i8;
import 'package:code_assesment/data/helpers/failure.dart' as _i5;
import 'package:code_assesment/data/helpers/local_data_client.dart' as _i9;
import 'package:code_assesment/domain/entities/gilded_rose_model.dart' as _i6;
import 'package:code_assesment/domain/repositories/gilded_rose_repository.dart'
    as _i3;
import 'package:code_assesment/domain/usecases/get_gilded_rose_data.dart'
    as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGildedRoseRepository_1 extends _i1.SmartFake
    implements _i3.GildedRoseRepository {
  _FakeGildedRoseRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GildedRoseRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockGildedRoseRepository extends _i1.Mock
    implements _i3.GildedRoseRepository {
  MockGildedRoseRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.GildedRoseModel>> getGildedRoseData(
          {required String? fileName}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getGildedRoseData,
          [],
          {#fileName: fileName},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.GildedRoseModel>>.value(
                _FakeEither_0<_i5.Failure, _i6.GildedRoseModel>(
          this,
          Invocation.method(
            #getGildedRoseData,
            [],
            {#fileName: fileName},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.GildedRoseModel>>);
}

/// A class which mocks [GetGildedRoseData].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetGildedRoseData extends _i1.Mock implements _i7.GetGildedRoseData {
  MockGetGildedRoseData() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.GildedRoseRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeGildedRoseRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.GildedRoseRepository);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.GildedRoseModel>> execute(
          {required String? fileName}) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#fileName: fileName},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.GildedRoseModel>>.value(
                _FakeEither_0<_i5.Failure, _i6.GildedRoseModel>(
          this,
          Invocation.method(
            #execute,
            [],
            {#fileName: fileName},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.GildedRoseModel>>);
}

/// A class which mocks [LocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock implements _i8.LocalDataSource {
  MockLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> get({required String? fileName}) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
          {#fileName: fileName},
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
}

/// A class which mocks [LocalDataClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataClient extends _i1.Mock implements _i9.LocalDataClient {
  MockLocalDataClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> get({required String? fileName}) => (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
          {#fileName: fileName},
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
}
