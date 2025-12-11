import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  Widget _getSlider() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          fit: BoxFit.cover,
          width: screenWidth,
          widget.bannerList[index].imgUrl);
      }),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider()]);

    // return Container(
    //   alignment: Alignment.center,
    //   height: 200,
    //   color: Colors.blue,
    //   child: Text("轮播图", style: TextStyle(color: Colors.white, fontSize: 30)),
    // );
  }
}
