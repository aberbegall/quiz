import 'package:aqueduct/aqueduct.dart';
import 'dart:async';

void main() {
  var app = new Application<QuizRequestSink>();
  app.start();
}

class QuestionController extends HTTPController {
  var questions = [
    "How much wood can a woodchuck chuck?",
    "What's the tallest mountain in the world?"
  ];

  @httpGet getAllQuestions() async {
    return new Response.ok(questions);
  }

  @httpGet getQuestionAtIndex(@HTTPPath("index") int index) async {
    if (index < 0 || index >= questions.length) {
      return new Response.notFound();
    }

    return new Response.ok(questions[index]);
  }
}

class QuizRequestSink extends RequestSink {
  QuizRequestSink(Map<String, dynamic> options) : super (options);

  @override
  void setupRouter(Router router) {
    router
        .route("/questions/[:index(\\d+)]")
        .generate(() => new QuestionController());
  }
}