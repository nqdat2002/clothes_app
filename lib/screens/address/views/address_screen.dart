import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/services/user/address_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  AddressService addressService = AddressService();
  List<String> addresses = [];

  final TextEditingController _addressController = TextEditingController();

  Future<void> _fetchAddress() async {
    try {
      List<String> listaddressz = await addressService.getUserAddress();
      if (mounted) {
        setState(() {
          addresses = listaddressz;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching address of user");
      }
    }
  }

  // Future<void> _addAddress(String address) async {
  //   bool ok = await addressService.addUserAddress(address);
  //   if (ok) {
  //     _fetchAddress();
  //     Navigator.pop(context);
  //   }
  // }

  // Future<void> _editAddress(int index, String newAddress) async {
  //   bool ok = await addressService.updateUserAddress(index, newAddress);
  //   if (ok) {
  //     _fetchAddress();
  //     Navigator.pop(context);
  //   }
  // }

    
  Future<bool> _addAddress(String address) async {
    return await addressService.addUserAddress(address);
  }

  Future<bool> _editAddress(int index, String newAddress) async {
    return await addressService.updateUserAddress(index, newAddress);
  }


  Future<void> _deleteAddress(int index) async {
    bool ok = await addressService.deleteAddress(index);
    if (ok) {
      _fetchAddress();
      
    }
  }

  void _showAddressForm({int? index}) {
    _addressController.text = index != null ? addresses[index] : '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? "Thêm địa chỉ" : "Chỉnh sửa địa chỉ"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: "Nhập địa chỉ",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            // TextButton(
            //   onPressed: () => Navigator.pop(context),
            //   child: const Text("Hủy"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     if (_addressController.text.isNotEmpty) {
            //       if (index == null) {
            //         _addAddress(_addressController.text);
            //       } else {
            //         _editAddress(index, _addressController.text);
            //         Navigator.pop(context);
            //       }
            //     }
            //   },
            //   child: Text(index == null ? "Thêm" : "Lưu"),
            // ),
            
            ElevatedButton(
              onPressed: () async {
                if (_addressController.text.isEmpty) return;

                final address = _addressController.text;
                bool success = false;

                if (index == null) {
                  success = await _addAddress(address);
                } else {
                  success = await _editAddress(index, address);
                }

                if (!mounted) return;

                if (success) {
                  await _fetchAddress();
                  if (mounted) Navigator.pop(context);
                }
              },
              child: Text(index == null ? "Thêm" : "Lưu"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý địa chỉ"),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(addresses[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                        "assets/icons/Delete.svg",
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    onPressed: () => _deleteAddress(index),
                  ),
                  IconButton(
                      onPressed: () => _showAddressForm(index: index),
                      icon: SvgPicture.asset(
                        "assets/icons/Edit-Bold.svg",
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          primaryColor,
                          BlendMode.srcIn,
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddressForm(),
        child: SvgPicture.asset(
          "assets/icons/Plus1.svg",
          height: 28,
          width: 28,
          colorFilter: const ColorFilter.mode(
            primaryColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
