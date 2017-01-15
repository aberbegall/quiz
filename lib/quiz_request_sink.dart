import 'quiz.dart';

class QuizRequestSink extends RequestSink {
  QuizRequestSink(Map<String, dynamic> options) : super(options);

  @override
  void setupRouter(Router router) {
    router
        .route("/questions/[:index(\\d+)]")
        .generate(() => new QuestionController());
  }
}