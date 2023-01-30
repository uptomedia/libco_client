part of 'currency_rate_cubit.dart';

@immutable
abstract class CurrencyRateState extends Equatable  {
const CurrencyRateState();
}

 class CurrencyRateInitial extends CurrencyRateState {
  @override
  List<Object> get props => [];
}

class CurrencyRateLoading extends CurrencyRateState {
  @override
  List<Object> get props => [];
}
class CurrencyRateLoaded extends CurrencyRateState {
  final CurrencyRateEntity currencyRateModel;
  CurrencyRateLoaded({required this.currencyRateModel});
  @override
  List<Object> get props => [currencyRateModel];


}

class CurrencyRateFailure extends CurrencyRateState {
  @override
  List<Object> get props => [];
}
