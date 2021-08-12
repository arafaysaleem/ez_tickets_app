import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/states/future_state.dart';

typedef JSON = Map<String, dynamic>;
typedef QueryParams = Map<String, String>;
typedef StateListener<T> = ProviderListener<StateController<T>>;
typedef FutureStateListener<T> = ProviderListener<StateController<FutureState<T>>>;