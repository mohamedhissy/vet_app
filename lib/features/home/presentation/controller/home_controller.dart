import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/storage/local/database/shared_preferences/app_settings_shared_preferences.dart';

class HomeController extends GetxController {
  AppSettingsSharedPreferences appSettingsSharedPreferences =
  AppSettingsSharedPreferences();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    _subscribeToArticleChanges();
  }

  void _subscribeToArticleChanges() {
    Supabase.instance.client.channel('public:articles')
        .on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: 'INSERT', schema: 'public', table: 'articles'),
          (payload, [ref]) {
        final newArticle = payload['new'];
        final title = newArticle['title'] ?? 'مقال جديد';

        NotificationService.instance.showNotification(
          title: '📢 مقال جديد',
          body: title,
        );
      },
    )
        .subscribe();
  }
}
