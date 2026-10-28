import 'dart:async';

import 'package:root101/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The open project of the projects section. It moves to the next one every
/// [rotateEvery] until the visitor picks one; from then on it stays
class ProjectCubit extends Cubit<ProjectState> {
  final Duration rotateEvery;
  Timer? _timer;

  ProjectCubit({
    required List<ProjectModel> projects,
    this.rotateEvery = const Duration(seconds: 7),
  }) : super(ProjectState(projects: projects, active: 0, auto: true)) {
    if (projects.length > 1) {
      _timer = Timer.periodic(rotateEvery, (_) => _advance());
    }
  }

  void _advance() => emit(state._copy(active: _wrap(state.active + 1)));

  void pick(int index) {
    _timer?.cancel();
    emit(state._copy(active: _wrap(index), auto: false));
  }

  void next() => pick(state.active + 1);

  void previous() => pick(state.active - 1);

  int _wrap(int index) => index % state.projects.length;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

class ProjectState {
  final List<ProjectModel> projects;
  final int active;

  /// Still rotating on its own: the open tab shows how long until the next
  final bool auto;

  const ProjectState({
    required this.projects,
    required this.active,
    required this.auto,
  });

  ProjectModel get current => projects[active];

  ProjectState _copy({int? active, bool? auto}) => ProjectState(
    projects: projects,
    active: active ?? this.active,
    auto: auto ?? this.auto,
  );
}
