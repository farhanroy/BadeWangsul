import 'package:get/get.dart';

import 'auth_service.dart';
import 'auth_state.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService _authenticationService;
  final _authenticationStateStream = AuthenticationState().obs;

  AuthenticationState get state => _authenticationStateStream.value;

  AuthenticationController(this._authenticationService);

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }

  Future<void> signUp(String userName, String email, String password) async {
    final user = await _authenticationService.createUserWithEmailAndPassword(userName, email, password);
    _authenticationStateStream.value = Authenticated(user: user);
  }

  Future<void> signIn(String email, String password) async {
    final user = await _authenticationService.signInWithEmailAndPassword(email, password);
    _authenticationStateStream.value = Authenticated(user: user);
  }

  void signOut() async {
    await _authenticationService.signOut();
    _authenticationStateStream.value = UnAuthenticated();
  }

  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = await _authenticationService.getCurrentUser();

    if (user == null) {
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated(user: user);
    }
  }
}