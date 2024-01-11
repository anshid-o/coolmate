import 'package:coolmate/pages/bill/temp.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_web/material.dart';

Widget tickets(Color color, BuildContext context, IconData icon,
    String ticketsNumber, int newCount) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 2,
      child: GestureDetector(
        onTap: () {
          if (newCount == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return BillScreen();
            }));
          }
        },
        child: Container(
          padding: EdgeInsets.all(22),
          color: color,
          width: MediaQuery.of(context).size.width < 1300
              ? MediaQuery.of(context).size.width - 100
              : MediaQuery.of(context).size.width / 5.5,
          height: MediaQuery.of(context).size.height / 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 36,
                    color: Colors.white,
                  ),
                  Text(
                    "View Details",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaNeue',
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ticketsNumber,
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Text(
                  //   newCount,
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.white,
                  //     // fontWeight: FontWeight.bold,
                  //     fontFamily: 'HelveticaNeue',
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
