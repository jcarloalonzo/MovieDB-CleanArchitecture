import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget with PreferredSizeWidget {
  const FavoritesAppBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: const TextStyle(color: Colors.black),
      title: const Text('Favorites'),
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(vertical: 10),
        indicatorSize: TabBarIndicatorSize.label,
        // indicator: BoxDecoration(
        //   color: Colors.black12,
        //   borderRadius: BorderRadius.circular(30),
        // ),
        indicator: const _Decoration(color: Colors.blue, width: 20),
        controller: tabController,
        labelColor: Colors.black,
        tabs: const [
          Tab(
            text: ('Movies'),
          ),
          Tab(
            text: ('Series'),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _Decoration extends Decoration {
  const _Decoration({required this.color, required this.width});

  final Color color;
  final double width;
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _Painter(color, width);
}

class _Painter extends BoxPainter {
  _Painter(this.color, this.width);

  final Color color;
  final double width;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    //
    final paint = Paint()..color = color;
    final size = configuration.size ?? Size.zero;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width * 0.5 + offset.dx - width * 0.5,
                size.height * 0.9, width, width * 0.3),
            const Radius.circular(4)),
        paint);

    // canvas.drawCircle(offset, 4, paint);
    // canvas.drawCircle(
    //     Offset(size.width * 0.5 + offset.dx, size.height), 4, paint);
  }
}
