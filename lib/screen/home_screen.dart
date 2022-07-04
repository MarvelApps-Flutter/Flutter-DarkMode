import 'dart:math';
import 'package:dark_and_light_mode_2_module/model/list/profile_screen_data_list.dart';
import 'package:dark_and_light_mode_2_module/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final List _bottomNavigationBarItemList = DataList().bottomNavigationBarItem;
  final List _settingList = DataList().settingList;
  final List _progressList = DataList().progressList;
  late AnimationController animationController;

  late Animation<double> animation;
  bool cirAn = false;

  @override
  void initState() {
    for (var i = 0; i < _bottomNavigationBarItemList.length; i++) {
      if (i == 2) _bottomNavigationBarItemList[2].isSelected = true;
    }
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: cirAn
            ? CircularRevealAnimation(
                centerOffset: Offset(size.height / 12, size.width / 3.7),
                animation: animation,
                child: _body(context),
              )
            : _body(context),
        bottomNavigationBar: _bottomNavigationBar(context),
      ),
    );
  }

  Container _bottomNavigationBar(BuildContext context) {
    return Container(
      color: Theme.of(context).bottomAppBarColor,
      height: 80,
      child: FractionallySizedBox(
        widthFactor: 0.85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            return InkWell(
              onTap: () {
                for (var e in _bottomNavigationBarItemList) {
                  e.isSelected = false;
                }
                setState(() {
                  _bottomNavigationBarItemList[index].isSelected = true;
                });
              },
              child: Column(
                children: [
                  _bottomNavigationBarItemList[index].isSelected
                      ? Container(
                          height: 4,
                          width: 20,
                          color: Colors.blue,
                        )
                      : Container(
                          height: 4,
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  Icon(
                    _bottomNavigationBarItemList[index].icon,
                    color: _bottomNavigationBarItemList[index].isSelected
                        ? Colors.blue
                        : null,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  SizedBox _body(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FractionallySizedBox(
        widthFactor: 0.85,
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xFF1C1E2F),
                    child: Icon(
                      Icons.cloud,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        backgroundImage: Image.network(
                                'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80')
                            .image,
                        radius: 55,
                      ),
                    ],
                  ),
                  Icon(Icons.logout_rounded, color: Colors.grey.shade500)
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Rena Figueroa',
              textScaleFactor: 2.0,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              child: Text('rena.figueroa@gmail.com',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2!.color)),
            ),
            _progressCardContainer(context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: SizedBox(
                  width: double.infinity,
                  child: Text('SETTINGS',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.bodyText2!.color))),
            ),
            _settingsContainer(context),
          ],
        ),
      ),
    );
  }

  Container _settingsContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: List.generate(_settingList.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Text(_settingList[index].label,
                    textScaleFactor: 1.3,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                const Spacer(),
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    value: index ==
                            _settingList.indexWhere(
                                (element) => element.label == 'Dark Mode')
                        ? Provider.of<ThemeProvider>(context).isDarkMode
                        : _settingList[index].isSelected,
                    onChanged: (value) {
                      setState(() {
                        cirAn = true;
                        _settingList[index].isSelected = value;
                      });

                      final provider =
                          Provider.of<ThemeProvider>(context, listen: false);

                      provider.toggleTheme(_settingList[_settingList.indexWhere(
                              (element) => element.label == 'Dark Mode')]
                          .isSelected);
                      if (animationController.status ==
                              AnimationStatus.forward ||
                          animationController.status ==
                              AnimationStatus.completed) {
                        animationController.reset();
                        animationController.forward();
                      } else {
                        animationController.forward();
                      }
                    },
                    trackColor: Colors.grey,
                    activeColor: Colors.blue,
                    thumbColor: Theme.of(context).textTheme.bodyText1!.color,

                    //  activeThumbImage: Image.asset('assets/night.png',fit: BoxFit.fill,).image,
                    //  inactiveThumbImage: Image.asset('assets/day.png',fit: BoxFit.fill,).image
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Container _progressCardContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_progressList.length, (index) {
          return Column(
            children: [
              _progressIndicator(index),
              const SizedBox(
                height: 10,
              ),
              Text(_progressList[index].title,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2!.color))
            ],
          );
        }),
      ),
    );
  }

  TweenAnimationBuilder<double> _progressIndicator(int index) {
    return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1000),
        tween: Tween(
            begin: 0.0, end: DataList().progressList[index].progress / 100),
        builder: (context, double value, child) {
          return Transform.rotate(
              angle: -pi / 2,
              child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return SweepGradient(
                              startAngle: 0,
                              endAngle: 2 * pi,
                              stops: [value, value],
                              center: Alignment.center,
                              colors: [
                                DataList().progressList[index].color,
                                Colors.grey.shade700
                              ]).createShader(rect);
                        },
                        child: SizedBox(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Transform.rotate(
                              angle: pi / 2,
                              child: Center(
                                  child: Text(
                                '+' +
                                    _progressList[index]
                                        .progress
                                        .toStringAsFixed(0) +
                                    '%',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color),
                              ))),
                        ),
                      ),
                    ],
                  )));
        });
  }
}
