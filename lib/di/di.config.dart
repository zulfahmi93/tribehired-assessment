// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/comment_client.dart' as _i6;
import '../api/http.dart' as _i3;
import '../api/post_client.dart' as _i4;
import '../api/user_client.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.HttpClient>(_i3.HttpClient(), dispose: (i) => i.dispose());
  gh.factory<_i4.PostsApiClient>(
      () => _i4.PostsApiClient(client: get<_i3.HttpClient>()));
  gh.factory<_i5.UsersApiClient>(
      () => _i5.UsersApiClient(client: get<_i3.HttpClient>()));
  gh.factory<_i6.CommentsApiClient>(
      () => _i6.CommentsApiClient(client: get<_i3.HttpClient>()));
  return get;
}
