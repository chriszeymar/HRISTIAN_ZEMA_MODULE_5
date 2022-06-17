import 'package:basic_flutter/cubit/home_cubit/home_cubit.dart';
import 'package:basic_flutter/database.dart';
import 'package:basic_flutter/mixins/constant/color.dart';
import 'package:basic_flutter/mixins/constant/constant.dart';
import 'package:basic_flutter/mixins/constant/input_style.dart';
import 'package:basic_flutter/mixins/constant/text_style.dart';
import 'package:basic_flutter/model/goods.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGoodsScreen extends StatelessWidget {
  AddGoodsScreen({Key? key}) : super(key: key);
  final _formKey=GlobalKey<FormState>();
  String name="";
  String qty="";
  String price="";

  void addData(BuildContext context){
    if(_formKey.currentState!.validate()){
      int priceInt=int.parse(price.replaceAll(".",""));
      int qtyInt=int.parse(qty.replaceAll(".",""));
      Goods goods=Goods(
          name: name,
          price: priceInt,
          qty: qtyInt
      );
      BlocProvider.of<HomeCubit>(context).addGoods(goods);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items",style: kTextAveHev16,),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:   [
              const Text("Name of goods",style: kTextAveHev14,),
              const SizedBox(height: kDefaultPadding/4,),
              TextFormField(
                onChanged: (String? value){
                  name=value!;
                },
                validator: (String? value){
                  if(value!.isEmpty){
                    return "Name of goods";
                  }
                  return null;
                },
                decoration: kInputPrimary.copyWith(
                  hintStyle: kTextAveRom12,
                  hintText: "Enter Item Name"
                ),
              ),
              const SizedBox(height: kDefaultPadding,),
              const Text("Price of goods",style: kTextAveHev14,),
              const SizedBox(height: kDefaultPadding/4,),
              TextFormField(
                onChanged: (String? value){
                  price=value!;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'id',
                    decimalDigits: 0,
                    symbol: '',
                  )
                ],
                validator: (String? value){
                  if(value!.isEmpty){
                    return "Item price must be filled";
                  }
                  return null;
                },
                decoration: kInputPrimary.copyWith(
                    hintStyle: kTextAveRom12,
                    hintText: "Enter the Price of the Goods (Rands)"
                ),
              ),
              const SizedBox(height: kDefaultPadding,),
              const Text("Quantity",style: kTextAveHev14,),
              const SizedBox(height: kDefaultPadding/4,),
              TextFormField(
                onChanged: (String? value){
                  qty=value!;
                },
                validator: (String? value){
                  if(value!.isEmpty){
                    return "Qty";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'id',
                    decimalDigits: 0,
                    symbol: '',
                  )
                ],
                decoration: kInputPrimary.copyWith(
                    hintStyle: kTextAveRom12,
                    hintText: "Enter Quantity"
                ),
              ),
              const SizedBox(height: kDefaultPadding,),
              ElevatedButton(
                 style: ButtonStyle(
                   shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(8))
                   )),
                   backgroundColor: MaterialStateProperty.all(kColorPrimary)
                 ),
                  onPressed: (){
                    addData(context);
                    database.addItem(description: name, clientId: database.clientId, quantity: qty, itemPrice: price);
                  },
                  child: Text("Add",style: kTextAveHev16.copyWith(
                    color: kColorWhite
                  ),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
