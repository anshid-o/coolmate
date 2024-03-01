import 'package:coolmate/pages/bill/sale_order.dart';
import 'package:coolmate/pages/bill/sale_return.dart';
import 'package:coolmate/pages/login_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_web/material.dart';

Widget tickets(Color color, String tit, BuildContext context, IconData icon,
    String ticketsNumber, int newCount) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 2,
      child: GestureDetector(
        onTap: () {
          if (newCount == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return const BillScreen();
            }));
          } else if (newCount == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return const SaleReturnPage();
            }));
          } else if (newCount == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return const LoginForm();
            }));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(22),
          color: color,
          width: MediaQuery.of(context).size.width < 1300
              ? MediaQuery.of(context).size.width * .4 - 100
              : MediaQuery.of(context).size.width / 5.5,
          height: MediaQuery.of(context).size.height / 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 36,
                    color: Colors.white,
                  ),
                  Text(
                    tit,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: 'HelveticaNeue',
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
                    style: const TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  const SizedBox(
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
