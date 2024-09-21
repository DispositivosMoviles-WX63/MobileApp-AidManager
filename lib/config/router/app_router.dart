import 'package:aidmanager_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:aidmanager_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:aidmanager_mobile/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:aidmanager_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:aidmanager_mobile/features/posts/presentation/screens/posts_screen.dart';
import 'package:aidmanager_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:aidmanager_mobile/features/projects/presentation/screens/projects_screen.dart';
import 'package:aidmanager_mobile/features/social/presentation/screens/social_screen.dart';
import 'package:aidmanager_mobile/shared/main_wrapper.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainWrapper(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/social',
          name: SocialScreen.name,
          builder: (context, state) => const SocialScreen(),
        ),
        GoRoute(
          path: '/projects',
          name: ProjectsScreen.name,
          builder: (context, state) => const ProjectsScreen(),
        ),
        GoRoute(
          path: '/calendar',
          name: CalendarScreen.name,
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: '/posts',
          name: PostsScreen.name,
          builder: (context, state) => const PostsScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: ProfileScreen.name,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);