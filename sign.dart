import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:intel/bottomnavbar/bottomnavbar.dart';
import 'package:intel/bottomnavbar/splashscreen.dart';



void main() async {
  runApp(new SignIn());
}

class Sing extends StatefulWidget {
  @override
  _SingState createState() => _SingState();
}

class _SingState extends State<Sing> with TickerProviderStateMixin {

  TabController tabController;

  @override
  void initState(){
    tabController = TabController(length: 2,vsync: this,initialIndex: 0);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,


        title: Text(
          'WELCOME!',
          style: TextStyle(
            color: Color(0xffE74C3C),fontSize: 20.0,fontFamily: 'Montserrat'
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xffE74C3C),size: 20.0),

        bottom: PreferredSize(
          preferredSize: Size(0.0, 33.0),
          child: TabBar(
            indicatorColor: Color(0xffE74C3C),
            tabs: [Text('Sign In'),Text('Register') ],
            controller: tabController,
            

            labelColor: Color(0xffE74C3C),
            unselectedLabelColor: Colors.grey,
            

            labelStyle: TextStyle(fontSize: 16.7,fontFamily: 'MontserratSemiBold'),
            unselectedLabelStyle: TextStyle(fontSize: 13.3,fontFamily: 'Montserrat'),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],

      body: Container(
        margin: EdgeInsets.all(20.0),

        child: TabBarView(
          controller: tabController,
          children: <Widget> [
            SignIn(),
            SignUp(),
          ],
        ),
      ),
    );
  }
}



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
final GlobalKey<FormFieldState<String>> nameKey = GlobalKey<FormFieldState<String>>();
final GlobalKey<FormFieldState<String>> passwordKey = GlobalKey<FormFieldState<String>>();

  final _formKey = GlobalKey<FormState>();
  bool _secure = false;
  bool _stand = false;

  bool checked = true;
  bool _obscureText = true;
  String _password;

  void _toggle(){
    setState((){
      _obscureText = !_obscureText; 
    });
  }

  @override
  Widget build(BuildContext context) {
     const padding = 150.0;

    return Container(
     child: Form(
       key: _formKey,
       child: ListView(
         scrollDirection: Axis.horizontal,
         children: [
           field('Username',Icons.account_circle,TextInputType.text, nameController,nameKey),
           field('Password',Icons.lock,TextInputType.visiblePassword,passwordController,passwordKey),

           Align(
             alignment: Alignment.bottomRight,
             child: InkWell(
               child: Text(
               'Forget Password??',
               style: TextStyle(color: Colors.grey,fontSize: 14.0),
               ),
               onTap: (){
                 showDialog(
                   context:context,
                   builder: (BuildContext context){
                     return AlertDialog(
                       title: Text(
                         'Do you want to send a link to your account?',
                         style: TextStyle(color: Colors.black54,fontSize: 15.0),
                       ),


                       actions: [
                         FlatButton(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                           color: Color(0xffE74C3C),
                           child: Text(
                             'Send Link',
                             style: TextStyle(color: Colors.white,fontSize: 15.0),
                           ),
                           onPressed: (){},
                         ),

                         FlatButton(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                           color: Colors.red,
                           child: Text(
                             'Cancel',
                             style: TextStyle(color:Colors.white,fontSize: 15.0,fontWeight: FontWeight.normal ),
                           ),

                           onPressed: (){
                             Navigator.pop(context);
                           },
                         )
                       ],
                     );
                   } 
                   );
               },
             ),
           ),

           ListTile(
             title: Text(
               'Remember Me?',
               style: TextStyle(color: Color(0xffE74C3C),fontSize: 16.7,fontFamily: 'Montserrat'),
             ),


             trailing: Checkbox(
               activeColor: Color(0xffE74C3C),
               checkColor: Colors.white,
               hoverColor: Color(0xffE74C3C),


              onChanged: (value){
                setState(() {
                  if(checked == false){
                    return null;
                  }
                  else{
                    checked = value;
                  }
                });
              },
              value: checked,
             ),
             onTap: (){
               setState(() {
                 checked = true;
               });
             },
           ),

           Container(padding: EdgeInsets.only(bottom: 5.0)),

           Column(
             children: [
               FlatButton(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                 color: Color(0xffE74C3C),
                 child: Text(
                   '   Sign in   ',
                   style: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.normal),
                 ),


                onPressed: (){
                  if(_formKey.currentState.validate()){
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreens()),
                    );
                  }
                  else{
                    return Scaffold.of(context).showSnackBar(snack('Some fields are requirud!'));
                  }
                },
               )
             ],
           ),

           Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,


             children: <Widget> [
               Column(
                 children: <Widget> [
                   SizedBox(height: padding),


                   FacebookSignInButton(
                     onPressed: () {},
                     borderRadius: 5.0,
                     splashColor: Colors.white,
                     centered: true,
                     text: '  Sign in with Facbook',
                     textStyle: TextStyle(fontSize: 15.0,color: Colors.white,fontFamily: 'Montserrat'),
                   ),


                   GoogleSignInButton(
                     onPressed: (){},
                     borderRadius: 5.0,
                     splashColor: Colors.white,
                     centered: true,
                     text: 'Continue with Google',
                     textStyle: TextStyle(fontSize: 15.0,color: Colors.black54,fontFamily: 'Montserrat'),
                   ),




                 ],
               )
             ],
           )
         ],
       ),
     ) 
    );
  }


  snack(String content) {
    return SnackBar(
      content: Text(
        content,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.normal
        ),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 7),
    );
  }



  field(String labal, IconData icon,TextInputType type,TextEditingController controller, Key key) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        autofocus: true,
        key: key,
        validator: (value){
          if(value.isEmpty) {
            return 'This field is required.';

          }
        },


        obscureText: labal == 'Password' ? !this._secure : false,


        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Color(0xffE74C3C),width: 0.75),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Color(0xffE74C3C),width: 0.75),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red,width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Color(0xffE74C3C),width: 1.5)
          ),



          labelText: labal,
          focusColor: Colors.grey,
          labelStyle: TextStyle(color: Color(0xffE74C3C),fontSize: 15.0),
          prefixIcon: Icon(icon,size: 20.0,color:checked ? Color(0xffE74C3C):Colors.grey),

          suffixIcon: labal == 'Password' ? IconButton(
            icon: Icon(Icons.remove_red_eye),
            color: this._secure ? Color(0xffE74C3C) : Colors.grey,
            onPressed: (){
              setState(()=> this._secure = !this._secure);
            },
          ) : null
        ),

        textInputAction: TextInputAction.done,
        keyboardType: type,
        controller: controller,
      ),
    );
  }
}




class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailResetController = TextEditingController();
  final GlobalKey<FormFieldState<String>> nameKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> emailKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> passwordKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> confirmPasswordKey = GlobalKey<FormFieldState<String>>();

  final _formKey = GlobalKey<FormState>();

  bool _secure = false;

  DateTime pickedDate;
  TimeOfDay time;

  bool checked = false;

  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          scrollDirection: Axis.vertical,


          children: [
            field('Name', Icons.account_circle, TextInputType.text, nameController, nameKey),
                        field('E-Mail', Icons.email, TextInputType.emailAddress, emailController, emailKey),
                        field('Password', Icons.lock, TextInputType.text, passwordController, passwordKey),
                        field('Confirm Password', Icons.lock, TextInputType.text, confirmPasswordController, confirmPasswordKey),
            
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            ListTile(
                              title: Text(
                                "BirthDate:   ${pickedDate.year}/${pickedDate.month}/${pickedDate.day}",
                                style: TextStyle(color:Color(0xffE74C3C),fontSize: 17.5)),
            
                              trailing: Icon(Icons.keyboard_arrow_down,color: Color(0xffE74C3C),),
                              onTap: _pickDate,
                            ),
                          ],
                        ),
            
            
                        ListTile(
                          title: Text(
                            'Read our Terms & Conditions',
                            style: TextStyle(color: Colors.black54, fontSize: 14.0
                          ),
                        ),
                        trailing: Checkbox(
                          activeColor: Color(0xffE74C3C),
                          checkColor: Colors.white,
                          hoverColor: Color(0xffE74C3C),
            
                          onChanged: (value){
                            setState(() {
                              if(checked == false){
                                return null;
                              }
                              else{
                                checked = value;
                              }
                            });
            
                          },
                          value:checked
                        ),
            
                        onTap: (){
                          setState(() {
                            checked = true;
                          });
            
            
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (BuildContext context){
                              return ListTile(
                                title: Text(
                                  'Our Terms & Conditions\n',
                                style: TextStyle(
                                  color: Color(0xffE74C3C),fontSize: 16.6,fontWeight: FontWeight.bold
                                ),
                                ),
                                subtitle: Text(
                                  'Help protect your website and its users with clear and fair website terms and conditions. These terms and conditions for a website set out key issues such as acceptable use, privacy, cookies, registration and passwords, intellectual property, links to other sites, termination and disclaimers of responsibility. Terms and conditions are used and necessary to protect a website owner from liability of a user relying on the information or the goods provided from the site then suffering a loss.\n',
                                  style: TextStyle(color: Color(0xffE74C3C),fontSize: 13.3),
                                ),
                              );
                            }
                          );
                        },
                        ),
                        Container(padding: EdgeInsets.only(bottom: 10.0)),
            
                        Column(
                          children: [
                            FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                              color: Color(0xffE74C3C),
                              child: Text(
                                '        Sign Up       ',
                                style: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.normal),
                              ),
                              
                              onPressed: (){
                                if(_formKey.currentState.validate()){
                                  Navigator.push(context, 
                                  MaterialPageRoute(builder: (context) => BottomNavBar()),
                                  );
                                }
                                else{
                                  return Scaffold.of(context).showSnackBar(snack('Some fields required!'));
                                }
                              },
            
                             ),
                        ]
                          
                        )        
                      ],
                    ),
                  ),
                );
              }
            
            
              _pickDate()async{
                DateTime date = await showDatePicker(context: context, 
                firstDate: DateTime(DateTime.now().year-25),
                lastDate: DateTime(DateTime.now().year+1),
                initialDate: pickedDate,
                );
            
                if(date != null){
                  setState(() {
                    pickedDate = date;
                  });
                } 
              }
              snack(String content){
                  return SnackBar(
                    content: Text(
                      content,
                      style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.normal),
                    ),
                    backgroundColor: Color(0xffE74C3C),
                    duration: Duration(seconds: 7),
                  );
                }
            
                 field(String label,IconData icon, TextInputType type,TextEditingController controller,Key key){
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      key: key,
                      validator: (value){
                        if(value.isEmpty){
                          return 'This field is required.';
                        }
                      },
            
            
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Color(0xffE74C3C),width: 0.75),
                        ),
                         enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Color(0xffE74C3C),width: 0.75),
                        ),
                         errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Colors.red,width: 1.0),
                        ),
                         focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Color(0xffE74C3C),width: 1.5),
                        ),
            
            
                        labelText: label,
                        labelStyle: TextStyle(color: Color(0xffE74C3C),fontSize: 15.0),
                        prefixIcon: Icon(icon,color: Color(0xffE74C3C),size: 20.0,),
            
            
                        suffixIcon: (label == 'Password') || (label == 'Confirm Password') ? IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          color: this._secure ? Color(0xffE74C3C) : Colors.grey,
                          onPressed: (){
                            setState(() => this._secure =! this._secure);
                          }
                        ): null
                      ),
            
            
            
                      textInputAction: TextInputAction.done,
                      keyboardType: type,
                      controller: controller,
                      obscureText: (label == 'Password') || (label == 'Confirm Password') ? !this._secure : false,
                    ),
                  );
                
              }
            
}