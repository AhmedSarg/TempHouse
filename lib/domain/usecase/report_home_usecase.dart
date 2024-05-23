import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ReportHomeUseCase extends BaseUseCase<ReportHomeUseCaseInput, void> {
  final Repository _repository;

  ReportHomeUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(ReportHomeUseCaseInput input) async {
    return _repository.reportHome(
      userId: input.userId,
      homeId: input.homeId,
      report: input.report,
      submittedAt: input.submittedAt,
    );
  }
}

class ReportHomeUseCaseInput {
  final String userId;
  final String homeId;
  final String report;
  final DateTime submittedAt;

  ReportHomeUseCaseInput({
    required this.userId,
    required this.homeId,
    required this.report,
    required this.submittedAt,
  });
}
