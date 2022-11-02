import 'package:socure/models/socure_error_result.dart';
import 'package:socure/models/socure_success_result.dart';

typedef OnSuccessCallback = void Function(SocureSuccessResult data);
typedef OnErrorCallback = void Function(SocureErrorResult data);
