import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../repo/user_model.dart';

@immutable
abstract class HomePageState extends Equatable {}

class HomePageLoadingState extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomePageState {
  final List<UserModel> users;
  HomeSuccessState(this.users);
  @override
  List<Object?> get props => [users];
}

class HomePageErrorState extends HomePageState {
  final String error;
  HomePageErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
