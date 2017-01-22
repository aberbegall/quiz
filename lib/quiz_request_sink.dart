import 'quiz.dart';

class QuizRequestSink extends RequestSink {
  QuizRequestSink(Map<String, dynamic> options) : super(options) {
    // var dataModel = new ManagedDataModel.fromPackageContainingType(QuizRequestSink);
    var dataModel = new ManagedDataModel.fromCurrentMirrorSystem();

    var persistentStore = new PostgreSQLPersistentStore.fromConnectionInfo("dart", "dart", "localhost", 5432, "dart_test");
    context = new ManagedContext(dataModel, persistentStore);
  }

  ManagedContext context;

  @override
  void setupRouter(Router router) {
    router
        .route("/questions/[:index(\\d+)]")
        .generate(() => new QuestionController());
  }
}