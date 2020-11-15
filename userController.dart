import 'package:intel/models/User/userModel.dart';
import 'package:scoped_model/scoped_model.dart';




class UserController extends Model{




  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;


  UserModel user;





}