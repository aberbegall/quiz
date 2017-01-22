import 'quiz.dart';

class QuizRequestSink extends RequestSink {
  static String ConfigurationKey = "QuizRequestSink.Configuration";

  QuizRequestSink(Map<String, dynamic> options) : super(options) {
    logger.onRecord.listen((rec) => print("$rec"));
    var dataModel = new ManagedDataModel.fromCurrentMirrorSystem();
    var config = options[ConfigurationKey];
    var db = config.database;
    var persistentStore = new PostgreSQLPersistentStore.fromConnectionInfo(db.username, db.password, db.host, db.port, db.databaseName);
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

class QuizConfiguration extends ConfigurationItem {
  QuizConfiguration(String fileName) : super.fromFile(fileName);

  DatabaseConnectionConfiguration database;
}