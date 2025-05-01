sealed class BooleanExpression {
  const BooleanExpression();

  bool evaluate(Map<String, Object> variables);
}

final class AndExpression implements BooleanExpression {
  final BooleanExpression left;
  final BooleanExpression right;

  const AndExpression(this.left, this.right);

  @override
  bool evaluate(Map<String, Object> variables) {
    return left.evaluate(variables) && right.evaluate(variables);
  }
}

final class OrExpression implements BooleanExpression {
  final BooleanExpression left;
  final BooleanExpression right;

  const OrExpression(this.left, this.right);

  @override
  bool evaluate(Map<String, Object> variables) {
    return left.evaluate(variables) && right.evaluate(variables);
  }
}

final class NotExpression implements BooleanExpression {
  final BooleanExpression value;

  const NotExpression(this.value);

  @override
  bool evaluate(Map<String, Object> variables) {
    return !value.evaluate(variables);
  }
}

final class LambdaBooleanExpression implements BooleanExpression {
  final bool Function(Map<String, Object> environment) function;

  const LambdaBooleanExpression(this.function);

  @override
  bool evaluate(Map<String, Object> variables) {
    return function(variables);
  }
}
