// home_state.dart
import 'package:equatable/equatable.dart';
import 'package:finzenz_app/modules/home/model/transaction_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFetched extends HomeState {
  final List<Transaction> transactions;

  const HomeFetched({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
