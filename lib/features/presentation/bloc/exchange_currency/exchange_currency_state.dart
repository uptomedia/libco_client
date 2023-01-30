part of 'exchange_currency_cubit.dart';

@immutable
abstract class ExchangeCurrencyState extends Equatable  {
const ExchangeCurrencyState();
}

 class ExchangeCurrencyInitial extends ExchangeCurrencyState {
  @override
  List<Object> get props => [];
}

class ExchangeCurrencyLoading extends ExchangeCurrencyState {
  @override
  List<Object> get props => [];
}
class ExchangeCurrencyLoaded extends ExchangeCurrencyState {
  final List<ExchangeCurrencyEntity>  exchangeCurrencyModel;
  ExchangeCurrencyLoaded({required this.exchangeCurrencyModel});
  @override
  List<Object> get props => [exchangeCurrencyModel];


}

class ExchangeCurrencyFailure extends ExchangeCurrencyState {
  @override
  List<Object> get props => [];
}
class AddExchangeCurrencyLoaded extends ExchangeCurrencyState {
  final ExchangeCurrencyEntity exchangeCurrencyModel;
  AddExchangeCurrencyLoaded({required this.exchangeCurrencyModel});
  @override
  List<Object> get props => [exchangeCurrencyModel];


}

