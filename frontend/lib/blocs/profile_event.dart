import "package:equatable/equatable.dart";
import "package:frontend/models/studentProfiles.dart";

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchProfiles extends ProfileEvent {}

class CreateProfile extends ProfileEvent {
  final StudentProfile studentProfile;

  const CreateProfile(this.studentProfile);

  @override
  // TODO: implement props
  List<Object?> get props => [studentProfile];
}

class DeleteProfile extends ProfileEvent {
  final String id;
  const DeleteProfile(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class UpdateProfile extends ProfileEvent {
  final String id;
  final StudentProfile studentProfile;
  const UpdateProfile(this.id, this.studentProfile);
  @override
  List<Object> get props => [id, studentProfile];
}
