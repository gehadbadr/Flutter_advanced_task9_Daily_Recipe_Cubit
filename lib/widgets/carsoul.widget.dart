import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe2/consts/consts.dart';
import 'package:daily_recipe2/cubit/carsoul_cubit.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarsoulWidget extends StatelessWidget {
  List? adsLists;

  CarsoulWidget({super.key, this.adsLists});
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Positioned(
          child: Column(
            children: [
              CarouselSlider.builder(
                  //  key: key,
                  carouselController: BlocProvider.of<CarsoulCubit>(context)
                      .carouselControllerEx,
                  options: CarouselOptions(
                      autoPlay: true,
                      height: 200,
                      viewportFraction: .75,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enlargeCenterPage: true,
                      onPageChanged: (index, _) {
                        BlocProvider.of<CarsoulCubit>(context)
                            .onSliderChanged(index, _);
                      },
                      enlargeFactor: .3),
                  itemCount: adsLists!.length,
                  itemBuilder: (BuildContext, index, int) => Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      adsLists![index].image!),
                                  fit: BoxFit.fill,
                                )),
                            margin: EdgeInsets.all(10),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              color: Colors.black38,
                              //height: 20,
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                adsLists![index].title!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: ColorsApp.whiteColor),
                              ),
                            ),
                          )
                        ],
                      )),
              const SizedBox(
                height: 10,
              ),
              DotsIndicator(
                dotsCount: adsLists!.length,
                position: BlocProvider.of<CarsoulCubit>(context).sliderIndex,
                onTap: (position) async {
                  await BlocProvider.of<CarsoulCubit>(context)
                      .dotsIndicator(position);
                },
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeColor: ColorsApp.PKColor,
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        //  if (state == OnSliderChanged)
        Visibility(
          visible: BlocProvider.of<CarsoulCubit>(context).showNext,
          child: Container(
            height: 40,
            width: 40,
            color: ColorsApp.lightGrey.withOpacity(0.5),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<CarsoulCubit>(context).previousSlider();
              },
              icon: const Icon(
                Icons.navigate_before,
                size: 25,
                color: ColorsApp.PKColor,
              ),
            ),
          ),
        ),
        Positioned(
          left: context.screenWidth - 80,
          child: Visibility(
            visible: BlocProvider.of<CarsoulCubit>(context).showPrev,
            child: Container(
              height: 40,
              width: 40,
              color: ColorsApp.lightGrey.withOpacity(0.5),
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<CarsoulCubit>(context).nextSlider();
                },
                icon: const Icon(Icons.navigate_next,
                    size: 30, color: ColorsApp.PKColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
