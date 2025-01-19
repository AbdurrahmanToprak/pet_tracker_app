import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../models/pet_model.dart';

class PetViewModel with ChangeNotifier {
  final Box<PetModel> _petBox;

  PetViewModel() : _petBox = Hive.box<PetModel>('pets');

  List<PetModel> get pets => _petBox.values.toList();

  // Evcil hayvan ekleme
  void addPet(PetModel pet) {
    _petBox.add(pet);
    notifyListeners();
  }

  // Evcil hayvan güncelleme
  void updatePet(String id, PetModel updatedPet) {
    final index = _petBox.values.toList().indexWhere((pet) => pet.id == id);
    if (index != -1) {
      _petBox.putAt(index, updatedPet);
      notifyListeners();
    }
  }

  // Evcil hayvan silme
  void deletePet(int index) {
    _petBox.deleteAt(index);
    notifyListeners();
  }
}
