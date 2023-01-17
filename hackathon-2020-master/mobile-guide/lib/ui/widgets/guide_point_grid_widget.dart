import 'package:ble_app/models/GuidePoint.dart';
import 'package:ble_app/ui/screens/guide_point_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GuidePointGridWidget extends StatelessWidget {
  final List<GuidePoint> guidePoints;

  static const TextStyle headerStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  static const TextStyle descStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  GuidePointGridWidget({
    this.guidePoints = const [],
  });

  void navigateToGuidePointDetail(
          BuildContext context, GuidePoint guidePoint) =>
      Navigator.pushNamed(
        context,
        GuidePointScreen.route,
        arguments: guidePoint,
      );

  Widget _buildPoint(BuildContext context, int index) {
    final GuidePoint gp = guidePoints[index];
    // String chipText;
    // if (gp.pointType == PointType.navigation && gp.freeAccess)
    //   chipText = 'Bezbarierová nav.';
    // else if(gp.pointType == PointType.navigation)
    //   chipText = 'Navigácia';
    // else
    //   chipText = 'Informácia';
    IconData chipIcon;
    if (gp.pointType == PointType.navigation && gp.freeAccess)
      chipIcon = Icons.accessible;
    else if(gp.pointType == PointType.navigation)
      chipIcon = Icons.navigation;
    else
      chipIcon = Icons.info_outline;
    return Card(
      margin: EdgeInsets.all(0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => navigateToGuidePointDetail(context, gp),
        child: Material(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Image.network(
                      gp.imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                    // Container(
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(gp.imageUrl), fit: BoxFit.cover)),
                    // ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 6.0, right: 8.0, top: 8.0),
                        child: Text(
                          gp.name,
                          style: headerStyle,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, bottom: 8.0, right: 8.0),
                        child: Text(
                          gp.description,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style: descStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Theme(
                  data: ThemeData(canvasColor: Colors.transparent),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
                    // label: Text(chipText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                    child: Icon(chipIcon, color: Colors.black87,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double space = 8;

    double cardWidth = (MediaQuery.of(context).size.width - 3 * space) / 2;
    double cardHeight = cardWidth * 3 / 2;
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: guidePoints.length,
      padding: EdgeInsets.all(space),
      crossAxisSpacing: space,
      mainAxisSpacing: space,
      itemBuilder: _buildPoint,
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
    );
  }
}

// class GuidePointGridWidget extends StatelessWidget {
//   final List<GuidePoint> guidePoints;
//
//   static const TextStyle headerStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
//
//   GuidePointGridWidget({
//     this.guidePoints = const [],
//   });
//
//   List<Widget> _buildPoints(double cardHeight) {
//     return guidePoints
//         .map((gp) => Card(
//               margin: EdgeInsets.all(0),
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 // side: BorderSide(color: Colors.white70, width: 1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: InkWell(
//                 onTap: () {},
//                 child: Material(
//                   child: Container(
//                     child: Column(
//                       children: [
//                         // Image.network(gp.imageUrl, fit: BoxFit.fitWidth,),
//                         Container(
//                           height: cardHeight / 2,
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: NetworkImage(gp.imageUrl),
//                                   fit: BoxFit.cover)),
//                         ),
//                         Text(gp.name, style: headerStyle,),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ))
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double space = 8;
//
//     double cardWidth = (MediaQuery.of(context).size.width - 3 * space) / 2;
//     double cardHeight = cardWidth * 3 / 2 ;
//     return GridView.count(
//       padding: EdgeInsets.all(space),
//       crossAxisSpacing: space,
//       mainAxisSpacing: space,
//       crossAxisCount: 2,
//       childAspectRatio: 2 / 3,
//       children: _buildPoints(cardHeight),
//     );
//   }
// }
