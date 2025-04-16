import 'package:flutter/material.dart';
import 'package:namer_app/models/user_progress.dart';
import 'package:namer_app/pages/AnalysisReview/review_analysis_page.dart';
import 'package:namer_app/pages/DailyDiet/event_log_page.dart';
import 'package:namer_app/pages/MyPage/my_page.dart';
import 'package:namer_app/pages/TodayList/today_list_page.dart';
import 'package:namer_app/providers/progress.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_data.g.dart';

@Riverpod(keepAlive: true)
class PageWidget extends _$PageWidget {
  @override
  List<Widget> build() {
    final userProgress = ref.watch(progressProvider);
    // final pageIndex = ref.watch(pageIndexProvider);

    return userProgress.when(
      data: (data) {
        return _process(data);
      },
      error: (error, stackTrace) {
        return _process(null);
      },
      loading: () {
        return _process(null);
      },
    );
  }

  List<Widget> _process(UserProgress? progress) {
    if (progress == null || progress.progress < 3) {
      return <Widget>[
        TodayListPage(),
        EventLogPage(),
        MyPage(),
      ];
    }

    return <Widget>[
      TodayListPage(),
      EventLogPage(),
      ReviewAnalysisPage(),
      MyPage(),
    ];
  }
}

@Riverpod(keepAlive: true)
class PageIndex extends _$PageIndex {
  @override
  int build() {
    ref.listen(pageWidgetProvider, (prev, next) {
      if (prev != next) {
        state = 0;
      }
    });
    return 0;
  }

  void setIndex(int index) {
    final pageWidget = ref.watch(pageWidgetProvider);
    if (index >= pageWidget.length) {
      state = 0;
      return;
    }
    state = index;
  }
}

@Riverpod(keepAlive: true)
class BottomNavBar extends _$BottomNavBar {
  @override
  List<BottomNavigationBarItem> build() {
    final userProgress = ref.watch(progressProvider);
    return userProgress.when(
      data: (data) {
        return process(data);
      },
      error: (error, stackTrace) {
        return process(null);
      },
      loading: () {
        return process(null);
      },
    );
  }

  List<BottomNavigationBarItem> process(UserProgress? progress) {
    if (progress == null || progress.progress < 3) {
      return [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: ('每日任务'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note),
          label: ('行为记录'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: ('我的'),
        ),
      ];
    }

    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: ('每日任务'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.event_note),
        label: ('行为记录'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.rocket_launch_outlined),
        label: ('巩固提升'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: ('我的'),
      ),
    ];
  }
}
