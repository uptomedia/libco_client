part of 'transfer_info_cubit.dart';

@immutable
abstract class TransferInfoState extends Equatable  {
  const TransferInfoState();
}

class TransferInfoInitial extends TransferInfoState {
  @override
  List<Object> get props => [];
}

class TransferInfoLoading extends TransferInfoState {
  @override
  List<Object> get props => [];
}

class TransferInfoLoaded extends TransferInfoState {


   final List<TransferInfoEntity> tranferList;
   TransferInfoLoaded({required this.tranferList});
   @override
   List<Object> get props => [tranferList];
}
class AddNewTransferInfoLoaded extends TransferInfoState {
  AddNewTransferInfoLoaded();
  @override
  List<Object> get props => [ ];


}

class TransferInfoFailure extends TransferInfoState {
  @override
  List<Object> get props => [];
}
