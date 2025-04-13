import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/firebase/firestore_helper.dart";
import "package:scale_up/presentation/bloc/HomePage/home_page_state.dart";

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({required FirestoreHelper firestoreHelper})
    : _firestoreHelper = firestoreHelper,
      super(HomePageState());

  final FirestoreHelper _firestoreHelper;
}
