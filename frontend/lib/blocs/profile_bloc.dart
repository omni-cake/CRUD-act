import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/profile_repo.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileBloc(this._profileRepo) : super(ProfileLoading()) {
    on<FetchProfiles>((event, emit) async {
      try {
        emit(ProfileLoading());
        final studentsProfile = await _profileRepo.fetchProfiles();
        emit(ProfileLoaded(studentsProfile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<CreateProfile>((event, emit) async {
      try {
        await _profileRepo.createProfile(event.studentProfile);
        add(FetchProfiles());
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<DeleteProfile>((event, emit) async {
      try {
        await _profileRepo.deleteProfile(event.id);
        add(FetchProfiles());
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      try {
        await _profileRepo.updateProfile(event.id, event.studentProfile);
        add(FetchProfiles());
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
