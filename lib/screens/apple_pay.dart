import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urwaypayment/urwaypayment.dart';
import 'package:wiyakm/provider/theme_notifier.dart';

class Apple_Pay extends StatefulWidget {
   Apple_Pay({Key? key,required this.order_id,required this.mount}) : super(key: key);
  String order_id,mount;
  @override
  _Apple_PayState createState() => _Apple_PayState();
}

class _Apple_PayState extends State<Apple_Pay> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apple Pay"),),
      backgroundColor:Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset("assets/logo.png"),
          Center(child: Text("order_id : ${widget.order_id}")),
          SizedBox(height: 20,),
          Center(child: Text("amount : ${widget.mount}")),
          SizedBox(height: 20,),
          RaisedButton(
            color: Colors.black,
            onPressed: (){

              if (Platform.isAndroid)
              {
                final snackBar = SnackBar(content: Text('Apple Pay works with IOS'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

              } else if (Platform.isIOS)
              {
                _performtrxn(context,"applepay");
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.apple,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0,),
                Text('Apple Pay', style: TextStyle(color: Colors.white),)
              ],
            ),
          ),        ],
      ),
    );
  }

  Future<void> _performtrxn(BuildContext context ,String transType ) async {
    final model = Provider.of<Provider_control>(context);

    var lastResult ="";
    var act='1';
    var carOper='1';
    var tokenTy="0";
  if(transType =="applepay")
    {
      print("In apple pay");
      lastResult = await Payment.makeapplepaypaymentService(context: context,
          country: "SA",
          action: act,
          currency:"SAR",
          amt: widget.mount,
          customerEmail:"omarhussien61@gmail.com",
          trackid: widget.order_id,
          udf1:"",
          udf2: "",
          udf3: "",
          udf4:"",
          udf5: "",
          tokenizationType: "1",
          merchantIdentifier:"com.wiakuminc.wiakumapp",
          shippingCharge: "0.00",
          companyName:"alajlan online"
      );
      print('Result on Apple Pay in Main is $lastResult');
      Navigator.pop(context,"${model.getBaseUrl()}payments/order/applepay?orderId=${widget.order_id}&amount=${widget.mount}&payment_result=success&merchant_reference=1999&payment_id=4343434");
      Navigator.pop(context,"${model.getBaseUrl()}payments/order/applepay?orderId=${widget.order_id}&amount=${widget.mount}&payment_result=success&merchant_reference=1999&payment_id=4343434");
      Navigator.pop(context,"${model.getBaseUrl()}payments/order/applepay?orderId=${widget.order_id}&amount=${widget.mount}&payment_result=success&merchant_reference=1999&payment_id=4343434");
      // Navigator.pushReplacement(context, MaterialPageRoute(builder:
      //     (BuildContext context) {
      // );

    }
    print('Payment $lastResult');
  }


}
