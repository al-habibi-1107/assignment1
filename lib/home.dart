import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dragged = "";
  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // GRADIENT BACKGROUND - STACK LEVEL 1
          Container(
            height: device.height,
            width: device.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.lightBlue, Colors.red.shade500],
              ),
            ),
          ),
          // MAIN PAGE - STACK LEVEL 2
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ROW WITH DRAGGABLE ELEMENTS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // DRAGGABLE CIRCLE
                      dragged == "Circle"
                          ? Container(
                              width: 130,
                              height: 130,
                            )
                          : Draggable<String>(
                              onDragCompleted: () {
                                setState(() {
                                  dragged = "Circle";
                                });
                              },
                              data: "Circle",
                              // remaining widget when dragging
                              childWhenDragging: Container(
                                width: 130,
                                height: 130,
                              ),
                              // widget getting dragged
                              feedback: DropCircle(),
                              // widget displayed in normal position
                              child: DropCircle()),

                      // DRAGGABLE SQUIRCLE

                      dragged == "Squircle"
                          ? Container(
                              width: 130,
                              height: 130,
                            )
                          : Draggable<String>(
                              onDragCompleted: () {
                                setState(() {
                                  dragged = "Squircle";
                                });
                              },
                              data: "Squircle",
                              // remaining widget when dragging
                              childWhenDragging: Container(
                                width: 130,
                                height: 130,
                              ),
                              // widget displayed in normal position
                              child: DropSquircle(),
                              // widget getting dragged
                              feedback: DropSquircle(),
                            ),
                    ],
                  ),
                  DragTarget(builder: (context, obj, val) {
                    if (obj.isEmpty && dragged == "") {
                      return Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Drop Target",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      );
                    } else if (obj.isNotEmpty && dragged == "") {
                      return Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: obj[0] == "Circle"
                              ? DropCircle()
                              : DropSquircle(),
                        ),
                      );
                    } else {
                      return Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: dragged == "Circle"
                              ? DropCircle()
                              : DropSquircle(),
                        ),
                      );
                    }
                  }),
                  Container(
                    width: device.width,
                    child: Center(
                      child: Text(
                        dragged == ""
                            ? "None Selected"
                            : (dragged == "Circle"
                                ? "Circle Selected"
                                : "Squircle Selected"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropSquircle extends StatelessWidget {
  const DropSquircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Center(
        child: Text(
          "Draggable and Droppable Squircle",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}

class DropCircle extends StatelessWidget {
  const DropCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 65,
      backgroundColor: Colors.white,
      child: Text(
        "Draggable and Droppable Circle",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }
}
