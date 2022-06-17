// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/models/animal.dart';
import '../../../../main.dart';
import '../../../custom_widgets/custom_container.dart';
import '../../../custom_widgets/image_container.dart';
import '../../../custom_widgets/text_view/text_views.dart';
import '../edit_animal/edit_animal_screen.dart';
import 'animal_detail_view_model.dart';
import 'animal_family/animal_family_screen.dart';
import 'animal_family/animal_family_view_model.dart';
import 'animal_gallery/animal_gallery_screen.dart';
import 'animal_gallery/animal_gallery_view_model.dart';
import 'animal_health/animal_health_screen.dart';
import 'animal_health/animal_health_view_model.dart';
import 'animal_milk/animal_milk_screen.dart';
import 'animal_milk/animal_milk_view_model.dart';
import 'animal_note/animal_note_screen.dart';
import 'animal_note/animal_note_view_model.dart';
import 'animal_weight/animal_weight_screen.dart';
import 'animal_weight/animal_weight_view_model.dart';

class AnimalDetailScreen extends StatefulWidget {
  Animal animal;
  List<Animal> animals = [];

  AnimalDetailScreen({required this.animal, required this.animals});

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      final healthViewModel = Provider.of<AnimalHealthViewModel>(context, listen: false);
      healthViewModel.assignValue(widget.animal.animalUid!);
      healthViewModel.getAnimalHealth();

      final noteViewModel =
          Provider.of<AnimalNoteViewModel>(context, listen: false);
      noteViewModel.assignValue(widget.animal.animalUid!, widget.animal);
      noteViewModel.getAnimalNote();

      final galleryViewModel =
          Provider.of<AnimalGalleryViewModel>(context, listen: false);
      galleryViewModel.assignValue(widget.animal.animalUid!, widget.animal);
      galleryViewModel.getAnimalGallery();

      final familyViewModel =
          Provider.of<AnimalFamilyViewModel>(context, listen: false);
      familyViewModel.assignValue(widget.animal.animalUid!, widget.animals);
      familyViewModel.getAnimalFamily();

      final weightViewModel =
          Provider.of<AnimalWeightViewModel>(context, listen: false);
      weightViewModel.assignValue(widget.animal.animalUid!, widget.animal);
      weightViewModel.getAnimalWeight();

      final milkViewModel =
          Provider.of<AnimalMilkViewModel>(context, listen: false);
      milkViewModel.assignValue(widget.animal.animalUid!);
      milkViewModel.getAnimalMilk();

//      galleryViewModel.getAnimalGallery();
    });
//    init();
  }

  init() async {}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnimalDetailViewModel(widget.animal, context),
      child: Consumer<AnimalDetailViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                logger.e("returning animal : ${model.animal}");
                Navigator.pop(context, model.animal);
              },
              icon: Icon(
                Icons.arrow_back,
              ),
              iconSize: 20.sp,
              color: Colors.black.withOpacity(0.6),
              splashColor: Colors.black.withOpacity(0.6),
            ),
            centerTitle: true,
            title: Text("Channab", style: appBarTextStyle),
            backgroundColor: backgroundColor,
            elevation: 0.0,
          ),
          body: Column(
            children: [
              /// ==== Animal Image ====
              Consumer<AnimalGalleryViewModel>(
                builder: (context, galleryModel, child) =>
                    // Container()

                    galleryModel.animal.file == null
                        ? ImageContainer(
                            width: double.infinity.w,
                            height: 200.h,
                            url: galleryModel.animal.animalImage,
                            fit: BoxFit.contain,
                          )
                        : Image(
                            image: FileImage(
                              galleryModel.animal.file!,
                            ),
                            width: double.infinity.w,
                            height: 200.h,
                            fit: BoxFit.fill,
                          ),
              ),

              /// ===== Animal Heading Tile =======
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 45.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(4, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textView18(
                        text: "${model.animal.animalTag}".toUpperCase(),
                        textColor: darkGrayColor),
                    // Text(
                    //   "${model.animal.animalTag}".toUpperCase(),
                    //   style: poppinTextStyle.copyWith(
                    //       fontSize: 18.sp,
                    //       fontWeight: FontWeight.w700,
                    //       color: darkGrayColor),
                    // ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Visibility(
                        visible: model.animal.pregnantStatus != null
                            ? model.animal.pregnantStatus!
                            : false,
                        child: _chip(
                            tag:
                                model.animal.pregnantStatus != null ? model.animal.pregnantStatus==true ? "Pregnant":"" : "",
                            backgroundColor: primaryColor)),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: ImageContainer(
                        width: 23,
                        height: 23.h,
                        assets: IconPath.bellIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    InkWell(
                      onTap: () async {
                        Animal? anl = await Get.to(
                            () => EditAnimalScreen(animal: model.animal));
                        if (anl != null) {
                          model.update(anl);
                        }
                      },
                      child: ImageContainer(
                        width: 23,
                        height: 23.h,
                        assets: IconPath.editIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    InkWell(
                      onTap: () {},
                      child: ImageContainer(
                        width: 23,
                        height: 23.h,
                        assets: IconPath.addIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),

              /// ===== Tab bar =======
              Container(
                color: Colors.white,
                child: TabBar(
                  indicatorColor: primaryColor,
                  labelColor: primaryColor,
                  isScrollable: true,
                  controller: _tabController,
                  labelStyle: poppinTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                  unselectedLabelStyle: poppinTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: darkGrayColor,
                  ),
                  unselectedLabelColor: darkGrayColor,
                  tabs: [
                    Tab(
                      child: Text(
                        "Detail",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Family",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Health",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Milking",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Gallery",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Weigth",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Notes",
                      ),
                    ),
                  ],
                ),
              ),

              ///  ============== TabBar View =================
              Flexible(
                child: Container(
//                  height: MediaQuery.of(context).size.height  - 337.sp,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      _detailAnimalTile(animal: model.animal),
                      AnimalFamilyScreen(),
                      AnimalHealthScreen(),
                      AnimalMilkScreen(),

                      AnimalGalleryScreen(),
                      AnimalWeightScreen(),
                      // AnimalWeightScreen(animal: model.animal),

                      AnimalNoteScreen(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///  ========== Detail Tile =================
  Widget _detailAnimalTile({required Animal animal}) {
    final weightViewModel =
        Provider.of<AnimalWeightViewModel>(context, listen: false);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(5, 20, 5, 15),
      child: Column(
        children: [
          CustomContainer(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _detailIconTile(
                          IconPath.weightIcon1, "${animal.animalWeight}kg"),
                    ),
//                    SizedBox(width: 25.w,),

                    Expanded(
                      flex: 1,
                      child: _detailIconTile(
                          IconPath.ageIcon1,
                          " Y ${AgeCalculator.age(animal.animalLactation == null ? DateTime.now() : DateTime.parse(animal.animalDOB!.isEmpty ? "${DateTime.now()}" : "${animal.animalDOB}")).years},"
                          " M ${AgeCalculator.age(animal.animalDOB == null ? DateTime.now() : DateTime.parse(animal.animalDOB!.isEmpty ? "${DateTime.now()}" : "${animal.animalDOB}")).months}"),
                    ),
//                    SizedBox(width: 25.w,),

                    Expanded(
                        flex: 1,
                        child: _detailIconTile(
                            IconPath.genderIcon, "${animal.animalSex}")),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _detailIconTile(
                          IconPath.lactationIcon1, "${animal.animalLactation}"),
                    ),
//                    SizedBox(width: 25.w,),

                    Expanded(
                      flex: 2,
                      child: _detailIconTile(
                          IconPath.typeIcon,
                          animal.animalNoteObject != null
                              ? animal.animalNoteObject?.noteDescription ??
                                  "N/A"
                              : "N/A"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),

          // Divider(color: Colors.black.withOpacity(0.3),),
        ],
      ),
    );
  }

  /// ===== Tiles =========
  Widget _chip({
    required String tag,
    required Color backgroundColor,
  }) {
    return Container(
      height: 25.sp,
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor.withOpacity(0.3),
//        border: Border.all(color: primaryColor)
      ),
      child: Center(
        child: Text(
          tag,
          style: poppinTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _detailIconTile(String iconPath, String tag) {
    return Container(
      // width: 124.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageContainer(
            height: 28.h,
            width: 28.w,
            assets: iconPath,
            radius: 0.r,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: 9.w,
          ),
          Flexible(child: textView12(text: tag, textColor: textDark,maxLines: 2))

        ],
      ),
    );
  }
}
