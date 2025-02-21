import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'main_controller.dart';

Map<String, String> minerals = {
  "Muscovite": "Muscovite is a hydrated phyllosilicate mineral of aluminium and potassium with the formula KAl2(AlSi3O10)(F,OH)2, or (KF)2(Al2O3)3(SiO2)6(H2O). It is the most common mica, found in granites, pegmatites, gneisses, and schists, as well as a contact metamorphic rock or secondary mineral from alteration of topaz, feldspar, kyanite.",
  "Chrysocolla": "Chrysocolla is a hydrated copper phyllosilicate mineral with formula Cu2−xAlx(H2−xSi2O5)(OH)4·nH2O (x<1) or (Cu,Al)2H2Si2O5(OH)4·nH2O. It is associated with minerals like quartz, limonite, azurite, malachite, cuprite, and other secondary copper minerals.",
  "Quartz": "Quartz is a hard, crystalline mineral composed of silicon and oxygen atoms. It is a defining constituent of granite and other felsic igneous rocks, commonly found in sedimentary rocks such as sandstone and shale, as well as in schist, gneiss, quartzite, and other metamorphic rocks.",
  "Bornite": "Bornite is a sulfide mineral with the chemical composition Cu5FeS4. It is an important copper ore mineral and is commonly found in porphyry copper deposits, often alongside chalcopyrite.",
  "Pyrite": "Pyrite, also known as 'fool's gold,' is an iron sulfide with the chemical formula FeS2 (iron(II) disulfide).",
  "Malachite": "Malachite is a copper carbonate hydroxide mineral, with the formula Cu2CO3(OH)2. It often forms from the weathering of copper ores and is commonly found with azurite, goethite, and calcite.",
  "Biotite": "Biotite is a common group of phyllosilicate minerals within the mica group, with the approximate chemical formula K(Mg,Fe)3AlSi3O10(F,OH)2."
};

class ImageInfoPage extends StatefulWidget {
  @override
  State<ImageInfoPage> createState() => _ImageInfoPageState();
}

class _ImageInfoPageState extends State<ImageInfoPage> {
  final controller c = Get.put(controller());

  @override
  void initState() {
    super.initState();
    c.get_largest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F4F4F), // Slate Gray as the background color
      appBar: AppBar(
        backgroundColor: Color(0xFF2F4F4F), // Slate Gray for the AppBar
        title: Text(
          'Image Information',
          style: TextStyle(
            color: Colors.white, // White text for contrast
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2F4F4F), Color(0xFF50C878)], // Slate Gray to Emerald Green
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white, // White border
                            width: 3.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(File(c.selectedImagePath.value)),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Center(
                    child: Text(
                      c.title.value,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text for contrast
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                        child: Text(
                          minerals[c.title.value]!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white, // White text for contrast
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}