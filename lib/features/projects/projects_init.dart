import 'package:root101/app_exporter.dart';

class ProjectsInit {
  static Future init() async {
    ProjectCubit cubit = ProjectCubit(projects: ProjectsCatalog.all);
    app.di.put(cubit);
  }
}
