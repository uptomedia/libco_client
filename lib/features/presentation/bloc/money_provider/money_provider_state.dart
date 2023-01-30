part of 'money_provider_cubit.dart';

@immutable


abstract class MoneyProviderState extends Equatable {
  const MoneyProviderState();
}

class MoneyProviderInitial extends MoneyProviderState {
  @override
  List<Object> get props => [];
}

class MoneyProviderLoading extends MoneyProviderState {
  @override
  List<Object> get props => [];
}
class AddMoneyProviderLoaded extends MoneyProviderState {
  @override
  List<Object> get props => [];
}
class UpdateProviderLoaded extends MoneyProviderState {
  final List<CountrysRatesModel> countryList;
  UpdateProviderLoaded({required this.countryList});
  @override
  List<Object> get props => [countryList];


}

class MoneyProviderFailure extends MoneyProviderState {
  @override
  List<Object> get props => [];
}

class MoneyProviderLoaded extends MoneyProviderState {
  final List<ProviderEntity> notes;

  MoneyProviderLoaded({required this.notes});
  @override
  List<Object> get props => [notes];
}
class AddCountryRateLoaded extends MoneyProviderState {
  @override
  List<Object> get props => [];
}
class UpdateCountryRateLoaded extends MoneyProviderState {
  @override
  List<Object> get props => [];}
class DeleteCountryRateLoaded extends MoneyProviderState {
  @override
  List<Object> get props => [];}