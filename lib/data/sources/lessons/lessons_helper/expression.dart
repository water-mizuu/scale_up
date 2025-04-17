import "dart:math";

/// A simple mathematical expression evaluator.
sealed class Expression {
  const Expression();

  num evaluate(Map<String, num> variables);
  Expression substitute(String id, Expression expression);
  Iterable<VariableExpression> get variables;
  String get str;

  @override
  String toString() => str;

  static (Expression, VariableExpression) inverse(VariableExpression left, Expression right) {
    var lhs = left as Expression;
    var rhs = right;

    assert(
      rhs.variables.where((v) => v.str == "from").length == 1,
      "There should only be single 'from' variables!",
    );

    while (rhs is BinaryExpression) {
      var BinaryExpression(:left, :right) = rhs;
      var isLeftHoldingVariable = left.variables.where((v) => v.str == "from").isNotEmpty;

      switch (rhs) {
        /// This case occurs when the variable is on the left.
        case AdditionExpression() when isLeftHoldingVariable:
          lhs = SubtractionExpression(lhs, right);
          rhs = left;

        /// This case occurs when the variable is on the right.
        case AdditionExpression():
          lhs = SubtractionExpression(lhs, left);
          rhs = right;

        /// This case occurs when the variable is on the left.
        case SubtractionExpression() when isLeftHoldingVariable:
          lhs = AdditionExpression(lhs, right);
          rhs = left;

        /// This case occurs when the variable is on the right.
        /// lhs = l - x
        /// lhs - l = - x
        /// l - lhs = x
        case SubtractionExpression():
          lhs = SubtractionExpression(left, lhs);
          rhs = right;

        /// This case occurs when the variable is on the left.
        /// lhs = xa
        case MultiplicationExpression() when isLeftHoldingVariable:
          lhs = DivisionExpression(lhs, right);
          rhs = left;

        /// This case occurs when the variable is on the right.
        case MultiplicationExpression():
          lhs = DivisionExpression(lhs, left);
          rhs = right;

        /// This case occurs when the variable is on the left.
        /// lhs = x/a
        case DivisionExpression() when isLeftHoldingVariable:
          lhs = MultiplicationExpression(lhs, right);
          rhs = left;

        /// This case occurs when the variable is on the right.
        /// lhs = a/x
        /// 1 / lhs = x/a
        /// a / lhs = x
        case DivisionExpression():
          lhs = DivisionExpression(left, lhs);
          rhs = right;

        /// This case occurs when the variable is on the left.
        /// lhs = x^a
        case PowerExpression() when isLeftHoldingVariable:
          lhs = PowerExpression(lhs, DivisionExpression(ConstantExpression(1), right));
          rhs = left;

        /// This case occurs when the variable is on the right.
        /// lhs = a^x
        /// log[a](lhs) = x
        case PowerExpression():
          lhs = LogarithmExpression(left, lhs);
          rhs = right;

        /// This occurs when the variable is on the left (it is the base.)
        /// lhs = log[x](a)
        /// lhs = ln(a)/ln(x)
        /// 1 / lhs = ln(x) / ln(a)
        /// ln(a) / lhs = ln(x)
        /// e^(ln(a) / lhs) = x
        case LogarithmExpression() when isLeftHoldingVariable:
          lhs = PowerExpression(
            ConstantExpression(e),
            DivisionExpression(LogarithmExpression(ConstantExpression(e), right), lhs),
          );
          rhs = left;

        /// This occurs when the variable is on the right (it is the power.)
        /// lhs = log[a](x)
        /// a^lhs = x
        case LogarithmExpression():
          lhs = PowerExpression(lhs, left);
          rhs = right;
      }
    }

    if (rhs is! VariableExpression) {
      throw Error();
    }

    return (lhs, rhs);
  }
}

sealed class BinaryExpression extends Expression {
  final Expression left;
  final Expression right;

  const BinaryExpression(this.left, this.right);

  @override
  get variables sync* {
    yield* left.variables;
    yield* right.variables;
  }
}

final class AdditionExpression extends BinaryExpression {
  const AdditionExpression(super.left, super.right);

  @override
  num evaluate(Map<String, num> variables) =>
      left.evaluate(variables) + right.evaluate(variables);

  @override
  Expression substitute(String id, Expression expression) =>
      AdditionExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} + ${right.string}";
}

final class SubtractionExpression extends BinaryExpression {
  const SubtractionExpression(super.left, super.right);

  @override
  num evaluate(Map<String, num> variables) =>
      left.evaluate(variables) - right.evaluate(variables);

  @override
  Expression substitute(String id, Expression expression) =>
      SubtractionExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} - ${right.string}";
}

final class MultiplicationExpression extends BinaryExpression {
  const MultiplicationExpression(super.left, super.right);

  @override
  num evaluate(Map<String, num> variables) =>
      left.evaluate(variables) * right.evaluate(variables);

  @override
  Expression substitute(String id, Expression expression) => MultiplicationExpression(
    left.substitute(id, expression),
    right.substitute(id, expression),
  );

  @override
  get str => "${left.string} * ${right.string}";
}

final class DivisionExpression extends BinaryExpression {
  const DivisionExpression(super.left, super.right);

  @override
  num evaluate(Map<String, num> variables) =>
      left.evaluate(variables) / right.evaluate(variables);

  @override
  Expression substitute(String id, Expression expression) =>
      DivisionExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} / ${right.string}";
}

final class PowerExpression extends BinaryExpression {
  const PowerExpression(super.left, super.right);

  @override
  num evaluate(Map<String, num> variables) =>
      pow(left.evaluate(variables), right.evaluate(variables));

  @override
  Expression substitute(String id, Expression expression) =>
      PowerExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} ^ ${right.string}";
}

final class LogarithmExpression extends BinaryExpression {
  const LogarithmExpression(super.left, super.right);

  @override
  num evaluate(Map<String, num> variables) =>
      log(right.evaluate(variables)) / log(left.evaluate(variables));

  @override
  Expression substitute(String id, Expression expression) =>
      LogarithmExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "log[${left.string}](${right.string})";
}

sealed class UnaryExpression extends Expression {
  final Expression operand;

  const UnaryExpression(this.operand);

  @override
  get variables sync* {
    yield* operand.variables;
  }
}

final class NegationExpression extends UnaryExpression {
  const NegationExpression(super.operand);

  @override
  num evaluate(Map<String, num> variables) => -operand.evaluate(variables);

  @override
  Expression substitute(String id, Expression expression) =>
      NegationExpression(operand.substitute(id, expression));

  @override
  get str => "-${operand.string}";
}

final class ConstantExpression extends Expression {
  final num value;

  const ConstantExpression(this.value);

  @override
  num evaluate(Map<String, num> variables) => value;

  @override
  Expression substitute(String id, Expression expression) => this;

  @override
  get variables sync* {}

  @override
  get str => "$value";
}

final class VariableExpression extends Expression {
  final String variable;

  const VariableExpression(this.variable);

  @override
  num evaluate(Map<String, num> variables) => variables[variable] ?? 0;

  @override
  Expression substitute(String id, Expression expression) => variable == id ? expression : this;

  @override
  get variables sync* {
    yield this;
  }

  @override
  get str => variable;
}

extension ExpressionList on List<Expression> {
  num evaluate(num from) {
    return fold(from, (value, expr) => expr.evaluate({"from": value}));
  }
}

extension on Expression {
  String get string {
    var string = toString();

    if (string.contains(" ")) {
      return "($string)";
    } else {
      return string;
    }
  }
}
