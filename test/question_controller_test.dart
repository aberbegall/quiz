import 'package:test/test.dart';
import 'package:quiz/quiz.dart';

void main() {
  var app = new Application<QuizRequestSink>();
  var client = new TestClient(app);

  setUpAll(() async {
    await app.start(runOnMainIsolate: true);
  });

  tearDownAll(() async {
    await app.stop();
  });

  test("/questions returns list of questions", () async {
    var response = await client.request("/questions").get();
    expect(response, hasResponse(200, everyElement(endsWith("?"))));
  });

  test("/questions/index returns a single question", () async {
    var response = await client.request("/questions/1").get();
    expect(response, hasResponse(200, endsWith("?")));
  });

  test("/questions/index out of range returns 404", () async {
    var response = await client.request("/questions/100").get();
    expect(response, hasStatus(404));
  });
}