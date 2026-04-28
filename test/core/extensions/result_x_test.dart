import 'package:flutter_test/flutter_test.dart';
import 'package:mcp_client/mcp_client.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/core/extensions/result_x.dart';

void main() {
  group('ResultX.toEither', () {
    test('success Result maps to Right', () {
      final result = Result<String, Exception>.success('hello');
      final either = result.toEither();

      expect(either.isRight(), isTrue);
      expect(either.getOrElse((_) => ''), equals('hello'));
    });

    test('McpError maps to Left<ProtocolFailure>', () {
      final mcpError = McpError('Invalid request', code: -32600);
      final result = Result<String, McpError>.failure(mcpError);
      final either = result.toEither();

      expect(either.isLeft(), isTrue);
      either.fold((failure) {
        expect(failure, isA<ProtocolFailure>());
        final pf = failure as ProtocolFailure;
        expect(pf.code, equals(-32600));
        expect(pf.message, equals('Invalid request'));
      }, (_) => fail('Expected Left'));
    });

    test('generic error maps to Left<UnknownFailure>', () {
      final result = Result<int, Exception>.failure(Exception('boom'));
      final either = result.toEither();

      expect(either.isLeft(), isTrue);
      either.fold(
        (failure) => expect(failure, isA<UnknownFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });
}
