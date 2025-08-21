import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class IncrementQuantity extends CartEvent {
  final int index;

  const IncrementQuantity(this.index);

  @override
  List<Object> get props => [index];
}

class DecrementQuantity extends CartEvent {
  final int index;

  const DecrementQuantity(this.index);

  @override
  List<Object> get props => [index];
}

class ToggleSelection extends CartEvent {
  final int index;
  
  const ToggleSelection(this.index);

  @override
  List<Object> get props => [index];
}

class RemoveFromCart extends CartEvent {
  final int index;

  const RemoveFromCart(this.index);

  @override
  List<Object> get props => [index];
}