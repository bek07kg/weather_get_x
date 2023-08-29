import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_get_x/src/constants/app_colors.dart';
import 'package:weather_get_x/src/constants/app_text.dart';
import 'package:weather_get_x/src/constants/app_text_styles.dart';
import 'package:weather_get_x/src/controller/weather_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final gtx = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppText.text,
          style: AppTextStyles.appBarStyle,
        ),
      ),
      body: gtx.weather.value == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/weather.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await gtx.weatherLocation();
                        },
                        color: AppColors.white,
                        iconSize: 50,
                        icon: const Icon(Icons.near_me),
                      ),
                      IconButton(
                        onPressed: () {
                          gtx.showBotton(context);
                        },
                        color: AppColors.white,
                        iconSize: 50,
                        icon: const Icon(Icons.location_city),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
