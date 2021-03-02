part of 'inventaris_bloc.dart';

abstract class InventarisState extends Equatable {
  const InventarisState();

  @override
  List<Object> get props => [];
}

class InventarisInitial extends InventarisState {}

//data api register / sigup selesai di get
class AddInventarisSuccess extends InventarisState {
  final AddInventarisModel addInventarisModel;
  AddInventarisSuccess({this.addInventarisModel});
}

class AddInventarisLoading extends InventarisState {}

class AddInventarisError extends InventarisState {
  final String error;
  AddInventarisError({this.error});
}
