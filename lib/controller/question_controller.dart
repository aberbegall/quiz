import '../quiz.dart';

class QuestionController extends HTTPController {
  var questions = [
    "How much wood can a woodchuck chuck?",
    "What's the tallest mountain in the world?"
  ];

  @httpGet getAllQuestions({@HTTPQuery("contains") String containsSubstring: null}) async {
    var questionQuery = new Query<Question>();
    if (containsSubstring != null) {
      questionQuery.matchOn.description = whereContains(containsSubstring);
    }
    var questions = await questionQuery.fetch();
    return new Response.ok(questions);
  }

  @httpGet getQuestionAtIndex(@HTTPPath("index") int index) async {
    var questionQuery = new Query<Question>()
      ..matchOn.index = whereEqualTo(index);

    var question = await questionQuery.fetchOne();

    if (question == null) {
      return new Response.notFound();
    }
    return new Response.ok(question);
  }
}