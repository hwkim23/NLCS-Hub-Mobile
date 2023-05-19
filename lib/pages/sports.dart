import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../main.dart';
import '../state.dart';
import 'bulletin.dart';
import 'package:nlcshub_app/myAppBar.dart';
import 'package:nlcshub_app/myDrawer.dart';
import 'package:lottie/lottie.dart';

int select = 0;

//Expansion tile
class ItemTile extends StatefulWidget {
  const ItemTile(
      {super.key,
      required this.division,
      required this.index,
      required this.expanded});

  final String division;
  final int index;
  final List<bool> expanded;

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  //List<String> logoUrl = [];
  List<String> date = [];
  List<String> opp = [];
  List<List<dynamic>> score = [];
  List<bool> isBoy = [];
  List<bool> isA = [];
  List<String> sport = [];
  List<String> tour = [];

  void filter(String division) {
    List<String> separate = division.split(' ');

    //List<String> tempLogoUrl = [];
    List<String> tempDate = [];
    List<String> tempOpp = [];
    List<List<dynamic>> tempScore = [];
    List<String> tempTour = [];

    if (context.read<Store3>().loaded == true) {
      for (int i = 0; i < context.read<Store3>().date.length; i++) {
        if (separate[2] == "Volleyball") {
          if (separate[0] == "Boys") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "volleyball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "volleyball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          } else if (separate[0] == "Girls") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "volleyball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "volleyball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          }
        } else if (separate[2] == "Football") {
          if (separate[0] == "Boys") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "football") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "football") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          } else if (separate[0] == "Girls") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "football") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "football") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          }
        } else if (separate[2] == "Basketball") {
          if (separate[0] == "Boys") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "basketball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "basketball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          } else if (separate[0] == "Girls") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "basketball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "basketball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          }
        }
      }
    }

    setState(() {
      //logoUrl = tempLogoUrl;
      date = tempDate;
      opp = tempOpp;
      score = tempScore;
      tour = tempTour;
    });
  }

  @override
  Widget build(BuildContext context) {
    filter(widget.division);
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.expanded[widget.index] = !widget.expanded[widget.index];
          });
        },
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.only(top: 1.h),
          duration: const Duration(milliseconds: 200),
          height: widget.expanded[widget.index]
              ? 25.65.h + (19.h * (date.length - 1))
              : 9.h,
          child: Card(
            color: const Color.fromRGBO(241, 242, 246, 1.0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 2.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.division,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      widget.expanded[widget.index]
                          ? const Icon(Icons.expand_less)
                          : const Icon(Icons.expand_more),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: widget.expanded[widget.index]
                      ? 20.h + (19.h * (date.length - 1))
                      : 0,
                  width: 100.w,
                  child: widget.expanded[widget.index]
                      ? ItemExpandedTile(division: widget.division)
                      : const SizedBox(height: 0.00),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Widget which is shown after expanding
class ItemExpandedTile extends StatefulWidget {
  const ItemExpandedTile({super.key, required this.division});

  final String division;

  @override
  State<ItemExpandedTile> createState() => _ItemExpandedTileState();
}

class _ItemExpandedTileState extends State<ItemExpandedTile> {
  int tag = 0;

  Color nlcs = const Color(0x979ccaf7);
  Color kisj = const Color(0x9a0033e9);
  Color sja = const Color(0x9e378531);
  Color bha = const Color(0x976a229e);
  Color kis = const Color(0x9251b3df);
  Color bis = Colors.black;
  Color gsis = const Color(0xff522480);
  Color sis = const Color(0xffD77D48);
  Color bfs = const Color(0xff292A6B);
  Color isb = const Color.fromARGB(255, 181, 39, 51);
  Color fps = const Color(0xffA68845);

  //List<String> logoUrl = [];
  List<String> date = [];
  List<String> opp = [];
  List<List<dynamic>> score = [];
  List<bool> isBoy = [];
  List<bool> isA = [];
  List<String> sport = [];
  List<String> tour = [];

  void filter(String division) {
    List<String> separate = division.split(' ');

    //List<String> tempLogoUrl = [];
    List<String> tempDate = [];
    List<String> tempOpp = [];
    List<List<dynamic>> tempScore = [];
    List<String> tempTour = [];

    if (context.read<Store3>().loaded == true) {
      for (int i = 0; i < context.read<Store3>().date.length; i++) {
        if (separate[2] == "Volleyball") {
          if (separate[0] == "Boys") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "volleyball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "volleyball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          } else if (separate[0] == "Girls") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "volleyball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "volleyball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          }
        } else if (separate[2] == "Football") {
          if (separate[0] == "Boys") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "football") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "football") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          } else if (separate[0] == "Girls") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "football") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "football") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          }
        } else if (separate[2] == "Basketball") {
          if (separate[0] == "Boys") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "basketball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "basketball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          } else if (separate[0] == "Girls") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "basketball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "basketball") {
                //tempLogoUrl.add(context.read<Store3>().logoUrl[i]);
                tempDate.add(context.read<Store3>().date[i]);
                tempOpp.add(context.read<Store3>().opp[i]);
                tempScore.add(context.read<Store3>().score[i]);
                tempTour.add(context.read<Store3>().tournament[i]);
              }
            }
          }
        }
      }
    } else {
      for (int i = 0; i < context.read<Store3>().date.length; i++) {
        if (separate[2] == "Volleyball") {
          if (separate[0] == "Boys") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "volleyball") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "volleyball") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            }
          } else if (separate[0] == "Girls") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "volleyball") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "volleyball") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            }
          }
        } else if (separate[2] == "Football") {
          if (separate[0] == "Boys") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "football") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "football") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            }
          } else if (separate[0] == "Girls") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "football") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "football") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            }
          }
        } else if (separate[2] == "Basketball") {
          if (separate[0] == "Boys") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "basketball") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == true &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "basketball") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            }
          } else if (separate[0] == "Girls") {
            if (separate[separate.length - 1] == "A") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == true &&
                  context.read<Store3>().sport[i] == "basketball") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            } else if (separate[separate.length - 1] == "B") {
              if (context.read<Store3>().isBoy[i] == false &&
                  context.read<Store3>().isA[i] == false &&
                  context.read<Store3>().sport[i] == "basketball") {
                tempDate.add(context.read<Store3>().date[i]);
              }
            }
          }
        }
      }
    }

    setState(() {
      //logoUrl = tempLogoUrl;
      date = tempDate;
      opp = tempOpp;
      score = tempScore;
      tour = tempTour;
    });
  }

  @override
  void initState() {
    super.initState();
    filter(widget.division);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: date.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.only(top: 2.5.h),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 16.5.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          nlcs,
                          opp[index] == "fps"
                              ? fps
                              : opp[index] == "nlcs"
                                  ? nlcs
                                  : opp[index] == "isb"
                                      ? isb
                                      : opp[index] == "bfs"
                                          ? bfs
                                          : opp[index] == "sja"
                                              ? sja
                                              : opp[index] == "kisj"
                                                  ? kisj
                                                  : opp[index] == "bha"
                                                      ? bha
                                                      : opp[index] == "kis"
                                                          ? kis
                                                          : opp[index] == "bis"
                                                              ? bis
                                                              : opp[index] ==
                                                                      "gsis"
                                                                  ? gsis
                                                                  : sis
                        ],
                      )),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(right: 5.w),
                          child: CachedNetworkImage(
                            imageUrl: context.read<Store3>().nlcsUrl,
                          ),
                        ),
                      ),
                      Flexible(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 3.h),
                            decoration: BoxDecoration(
                                color: const Color(0x40ffffff),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        tour[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.sp),
                                      )),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 0.8.h),
                                    width: double.infinity,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 8.w,
                                            child: Text(
                                              "${score[index][0]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.sp),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7.w,
                                            child: const VerticalDivider(
                                              color: Color(0x80ffffff),
                                              thickness: 1.3,
                                              width: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                            child: Text(
                                              "${score[index][1]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        date[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.sp),
                                      )),
                                ),
                              ],
                            ),
                          )),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Container(
                            height: 7.h,
                            padding: EdgeInsets.only(left: 5.w),
                            child: Image.asset('assets/school_logos/${opp[index]}.png')/*CachedNetworkImage(
                              imageUrl: logoUrl[index],
                            ),*/
                          ),
                        ),
                      )
                    ],
                  ));
            })
      ],
    );
  }
}

class SportsCall extends StatefulWidget {
  const SportsCall({super.key});

  @override
  State<SportsCall> createState() => _SportsCallState();
}

class _SportsCallState extends State<SportsCall> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(241, 242, 246, 1.0),
      appBar: BaseAppBar(
          appBar: AppBar(), color: const Color.fromRGBO(241, 242, 246, 1.0)),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          if (_selectedIndex == 0) {
            return const Sports();
          } else if (_selectedIndex == 1) {
            return const HomePage();
          } else {
            return const Bulletin();
          }
        }),
      ),
      drawer: const BaseDrawer(drawer: Drawer()),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Sports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Bulletin',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff1e73be),
        onTap: _onItemTapped,
      ),
    );
  }
}

class Sports extends StatefulWidget {
  const Sports({
    Key? key,
  }) : super(key: key);

  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  int _selectedIndex = -1;

  List<String> label = ["Football", "Basketball", "Volleyball"];
  List<IconData> listOfChipNames = [
    Icons.sports_soccer,
    Icons.sports_basketball,
    Icons.sports_volleyball
  ];
  bool supportsMultiSelect = false;
  List<Color> inactiveBgColorList = const [Color.fromRGBO(241, 242, 246, 1.0)];
  List<Color> activeBgColorList = const [Color(0xff1e73be)];
  List<Color> activeTextColorList = const [Color.fromRGBO(241, 242, 246, 1.0)];
  List<Color> inactiveTextColorList = const [Colors.black];
  List<int> listOfChipIndicesCurrentlySeclected = [0];
  bool shouldWrap = false;
  ScrollPhysics? scrollPhysics;
  WrapAlignment wrapAlignment = WrapAlignment.start;
  WrapCrossAlignment wrapCrossAlignment = WrapCrossAlignment.start;
  Axis axis = Axis.horizontal;
  WrapAlignment runAlignment = WrapAlignment.start;
  double runSpacing = 0.0;
  double spacing = 0.0;
  VerticalDirection verticalDirection = VerticalDirection.down;
  List<double> borderRadiiList = const [15];
  List<Color> inactiveBorderColorList = const [
    Color.fromRGBO(241, 242, 246, 1.0)
  ];
  List<Color> activeBorderColorList = const [Color(0xff1e73be)];
  double widgetSpacing = 4;
  EdgeInsets padding = EdgeInsets.zero;

  bool _checkChipSelectionStatus(int index) {
    if (supportsMultiSelect &&
        listOfChipIndicesCurrentlySeclected.contains(index)) {
      return true;
    } else if (!supportsMultiSelect &&
        listOfChipIndicesCurrentlySeclected.first == index) {
      return true;
    }

    return false;
  }

  void _handleOnSelected(int index) {
    listOfChipIndicesCurrentlySeclected.first = index;
  }

  Color _textColorizer(int index) {
    if (index == listOfChipIndicesCurrentlySeclected.first) {
      if (activeTextColorList.length == 1) {
        return activeTextColorList.first;
      } else {
        return activeTextColorList[index];
      }
    } else {
      if (inactiveTextColorList.length == 1) {
        return inactiveTextColorList.first;
      } else {
        return inactiveTextColorList[index];
      }
    }
  }

  Color _tileColorizer(int index) {
    if (index == listOfChipIndicesCurrentlySeclected.first) {
      if (activeBgColorList.length == 1) {
        return activeBgColorList.first;
      } else {
        return activeBgColorList[index];
      }
    } else {
      if (inactiveBgColorList.length == 1) {
        return inactiveBgColorList.first;
      } else {
        return inactiveBgColorList[index];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    select = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
              if (_selectedIndex == -1) {
                return Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: SingleChildScrollView(
                                scrollDirection: axis,
                                physics:
                                    scrollPhysics ?? const ScrollPhysics(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    listOfChipNames.length,
                                    (index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: widgetSpacing,
                                      ),
                                      child: Column(
                                        children: [
                                          ChoiceChip(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 7),
                                            label: Icon(
                                                listOfChipNames[index],
                                                color: _textColorizer(index)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      borderRadiiList
                                                                  .length ==
                                                              1
                                                          ? borderRadiiList
                                                              .first
                                                          : borderRadiiList[
                                                              index]),
                                            ),
                                            backgroundColor:
                                                inactiveBgColorList
                                                            .length ==
                                                        1
                                                    ? inactiveBgColorList
                                                        .first
                                                    : inactiveBgColorList[
                                                        index],
                                            selected:
                                                _checkChipSelectionStatus(
                                                    index),
                                            selectedColor:
                                                _tileColorizer(index),
                                            onSelected: (val) {
                                              _handleOnSelected(index);
                                              // update UI
                                              setState(() {
                                                select = index;
                                              });
                                            },
                                          ),
                                          Text(label[index])
                                        ],
                                      ),
                                    ),
                                  ),
                                ))),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (select == 0) {
                              List<bool> expanded = [false, false, false];
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  List<String> divisions = [
                                    'Boys HS Football A',
                                    'Girls HS Football A',
                                    'Girls HS Football B',
                                  ];
                                  return ItemTile(
                                      division: divisions[index],
                                      index: 1,
                                      expanded: expanded);
                                },
                              );
                            } else if (select == 1) {
                              List<bool> expanded = [false, false, false];
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  List<String> divisions = [
                                    'Boys HS Basketball A',
                                    'Boys HS Basketball B',
                                    'Girls HS Basketball A',
                                    'Girls HS Basketball B',
                                  ];
                                  return ItemTile(
                                      division: divisions[index],
                                      index: 2,
                                      expanded: expanded);
                                },
                              );
                            } else {
                              List<bool> expanded = [
                                false,
                                false,
                                false,
                                false
                              ];
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  List<String> divisions = [
                                    'Boys HS Volleyball A',
                                    'Boys HS Volleyball B',
                                    'Girls HS Volleyball A',
                                    'Girls HS Volleyball B',
                                  ];
                                  return ItemTile(
                                      division: divisions[index],
                                      index: 0,
                                      expanded: expanded);
                                },
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              } else if (_selectedIndex == 0) {
                return const Sports();
              } else if (_selectedIndex == 1) {
                return const HomePage();
              } else {
                return const Bulletin();
              }
            }));
  }
}

class Filter {
  final String label;
  final IconData icon;

  const Filter({required this.label, required this.icon});
}

class ChipsFilter extends StatefulWidget {
  final List<Filter> filters;
  final int selected;

  const ChipsFilter({Key? key, required this.filters, required this.selected})
      : super(key: key);

  @override
  _ChipsFilterState createState() => _ChipsFilterState();
}

class _ChipsFilterState extends State<ChipsFilter> {
  late int selectedIndex;

  @override
  void initState() {
    if (widget.selected >= 0 && widget.selected < widget.filters.length) {
      selectedIndex = widget.selected;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: chipBuilder,
      itemCount: widget.filters.length,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget chipBuilder(context, currentIndex) {
    Filter filter = widget.filters[currentIndex];
    bool isActive = selectedIndex == currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = currentIndex;
          setState(() {
            select = currentIndex;
          });
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xff1e73be)
                    : const Color.fromRGBO(241, 242, 246, 1.0),
                border:
                    Border.all(color: const Color.fromRGBO(241, 242, 246, 1.0)),
                borderRadius: BorderRadius.circular(100),
              ),
              child: isActive
                  ? Icon(
                      filter.icon,
                      color: Colors.white,
                    )
                  : Icon(filter.icon),
            ),
            Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(filter.label, style: TextStyle(fontSize: 14.sp)))
          ],
        ),
      ),
    );
  }
}
