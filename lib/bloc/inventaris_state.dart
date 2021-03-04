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

//data api register / sigup selesai di get
class GetInventarisSuccess extends InventarisState {
  final GetInventarisModel getInventarisModel;
  GetInventarisSuccess({this.getInventarisModel});
}

class GetInventarisFail extends InventarisState {
  final FailInventarisModel failInventarisModel;
  GetInventarisFail({this.failInventarisModel});
}

class GetInventarisLoading extends InventarisState {}

class GetInventarisError extends InventarisState {
  final String error;
  GetInventarisError({this.error});
}
