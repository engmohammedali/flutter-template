import 'package:template/core/router/app_routes.dart';
import 'package:template/features/auth/pages/password_reset_screen.dart';
import 'package:template/features/auth/pages/login_screen.dart';
import 'package:template/features/help/help_screen.dart';
import 'package:template/features/home/home.dart';
import 'package:template/features/onboarding/onboarding_screen.dart';
import 'package:template/features/splash/splash_screen.dart';
import 'package:template/features/statics/about.dart';
import 'package:template/features/statics/privacy_policy.dart';
import 'package:template/features/statics/terms_conditions.dart';

List<GoRoute> routes = [
  GoRoute(
    path: AppRoutes.splash.path,
    name: AppRoutes.splash.name,
    builder: (_, __) => const SplashScreen(),
  ),
  GoRoute(
    path: AppRoutes.onboarding.path,
    name: AppRoutes.onboarding.name,
    builder: (context, state) => const OnboardingScreen(),
  ),
  GoRoute(
    path: AppRoutes.about.path,
    name: AppRoutes.about.name,
    builder: (_, __) => const AboutScreen(),
  ),
  GoRoute(
    path: AppRoutes.privacyPolicy.path,
    name: AppRoutes.privacyPolicy.name,
    builder: (_, __) => const PrivacyPolicyScreen(),
  ),
  GoRoute(
    path: AppRoutes.termsConditions.path,
    name: AppRoutes.termsConditions.name,
    builder: (_, __) => const TermsConditionsScreen(),
  ),
  GoRoute(
    path: AppRoutes.help.path,
    name: AppRoutes.help.name,
    builder: (_, __) => const HelpScreen(),
  ),
  GoRoute(
    path: AppRoutes.login.path,
    name: AppRoutes.login.name,
    builder: (_, __) => LoginScreen(),
    routes: [
      GoRoute(
        path: AppRoutes.resetPassword.path,
        name: AppRoutes.resetPassword.name,
        builder: (_, __) => const PasswordResetScreen(),
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.home.path,
    name: AppRoutes.home.name,
    builder: (_, __) => const HomeScreen(),
  ),

  /* 
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(
            child: RootScreen(
              location: state.fullPath ?? '',
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.home.path,
            name: AppRoutes.home.name,
            builder: (_, __) => const Homescreen(),
          ),
          GoRoute(
            path: AppRoutes.notifications.path,
            name: AppRoutes.notifications.name,
            builder: (_, __) => const NotificationsScreen(),
          ),
          GoRoute(
            path: AppRoutes.search.path,
            name: AppRoutes.search.name,
            builder: (context, state) {
              final query = state.pathParameters['query'] ?? '';
              return SearchScreen(query: query);
            },
          ),
          GoRoute(
              path: AppRoutes.profile.path,
              name: AppRoutes.profile.name,
              builder: (_, __) => const ProfileScreen(),
              routes: [
                GoRoute(
                  path: AppRoutes.myCourses.path,
                  name: AppRoutes.myCourses.name,
                  builder: (_, __) => const MyCoursesScreen(),
                ),
                GoRoute(
                  path: AppRoutes.changePassword.path,
                  name: AppRoutes.changePassword.name,
                  builder: (_, __) => const ChangePasswordScreen(),
                ),
                GoRoute(
                  path: AppRoutes.updateProfile.path,
                  name: AppRoutes.updateProfile.name,
                  builder: (_, __) => const UpdateProfileScreen(),
                ),
                GoRoute(
                  path: AppRoutes.about.path,
                  name: AppRoutes.about.name,
                  builder: (_, __) => const AboutScreen(),
                ),
                GoRoute(
                  path: AppRoutes.privacyPolicy.path,
                  name: AppRoutes.privacyPolicy.name,
                  builder: (_, __) => const PrivacyPolicyScreen(),
                ),
                GoRoute(
                  path: AppRoutes.termsConditions.path,
                  name: AppRoutes.termsConditions.name,
                  builder: (_, __) => const TermsConditionsScreen(),
                ),
                GoRoute(
                  path: AppRoutes.help.path,
                  name: AppRoutes.help.name,
                  builder: (_, __) => const HelpScreen(),
                ),
              ]),
          GoRoute(
            path: AppRoutes.web.path,
            name: AppRoutes.web.name,
            builder: (_, __) => const WebViewExample(),
          ),
          GoRoute(
              path: AppRoutes.consultations.path,
              name: AppRoutes.consultations.name,
              builder: (_, __) => const ConsultationsScreen(),
              routes: [
                GoRoute(
                  path: AppRoutes.consultationDetails.path,
                  name: AppRoutes.consultationDetails.name,
                  builder: (context, state) {
                    final consultationId =
                        state.pathParameters['consultationId'] ?? '';

                    return ConsultationDetailsScreen(
                      consultationId: consultationId,
                    );
                  },
                ),
              ]),
          GoRoute(
              path: AppRoutes.posts.path,
              name: AppRoutes.posts.name,
              builder: (_, __) => const PostsScreen(),
              routes: [
                GoRoute(
                  path: AppRoutes.postDetails.path,
                  name: AppRoutes.postDetails.name,
                  builder: (_, __) => const PostDetails(),
                ),
              ]),
          GoRoute(
            path: AppRoutes.diploms.path,
            name: AppRoutes.diploms.name,
            builder: (_, __) => const AcademicScreen(),
            routes: [
              GoRoute(
                path: AppRoutes.diplomDetail.path,
                name: AppRoutes.diplomDetail.name,
                builder: (context, state) {
                  final diplomId = state.pathParameters['diplomId'] ?? '';
                  return DiplomDetailScreen(diplomId: diplomId);
                },
                routes: const [],
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.courses.path,
            name: AppRoutes.courses.name,
            // builder: (context, state) {
            //   // final diplomId = state.pathParameters['diplomId'] ?? '';
            //   // ref.read(categoryIdProvider.notifier).state = diplomId;
            //   return const CoursesScreen();
            // },
            pageBuilder: (context, state) {
              // final diplomId = state.pathParameters['diplomId'] ?? '';
              // ref.read(categoryIdProvider.notifier).state = diplomId;
              return const NoTransitionPage(child: CoursesScreen());
            },
            routes: [
              GoRoute(
                  path: AppRoutes.courseDetail.path,
                  name: AppRoutes.courseDetail.name,
                  builder: (context, state) {
                    final courseId = state.pathParameters['courseId'] ?? '';
                    return CourseDetailScreen(
                      courseId: courseId,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: AppRoutes.lessons.path,
                      name: AppRoutes.lessons.name,
                      builder: (context, state) {
                        final courseId = state.pathParameters['courseId'] ?? '';
                        return LessonsScreen(courseId: courseId);
                      },
                    ),
                    GoRoute(
                      path: AppRoutes.quiz.path,
                      name: AppRoutes.quiz.name,
                      builder: (context, state) {
                        final courseId = state.pathParameters['courseId'] ?? '';
                        final quizId = state.pathParameters['quizId'] ?? '';
                        return QuizScreen(
                          quizId: quizId,
                          courseId: courseId,
                        );
                      },
                      onExit: (context, state) async {
                        final bool? confirmed = await showDialog<bool>(
                          context: context,
                          useRootNavigator: true,
                          builder: (ctx) => AlertDialog(
                              alignment: Alignment.center,
                              actionsAlignment: MainAxisAlignment.center,
                              titleTextStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                color: AppColor.gray700,
                                fontFamily: AppFont.fontFamily,
                              ),
                              contentTextStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColor.gray700,
                                fontFamily: AppFont.fontFamily,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              title: Column(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .splashColor
                                          .withOpacity(.1),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Icon(
                                      Icons.quiz_outlined,
                                      color: AppColor.gray700,
                                      size: 38,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    'هل تريد إنهاء الاختبار؟',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              content: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'هل أنت متأكد من إنهاء الاختبار الحالي؟',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              actions: [
                                // OutlinedButton(
                                //   style: OutlinedButton.styleFrom(
                                //     side: const BorderSide(
                                //       color: AppColor.gray400,
                                //     ),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(50),
                                //     ),
                                //   ),
                                //   onPressed: () {
                                //     Navigator.of(context).pop(false);
                                //   },
                                //   child: const Text(
                                //     'متابعة الاختبار',
                                //     style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       color: AppColor.gray400,
                                //     ),
                                //   ),
                                // ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary500,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text(
                                    'إنهاء الاختبار',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              ]),
                        );

                        return confirmed ?? false;
                      },
                    ),
                    GoRoute(
                      path: AppRoutes.quizResult.path,
                      name: AppRoutes.quizResult.name,
                      builder: (context, state) {
                        final courseId = state.pathParameters['courseId'] ?? '';
                        final quizId = state.pathParameters['quizId'] ?? '';
                        return QuizResultScreen(
                          quizId: quizId,
                          courseId: courseId,
                        );
                      },
                    ),
                  ]),
            ],
          ),
          GoRoute(
            path: AppRoutes.favorite.path,
            name: AppRoutes.favorite.name,
            builder: (_, __) => const FavoriteScreen(),
          ),
          GoRoute(
              path: AppRoutes.appointmentOrder.path,
              name: AppRoutes.appointmentOrder.name,
              builder: (_, __) => const AppointmentOrder(),
              routes: [
                GoRoute(
                  path: AppRoutes.appointmentDone.path,
                  name: AppRoutes.appointmentDone.name,
                  builder: (_, __) => const AppointmentDone(),
                ),
              ]),
        ],
      ),
      // GoRoute(
      //   path: AppRoutes.root.path,
      //   name: AppRoutes.root.name,
      //   builder: (_, __) => const Homescreen(),
      // ),
    */
];
