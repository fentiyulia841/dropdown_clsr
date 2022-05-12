import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dropdwon_clsr/models/user_model.dart';
import 'package:dropdwon_clsr/resources/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

// import model class, repository class
// put all logics here
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final UserRepository _userRepository = UserRepository();

    // event/input from wilayah_event
    on<GetUserList>((event, emit) async {
      try {
        emit(UserLoading());
        final mList = await _userRepository.fetchUserList();
        emit(UserLoaded(mList));
        if (mList.error != null) {
          emit(UserError(mList.error));
        }
      } on UserError {
        emit(UserError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
