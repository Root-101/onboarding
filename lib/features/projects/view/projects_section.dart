import 'dart:math' as math;

import 'package:root101/app_exporter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// "02 · Projects": a tab per project on the left, the open one's screen in a
/// window on the right. It rotates every 7 s until the visitor picks one
class ProjectsSection extends StatelessWidget {
  /// The window: its bar (49) and the screen (540), inside a 1 px border
  static const double previewHeight = 540;
  static const double _height = previewHeight + 49 + 2;

  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final intl = context.intl.projects;
    final chevron = app.assets.icons.actions.chevron;
    final iconColor = app.colors.text.primary;
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        final total = state.projects.length;
        String two(int n) => n.toString().padLeft(2, '0');
        if (context.isCompact) return _CompactProjects(state: state);
        return PageColumn(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 40,
            children: [
              SectionHeading(
                overline: intl.overline,
                title: intl.title,
                trailing: Row(
                  spacing: 10,
                  children: [
                    AppIconButton(
                      tooltip: intl.previous,
                      onPressed: cubit.previous,
                      icon: Transform.rotate(
                        angle: math.pi,
                        child: chevron.build(size: 18, color: iconColor),
                      ),
                    ),
                    SizedBox(
                      width: 64,
                      child: Text(
                        '${two(state.active + 1)} / ${two(total)}',
                        textAlign: TextAlign.center,
                        style: AppText.meta.copyWith(fontSize: 13),
                      ),
                    ),
                    AppIconButton(
                      tooltip: intl.next,
                      onPressed: cubit.next,
                      icon: chevron.build(size: 18, color: iconColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 24,
                  children: [
                    SizedBox(
                      width: 320,
                      child: Semantics(
                        label: intl.pick,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 10,
                          children: [
                            for (var i = 0; i < total; i++)
                              if (i == state.active)
                                Expanded(
                                  child: _ProjectTab(
                                    index: i,
                                    project: state.projects[i],
                                    open: true,
                                    progress: state.auto
                                        ? cubit.rotateEvery
                                        : null,
                                    onPick: () => cubit.pick(i),
                                  ),
                                )
                              else
                                _ProjectTab(
                                  index: i,
                                  project: state.projects[i],
                                  open: false,
                                  onPick: () => cubit.pick(i),
                                ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _ProjectWindow(
                        project: state.current,
                        index: state.active,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A project in the list: its number, name and kind; open, also its
/// description, tags and links
class _ProjectTab extends StatelessWidget {
  final int index;
  final ProjectModel project;
  final bool open;

  /// While it rotates on its own: the time left, as a bar at the bottom
  final Duration? progress;
  final VoidCallback onPick;

  /// On a phone: smaller, and as tall as its content
  final bool compact;

  const _ProjectTab({
    required this.index,
    required this.project,
    required this.open,
    required this.onPick,
    this.progress,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final radius = compact
        ? BorderRadius.circular(14)
        : app.dimensions.radius.l;
    return HoverBuilder(
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: open ? colors.surface.selected : colors.surface.plateFaint,
          borderRadius: radius,
          border: Border.all(
            color: hovered
                ? colors.surface.strokeHover
                : open
                ? colors.brand.indigo
                : colors.surface.stroke,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  button: true,
                  selected: open,
                  child: AppLink(
                    onPressed: onPick,
                    builder: (context, _) => Padding(
                      padding: compact
                          ? const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            )
                          : const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                      child: Row(
                        spacing: compact ? 12 : 14,
                        children: [
                          Text(
                            (index + 1).toString().padLeft(2, '0'),
                            style: AppText.meta.copyWith(
                              color: open
                                  ? colors.brand.signal
                                  : colors.text.secondary,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              project.name,
                              style: compact
                                  ? AppText.cardTitle.copyWith(
                                      fontSize: 19,
                                      letterSpacing: AppText.em(-0.02, 19),
                                    )
                                  : AppText.cardTitle,
                            ),
                          ),
                          Text(project.kind, style: AppText.meta),
                        ],
                      ),
                    ),
                  ),
                ),
                if (open && compact)
                  _CompactDetails(project: project)
                else if (open)
                  Expanded(child: _Details(project: project)),
              ],
            ),
            if (progress case final duration?)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 2,
                child: TweenAnimationBuilder<double>(
                  // a new bar for each project
                  key: ValueKey(index),
                  duration: duration,
                  tween: Tween(begin: 0, end: 1),
                  builder: (context, t, _) => FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: t,
                    child: ColoredBox(color: colors.brand.signal),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  final ProjectModel project;

  const _Details({required this.project});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final hasFooter = project.links.isNotEmpty || project.buttons.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // 10, not 12: Feather IO's two links stacked fill the tab to the pixel
        spacing: 10,
        children: [
          Text(
            project.description.of(context),
            style: AppText.body.copyWith(color: colors.text.soft),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final tag in project.tags) AppTag(label: tag.of(context)),
            ],
          ),
          const Spacer(),
          if (hasFooter)
            Container(
              padding: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: colors.surface.stroke)),
              ),
              child: Wrap(
                spacing: 18,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (project.buttons.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8,
                        children: [
                          for (final button in project.buttons)
                            AppButton(
                              label: button.label.of(context),
                              url: button.url,
                              icon: button.icon,
                              expand: true,
                              height: 42,
                              gap: 10,
                              fontSize: 14,
                              padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                              borderRadius: BorderRadius.circular(10),
                              background: button.primary
                                  ? colors.brand.indigo
                                  : colors.surface.plate,
                              borderColor: button.primary
                                  ? colors.brand.indigo
                                  : colors.surface.strokeStrong,
                              foreground: colors.text.primary,
                            ),
                        ],
                      ),
                    ),
                  for (final link in project.links)
                    AppTextLink(label: link.label, url: link.url, fontSize: 14),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// The window on the right: the open project's logo and title in its bar,
/// its screen below, coming in on every change
class _ProjectWindow extends StatelessWidget {
  final ProjectModel project;
  final int index;

  const _ProjectWindow({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final compact = context.isCompact;
    return WindowFrame(
      centerTitle: true,
      dotSize: compact ? 9 : 11,
      barPadding: compact
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 10)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: compact
          ? app.dimensions.radius.l
          : app.dimensions.radius.xl,
      background: colors.surface.window,
      shadows: [
        BoxShadow(
          offset: const Offset(0, 40),
          blurRadius: 120,
          color: colors.neutral.black.withValues(alpha: 0.55),
        ),
        BoxShadow(
          blurRadius: 80,
          color: colors.brand.indigo.withValues(alpha: 0.12),
        ),
      ],
      title: Container(
        height: 24,
        padding: const EdgeInsets.fromLTRB(8, 0, 14, 0),
        decoration: BoxDecoration(
          color: colors.surface.plate,
          borderRadius: app.dimensions.radius.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            project.logo.sized(height: 18),
            Flexible(
              child: Text(
                project.windowTitle.of(context),
                overflow: TextOverflow.ellipsis,
                style: AppText.meta.copyWith(fontSize: compact ? 11 : null),
              ),
            ),
          ],
        ),
      ),
      child: compact
          ? LayoutBuilder(
              builder: (context, box) {
                final size = project.compactPreviewSize;
                return SizedBox(
                  height: box.maxWidth * size.height / size.width,
                  child: ClipRect(
                    child: Entrance(
                      key: ValueKey(index),
                      child: FittedBox(
                        child: SizedBox.fromSize(
                          size: size,
                          child: project.preview(context),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : SizedBox(
              height: ProjectsSection.previewHeight,
              width: double.infinity,
              child: ClipRect(
                child: Entrance(
                  key: ValueKey(index),
                  child: SizedBox.expand(child: project.preview(context)),
                ),
              ),
            ),
    );
  }
}

/// The section on a phone: the open project's window on top, the arrows and
/// a dot per project under it, then the projects as an accordion
class _CompactProjects extends StatelessWidget {
  final ProjectState state;

  const _CompactProjects({required this.state});

  @override
  Widget build(BuildContext context) {
    final intl = context.intl.projects;
    final colors = app.colors;
    final cubit = context.read<ProjectCubit>();
    final chevron = app.assets.icons.actions.chevron;
    final iconColor = colors.text.primary;
    final total = state.projects.length;
    return PageColumn(
      padding: const EdgeInsets.fromLTRB(0, 64, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          SectionHeading(overline: intl.overline, title: intl.title),
          _ProjectWindow(project: state.current, index: state.active),
          Row(
            children: [
              AppIconButton(
                tooltip: intl.previous,
                onPressed: cubit.previous,
                icon: Transform.rotate(
                  angle: math.pi,
                  child: chevron.build(size: 18, color: iconColor),
                ),
              ),
              Expanded(
                child: ExcludeSemantics(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 6,
                    children: [
                      for (var i = 0; i < total; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: i == state.active ? 22 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: i == state.active
                                ? colors.brand.signal
                                : colors.surface.strokeStrong,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              AppIconButton(
                tooltip: intl.next,
                onPressed: cubit.next,
                icon: chevron.build(size: 18, color: iconColor),
              ),
            ],
          ),
          Semantics(
            label: intl.pick,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                for (var i = 0; i < total; i++)
                  _ProjectTab(
                    index: i,
                    project: state.projects[i],
                    open: i == state.active,
                    compact: true,
                    progress: i == state.active && state.auto
                        ? cubit.rotateEvery
                        : null,
                    onPick: () => cubit.pick(i),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// [_Details] on a phone: everything stacked, as tall as it needs
class _CompactDetails extends StatelessWidget {
  final ProjectModel project;

  const _CompactDetails({required this.project});

  @override
  Widget build(BuildContext context) {
    final colors = app.colors;
    final hasFooter = project.links.isNotEmpty || project.buttons.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Text(
            project.description.of(context),
            style: AppText.body.copyWith(color: colors.text.soft),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final tag in project.tags) AppTag(label: tag.of(context)),
            ],
          ),
          if (hasFooter)
            Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: colors.surface.stroke)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  for (final button in project.buttons)
                    AppButton(
                      label: button.label.of(context),
                      url: button.url,
                      icon: button.icon,
                      expand: true,
                      height: 48,
                      fontSize: 15,
                      padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                      borderRadius: BorderRadius.circular(10),
                      background: button.primary
                          ? colors.brand.indigo
                          : colors.surface.plate,
                      borderColor: button.primary
                          ? colors.brand.indigo
                          : colors.surface.strokeStrong,
                      foreground: colors.text.primary,
                    ),
                  for (final link in project.links)
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 44),
                      child: AppTextLink(
                        label: link.label,
                        url: link.url,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
