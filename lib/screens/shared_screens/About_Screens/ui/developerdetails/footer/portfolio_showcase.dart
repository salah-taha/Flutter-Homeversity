import 'package:flutter/material.dart';

class PortfolioShowcase extends StatelessWidget {
  final List<String> images;

  PortfolioShowcase({@required this.images});

  List<Widget> _buildItems() {
    var items = <Widget>[];

    images.forEach((element) {
      var image = new Image.asset(
        element,
        fit: BoxFit.cover,
      );
      items.add(image);
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    var delegate = new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    );

    return new GridView(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 16.0),
      gridDelegate: delegate,
      children: _buildItems(),
    );
  }
}
