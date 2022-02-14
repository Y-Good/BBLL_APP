import 'package:get/get.dart';

import '../common/middlewares/router_auth.dart';
import '../pages/live_detail/bindings/live_detail_binding.dart';
import '../pages/live_detail/views/live_detail_view.dart';
import '../pages/login/bindings/login_binding.dart';
import '../pages/login/views/login_view.dart';
import '../pages/navigation_page.dart';
import '../pages/notices/bindings/notices_binding.dart';
import '../pages/notices/views/notices_view.dart';
import '../pages/public.dart';
import '../pages/register/bindings/register_binding.dart';
import '../pages/register/views/register_view.dart';
import '../pages/search/bindings/search_binding.dart';
import '../pages/search/views/search_view.dart';
import '../pages/setting/bindings/setting_binding.dart';
import '../pages/setting/views/setting_view.dart';
import '../pages/upload/bindings/upload_binding.dart';
import '../pages/upload/views/upload_view.dart';
import '../pages/view-user/user/bindings/user_binding.dart';
import '../pages/view-user/user/views/user_view.dart';
import '../pages/view-user/user_edit/bindings/user_edit_binding.dart';
import '../pages/view-user/user_edit/views/user_edit_view.dart';
import '../pages/view-user/user_history/bindings/user_history_binding.dart';
import '../pages/view-user/user_history/views/user_history_view.dart';
import '../pages/view-user/user_zone/bindings/user_zone_binding.dart';
import '../pages/view-user/user_zone/views/user_zone_view.dart';
import '../pages/view-user/video_detail/bindings/video_detail_binding.dart';
import '../pages/view-user/video_detail/views/video_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
        name: _Paths.ROOT,
        page: () => MBottomNavigationBarPage(),
        bindings: [
          HomeBinding(),
          LiveBinding(),
          FindBinding(),
          UserBinding(),
          // UploadBinding()
        ]),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.LIVE,
      page: () => LiveView(),
      binding: LiveBinding(),
    ),
    GetPage(
      name: _Paths.FIND,
      page: () => FindView(),
      binding: FindBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
      fullscreenDialog: true,
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.VIDEO_DETAIL,
      page: () => VideoDetailView(),
      binding: VideoDetailBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD,
      page: () => UploadView(),
      binding: UploadBinding(),
      middlewares: [RouteAuthMiddleware()],
      fullscreenDialog: true,
      popGesture: false,
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.NOTICES,
      page: () => NoticesView(),
      binding: NoticesBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_DETAIL,
      page: () => LiveDetailView(),
      binding: LiveDetailBinding(),
    ),
    GetPage(
      name: _Paths.USER_ZONE,
      page: () => UserZoneView(),
      middlewares: [RouteAuthMiddleware()],
      binding: UserZoneBinding(),
    ),
    GetPage(
      name: _Paths.USER_EDIT,
      page: () => UserEditView(),
      binding: UserEditBinding(),
    ),
    GetPage(
      name: _Paths.USER_HISTORY,
      page: () => UserHistoryView(),
      binding: UserHistoryBinding(),
    ),
  ];
}
