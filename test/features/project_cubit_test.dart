import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:root101/app_exporter.dart';

ProjectModel _project(String slug) => ProjectModel(
  slug: slug,
  name: slug,
  kind: 'app',
  tagline: slug,
  description: const LocalizedText.same(''),
  tags: const [],
  logo: const SvgAsset('logo.svg'),
  windowTitle: const LocalizedText.same(''),
  preview: (_) => const SizedBox(),
);

void main() {
  final projects = [_project('a'), _project('b'), _project('c')];
  const every = Duration(milliseconds: 20);

  group('ProjectCubit', () {
    blocTest<ProjectCubit, ProjectState>(
      'Rotates on its own, back to the first after the last',
      build: () => ProjectCubit(projects: projects, rotateEvery: every),
      wait: const Duration(milliseconds: 70),
      expect: () => [
        isA<ProjectState>().having((s) => s.active, 'active', 1),
        isA<ProjectState>().having((s) => s.active, 'active', 2),
        isA<ProjectState>().having((s) => s.active, 'active', 0),
      ],
    );

    blocTest<ProjectCubit, ProjectState>(
      'Picking one stops the rotation',
      build: () => ProjectCubit(projects: projects, rotateEvery: every),
      act: (cubit) => cubit.pick(2),
      wait: const Duration(milliseconds: 70),
      expect: () => [
        isA<ProjectState>()
            .having((s) => s.active, 'active', 2)
            .having((s) => s.auto, 'auto', false),
      ],
    );

    blocTest<ProjectCubit, ProjectState>(
      'Previous and next wrap around',
      build: () => ProjectCubit(projects: projects),
      act: (cubit) => cubit
        ..previous()
        ..next()
        ..next(),
      expect: () => [
        isA<ProjectState>().having((s) => s.active, 'active', 2),
        isA<ProjectState>().having((s) => s.active, 'active', 0),
        isA<ProjectState>().having((s) => s.active, 'active', 1),
      ],
    );
  });
}
