import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/failures/failure.dart';

part 'base_state.freezed.dart';

/// Authentication states
@freezed
class BaseState<T> with _$BaseState<T> {
  /// Auth initial state
  const factory BaseState.initial() = BaseInitial;

  /// Auth loading state
  const factory BaseState.loading() = BaseLoading;

  /// Auth error state
  const factory BaseState.error(Failure failure) = BaseError;

  /// Auth success state
  /// Sometime we need to return success state with failure
  /// E.g, pagination.
  /// If failure occured when paginating we dont want to change
  /// previous state.
  const factory BaseState.success({T? data, Failure? failure}) = BaseSuccess<T>;
}

/// BaseNotifier will handle unwanted value changes
abstract class BaseNotifier<T> extends StateNotifier<BaseState<T>> {
  BaseNotifier({
    BaseState<T> state = const BaseState.initial(),
  }) : super(state);

  @override
  set state(BaseState<T> value) {
    if (value is BaseError &&
        (value as BaseError).failure.type == FailureType.cancel) {
      return;
    }
    super.state = value;
  }
}

///
extension ContextExtForBaseState on BuildContext {
  void showErrorSnackBar(BaseError error) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(error.failure.reason)),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
