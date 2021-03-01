part of 'inventaris_bloc.dart';

abstract class InventarisState extends Equatable {
  const InventarisState();
  
  @override
  List<Object> get props => [];
}

class InventarisInitial extends InventarisState {}
