import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';

abstract class ProjectsDatasource {
  Future<void> createProject(Project project);
  Future<List<Project>> getProjectsByCompanyId(int companyId);
  Future<Project> getProjectById(int id);
  Future<void> deleteProjectById(int id);
  Future<void> updateProjectById(int id, Project project);
}