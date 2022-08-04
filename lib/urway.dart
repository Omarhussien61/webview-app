import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urwaypayment/urwaypayment.dart';

class Urway extends StatefulWidget {

  @override
  State<Urway> createState() => _UrwayState();
}

class _UrwayState extends State<Urway> {
  String _cardOper='Purchase';

  // To show Selected Item in Text.
  String holder = '' ;

  String actionholder = '1' ;

  String cardOperholder = '' ;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _queryCountry =TextEditingController() ;

  TextEditingController _queryFirstName =TextEditingController() ;

  TextEditingController _queryLastName =TextEditingController() ;

  TextEditingController _queryAddress =TextEditingController() ;

  TextEditingController _queryCity =TextEditingController() ;

  TextEditingController _queryState =TextEditingController() ;

  TextEditingController _queryZip =TextEditingController() ;

  TextEditingController _queryphone =TextEditingController() ;

  TextEditingController _queryemail =TextEditingController() ;

  TextEditingController _queryorderid=TextEditingController() ;

  TextEditingController _querycurrency=TextEditingController() ;

  TextEditingController _queryamt=TextEditingController() ;

  TextEditingController _queryaction=TextEditingController() ;

  TextEditingController _querytokenoperation=TextEditingController() ;

  TextEditingController _querytokentype=TextEditingController() ;

  TextEditingController _querycardTokenNo=TextEditingController() ;

  TextEditingController _queryudf1=TextEditingController() ;

  TextEditingController _queryudf2=TextEditingController() ;

  TextEditingController _queryudf3=TextEditingController() ;

  TextEditingController _queryudf4=TextEditingController() ;

  TextEditingController _queryudf5=TextEditingController() ;

  TextEditingController _querycompanyName=TextEditingController() ;

  TextEditingController _queryshipping=TextEditingController() ;

  TextEditingController _querymerchantIdentifier=TextEditingController() ;

  int _radioValue=0;

  List<String> _cardOperList= <String>['Purchase','PreAuth','Tokenization Add','Tokenization Update','Tokenization Delete','Standalone Refund'];

  @override
  void initState() {
    Payment.getPermission();
    _queryFirstName.text = 'John';
    _queryCountry.text = 'SA';
    _queryLastName.text = 'Deo';
    _queryAddress.text='101 Street';
    _queryCity.text='Mumbai';
    _queryState.text='Maharashtra';
    _queryZip.text='4000001';
    _queryphone.text='110000000';
    _queryemail.text='text@web.com';
    _queryorderid.text='12121212';
    _querycurrency.text='SAR';
    _queryamt.text='1.00';
    _queryaction.text='1';
    _querytokenoperation.text='A';
    _querytokentype.text='1';//cust present or not
    _querycardTokenNo.text='';
    _queryudf1.text='';
    _queryudf2.text='';
    _queryudf3.text='';
    _queryudf4.text='';
    _queryudf5.text='';
    _querycompanyName.text='Concerto';
    _queryshipping.text='0.00';
    _querymerchantIdentifier.text="merchant.com.alajlanonline.com.app";

  }

  void getDropDownItem(String dataHolder){

    setState(() {
      holder = dataHolder ;
      print('HOLDER $holder');
      if(holder=='Purchase')
      {
        actionholder='1';
        cardOperholder='';

      }
      else if(holder=='PreAuth')
      {
        actionholder='4';
        cardOperholder='';
      }
      else if(holder=='Tokenization Add')
      {
        actionholder='12';
        cardOperholder='A';
      }
      else if(holder=='Tokenization Update')
      {
        actionholder='12';
        cardOperholder='U';
      }
      else if(holder=='Tokenization Delete')
      {
        actionholder='12';
        cardOperholder='D';
      }
      else if(holder=='Standalone Refund')
      {
        actionholder='14';
        cardOperholder='';
      }
    });
  }

  void _handleRadioValue(int value)
  {
    setState(() {
      _radioValue=value;
      if(_radioValue==0)
      {
        _querytokentype.text='0';
      }
      else if(_radioValue==1)
      {
        _querytokentype.text='1';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Urway App'),

      ),

      body: Center(
        child: SingleChildScrollView(
          child:new Form(
            key: _formKey,
            //autovalidate: true,

            child:
            Container(
              child:Column(
                children: <Widget>[
                  new Card(
                    child: Column(
                      children: <Widget>[
                        new Text(
                          'Shipping Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryCountry,
                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Country",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryFirstName,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "FirstName",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new FormField(
                          builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.location_city),
                                labelText: 'Operations ',
                              ),
                              isEmpty:  _cardOper == '',
                              child: new DropdownButtonHideUnderline(
                                child: new DropdownButton(
                                  value:_cardOper,

                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  isDense: true,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.orange),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.orange,
                                  ),

                                  onChanged: ( newValue1) {
                                    setState(() {
                                      _cardOper= "$newValue1";
                                      getDropDownItem(_cardOper);
//                                  dropdownValue = newValue;
                                    });
                                  },
                                  items: _cardOperList.map((String value) {
                                    return new DropdownMenuItem(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryLastName,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryAddress,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Address",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryCity,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "City",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryState,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "State",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryZip,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Zip Code",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryphone,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Phone no",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryemail,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryorderid,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Order Id",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_querycurrency,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Currency",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryamt,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Amount",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_querymerchantIdentifier,

                            autofocus: false,
                            decoration: InputDecoration
                              (
                              labelText: "Merchant IDENTIFIER",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder
                                (
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        /* new SizedBox(

                      height: 50.0,
                      child:  Card(child: TextField(
                        controller:_querytokenoperation,

                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: "Tokenization Operation",
                          contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 14.0,
                            height: 2.0,
                            color: Colors.black
                        ),
                        onChanged: (String value)
                        {
                        },
                      ),
                      ),
                    ),*/

                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_querycardTokenNo,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Card Token",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),

                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryudf1,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "udf1",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryudf2,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "udf2",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryudf3,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "udf3",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryudf4,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "udf4",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryudf5,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "udf5",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_querycompanyName,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Company Name",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),
                        new SizedBox(

                          height: 50.0,
                          child:  Card(child: TextField(
                            controller:_queryshipping,

                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Shipping Charges",
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 2.0,
                                color: Colors.black
                            ),
                            onChanged: (String value)
                            {
                            },
                          ),
                          ),
                        ),

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
                              //                                 Icon(Urway.apple_pay, color: Colors.white,),
                              Icon(
                                Icons.apple,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.0,),
                              Text('Apple Pay', style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        ),

                        // RaisedButton(
                        //   color: Colors.yellow[700],
                        //   onPressed: (){
                        //     _performtrxn(context,"paypal");
                        //     // Toast.show('Pay with PayPal ', context, duration: Toast.LENGTH_SHORT,
                        //     //     gravity: Toast.BOTTOM);
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //
                        //       SizedBox(width: 8.0,),
                        //       Text('Pay with PayPal ', style: TextStyle(color: Colors.blue,fontStyle: FontStyle.italic),)
                        //     ],
                        //   ),
                        // ),
                        /*   Ink(
                            width: 200.0,
                            height: 40.0,
                            decoration:BoxDecoration(
                                color: Colors.yellow[700],

                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: IconButton(
                              icon: Image.asset('assets/paypallogo.png'),
                              iconSize: 100,
                              onPressed: () {
                                _performtrxn(context,"paypal");
                              },
                      )),*/
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _performtrxn(context,"hosted");
        },

        child: Icon(
          Icons.arrow_forward,
        ),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Future<void> _performtrxn(BuildContext context ,String transType ) async {
    var lastResult ="";
    var act=actionholder;
    var carOper=cardOperholder;
    var tokenTy=_querytokentype.text;
    print('$act - $carOper - $tokenTy');
    if(transType=="hosted") {
      // on Apple Click call other method  check with if else
      lastResult = await Payment.makepaymentService(context: context,
          country: _queryCountry.text,
          action: act,
          currency: _querycurrency.text,
          amt: _queryamt.text,
          customerEmail: _queryemail.text,
          trackid: _queryorderid.text,
          udf1: _queryudf1.text,
          udf2: _queryudf2.text,
          udf3: _queryudf3.text,
          udf4: _queryudf4.text,
          udf5: _queryudf5.text,
          cardToken: _querycardTokenNo.text,
          address: _queryAddress.text,
          city: _queryCity.text,
          state: _queryState.text,
          tokenizationType: tokenTy,
          zipCode: _queryZip.text,
          tokenOperation: carOper);


      print('Result in Main is $lastResult');
    }
    else if(transType =="applepay")
    {
      print("In apple pay");
      lastResult = await Payment.makeapplepaypaymentService(context: context,
          country: _queryCountry.text,
          action: act,
          currency: _querycurrency.text,
          amt: _queryamt.text,
          customerEmail: _queryemail.text,
          trackid: _queryorderid.text,
          udf1: _queryudf1.text,
          udf2: _queryudf2.text,
          udf3: _queryudf3.text,
          udf4: _queryudf4.text,
          udf5: _queryudf5.text,
          tokenizationType: tokenTy,
          merchantIdentifier:_querymerchantIdentifier.text,
          shippingCharge: _queryshipping.text,
          companyName:_querycompanyName.text
      );
      print('Result on Apple Pay in Main is $lastResult');
    }

// if (xyz != null )
//    {h
//      lastResult=xyz;
    Map<String,dynamic> decodedJSON;
    var decodeSucceeded = false;
    try {
      decodedJSON = json.decode(lastResult) as Map<String, dynamic>;
      decodeSucceeded = true;
    } on FormatException catch (e) {
      print('The provided string is not valid JSON');
    }
    if(decodeSucceeded)
    {
      var responseData = json.decode(lastResult);
      print('RESP $responseData');
      var trnsid = responseData["TranId"] as String;
      var respCode = responseData["ResponseCode"] as String ;
      var result = responseData["result"] as String;
      var amount = responseData["amount"] as String;
      var cardToken = responseData["cardToken"] as String;
      var cardBrand = responseData["cardBrand"] as String;
      var maskedPanNo = responseData["maskedPanNo"] as String;

//     String trnsid=responseData.TranId;
   //   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
      //    ReceiptPage(trnsid, result, amount, cardToken,cardBrand,maskedPanNo)));
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReceiptPage(trnsid,result,amount,cardToken,respCode)));
    }
    else
    {
      if(lastResult.length > 0) {
        print('Show');
      }
      else
      {
        print('Show Blank Data');
      }
    }
    print('Payment $lastResult');
  }
}
