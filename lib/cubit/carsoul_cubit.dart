import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe2/models/ad.models.dart';
import 'package:daily_recipe2/repository/carsoul.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'carsoul_state.dart';

class CarsoulCubit extends Cubit<CarsoulState> {
  late CarsoulRepository carsoulRepository;
  int sliderIndex = 0;
  List<Ad> adsLists = [];
  CarouselController carouselControllerEx = CarouselController();
  bool showNext = false;
  bool showPrev = false;
  CarsoulCubit() : super(CarsoulInitial());

  // void getAds() async {
  //   carsoulRepository.getAds().then((adsLists){
  //   emit(CarsoulLoading());
  //    Future.delayed(Duration(seconds: 1), () {
  //     this.adsLists = adsLists;
  //     emit(CarsoulLoaded(this.adsLists));
  //   });
  //   });
  // }
  
  void getAds() async {
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
    adsLists = dataDecoded.map((e) => Ad.fromJson(e)).toList();
    emit(CarsoulLoading());
    await Future.delayed(Duration(seconds: 1), () {
      emit(CarsoulLoaded(adsLists));
    });
  }

  onSliderChanged(index, _) async {
    emit(CarsoulLoaded(adsLists));

    if (index != adsLists.length - 1) {
      showNext = true;
    } else {
      showNext = false;
    }
    if (index > 0) {
      showPrev = true;
    } else {
      showPrev = false;
    }
    sliderIndex = index;
  }

  nextSlider() {
    carouselControllerEx.nextPage();
  }

  previousSlider() {
    carouselControllerEx.previousPage();
  }

  dotsIndicator(position) async {
    await carouselControllerEx.animateToPage(position);
    sliderIndex = position;
  }
}
