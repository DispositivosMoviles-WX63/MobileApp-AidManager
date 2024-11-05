import 'package:flutter/material.dart';
import 'package:aidmanager_mobile/features/profile/domain/repositories/user_repository.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';

import '../../../profile/domain/entities/user.dart';

class SocialProvider extends ChangeNotifier {
  UserRepository userRepository;
  AuthProvider authProvider;

  List<User> users = [];
  bool isLoading = false;

  SocialProvider({
    required this.userRepository,
    required this.authProvider,
  });

  Future<void> getMembersByCompany() async {
    isLoading = true;

    try {
      // Fetch the logged-in user
      final loggedInUser =
          await userRepository.getUserById(authProvider.user!.id!);

      // Fetch all users by company ID
      final allUsers =
          await userRepository.getAllUsersByCompanyId(loggedInUser.companyId!);

      // Filter out the logged-in user from the list
      users = allUsers.where((user) => user.id != loggedInUser.id).toList();
    } catch (e) {
      throw Exception('Error to fetch members by company');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> kickMemberFromCompany(int userId) async {
    isLoading = true;
    notifyListeners();

    try {
        await userRepository.deleteUserById(userId);
        // Eliminar el usuario del arreglo users
        users = users.where((user) => user.id != userId).toList();
        print(users);
    } catch (e) {
        print('Error kicking member: $e');
    } finally {
        isLoading = false;
        notifyListeners();
    }
}
}
