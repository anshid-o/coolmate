import 'package:coolmate/pages/cards.dart';
import 'package:flutter/material.dart';
import '../const.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    // getDataFromUi();
  }

  // getDataFromUi() async {
  //   loading = false;
  //   await ApiData.getData();
  //   setState(() {
  //     loading = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Column(
                children: <Widget>[
                  MediaQuery.of(context).size.width < 1300
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List<Widget>.generate(4, (i) {
                            // return Text('data');
                            return tickets(colors[i], context, icons[i],
                                randomNumbers[i], newTexts[i]);
                          }),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List<Widget>.generate(4, (i) {
                            return tickets(colors[i], context, icons[i],
                                randomNumbers[i], newTexts[i]);
                          })),
                ],
              ),
            ),
          ]),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 1300 ? 4 : 3,
            childAspectRatio:
                MediaQuery.of(context).size.width < 1300 ? 0.6 : 0.65,
            mainAxisSpacing: 10,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 2,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 20),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network(
                        //   'https://placeimg.com/640/480/nature/grayscale',
                        //   fit: BoxFit.fill,
                        // ),
                        Container(
                          child: Center(
                            child: Text(
                              index.toString(),
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ]),
                ),
              );
            },
            childCount: 6,
          ),
        )
      ],
    );
  }
}
