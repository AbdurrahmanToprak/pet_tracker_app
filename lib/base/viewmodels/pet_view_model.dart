import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../models/pet_model.dart';

class PetViewModel with ChangeNotifier {
  final Box<PetModel> _petBox;

  PetViewModel() : _petBox = Hive.box<PetModel>('pets');

  List<PetModel> get pets => _petBox.values.toList();
  //ekleme
  void addPet(PetModel pet) {
    _petBox.add(pet);
    notifyListeners();
  }

  //güncelleme fonksiyonu
  void updatePet(PetModel oldPet, PetModel updatedPet) {
    final index = _petBox.values.toList().indexOf(oldPet);
    if (index != -1) {
      _petBox.putAt(index, updatedPet);
      notifyListeners();
    }
  }

  // silme işlemi
  void deletePet(int index) {
    _petBox.deleteAt(index);
    notifyListeners();
  }
}
