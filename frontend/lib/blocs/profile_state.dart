import "package:equatable/equatable.dart";
import "package:frontend/models/studentProfiles.dart";

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<StudentProfile> studentProfile;
  const ProfileLoaded(this.studentProfile);
  @override
  // TODO: implement props
  List<Object?> get props => [studentProfile];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
