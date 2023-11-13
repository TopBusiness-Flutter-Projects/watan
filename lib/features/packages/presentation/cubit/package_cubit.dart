import 'package:elwatn/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/package_data_model.dart';
import '../../domain/entities/add_package_model.dart';
import '../../domain/entities/package_domain_model.dart';
import '../../domain/use_cases/add_package_use_case.dart';
import '../../domain/use_cases/package_use_case.dart';
part 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  PackageCubit(this.getPackageUseCase, this.addPackageUseCase)
      : super(PackageInitial()) {
    getPackageList();
  }

  final GetPackageUseCase getPackageUseCase;
  final AddPackageUseCase addPackageUseCase;
  PackageDatumModel? onePackage;

  getPackageList() async {
    emit(PackageLoading());
    final response = await getPackageUseCase(NoParams());
    emit(
      response.fold(
        (failure) => PackageError(),
        (package) => PackageLoaded(package),
      ),
    );
  }

  addPackage(int userId, String token, String paymentType) async {
    emit(PackageLoading());
    final response = await addPackageUseCase(
      AddPackageModel(
        userId: userId,
        packageId: onePackage!.id,
        paymentType: paymentType,
        token: token,
      ),
    );
    emit(
      response.fold(
        (failure) => PackageError(),
        (package) => AddPackageLoaded(package),
      ),
    );
  }

  disposePage() {
    Future.delayed(Duration(seconds: 1), () {
      emit(PageDispose());
    });
  }
}
