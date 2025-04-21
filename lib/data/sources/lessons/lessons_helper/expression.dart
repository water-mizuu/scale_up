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

  O captureGeneric<O>(O Function<E>() f);

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

  BinaryExpression makeCopy(Expression left, Expression right) {
    return switch (this) {
      AdditionExpression() => AdditionExpression(left, right),
      SubtractionExpression() => SubtractionExpression(left, right),
      MultiplicationExpression() => MultiplicationExpression(left, right),
      DivisionExpression() => DivisionExpression(left, right),
      PowerExpression() => PowerExpression(left, right),
      LogarithmExpression() => LogarithmExpression(left, right),
    };
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

  @override
  O captureGeneric<O>(O Function<E>() f) => f<AdditionExpression>();
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

  @override
  O captureGeneric<O>(O Function<E>() f) => f<SubtractionExpression>();
}

final class MultiplicationExpression extends BinaryExpression {
  const MultiplicationExpression(super.left, super.right);

  @override
  num evaluate(Map<String, num> variables) =>
      left.evaluate(variables) * right.evaluate(variables);

  @override
  Expression substitute(String id, Expression expression) =>
      MultiplicationExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} * ${right.string}";

  @override
  O captureGeneric<O>(O Function<E>() f) => f<MultiplicationExpression>();
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

  @override
  O captureGeneric<O>(O Function<E>() f) => f<DivisionExpression>();
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

  @override
  O captureGeneric<O>(O Function<E>() f) => f<PowerExpression>();
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

  @override
  O captureGeneric<O>(O Function<E>() f) => f<LogarithmExpression>();
}

sealed class UnaryExpression extends Expression {
  final Expression operand;

  const UnaryExpression(this.operand);

  @override
  get variables sync* {
    yield* operand.variables;
  }

  UnaryExpression makeCopy(Expression operand) {
    return switch (this) {
      NegationExpression() => NegationExpression(operand),
    };
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

  @override
  O captureGeneric<O>(O Function<E>() f) => f<NegationExpression>();
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

  @override
  O captureGeneric<O>(O Function<E>() f) => f<ConstantExpression>();
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

  @override
  O captureGeneric<O>(O Function<E>() f) => f<VariableExpression>();
}

extension ExpressionList on List<Expression> {
  num evaluate(num from) {
    return fold(from, (value, expr) => expr.evaluate({"from": value}));
  }
}

extension CustomExpressionExtension on Expression {
  static final Random _random = Random();

  Expression mutate([double probability = 0.5]) {
    var atari = _random.nextDouble();

    var shouldMutate = atari < probability;
    if (this case BinaryExpression(:var left, :var right) && var self) {
      var thing = {
        AdditionExpression.new,
        SubtractionExpression.new,
        MultiplicationExpression.new,
        DivisionExpression.new,
        PowerExpression.new,
      };

      if (shouldMutate) {
        BinaryExpression mutated;

        do {
          var chosen = thing.elementAt(_random.nextInt(thing.length));
          mutated = chosen(left.mutate(sqrt(probability)), right.mutate(sqrt(probability)));
        } while (mutated.captureGeneric(<T>() => this is T));

        return mutated;
      } else {
        return self.makeCopy(left.mutate(), right.mutate());
      }
    } else if (this case UnaryExpression(:var operand) && var self) {
      return self.makeCopy(operand.mutate(sqrt(probability)));
    } else if (this case ConstantExpression(:var value) when shouldMutate) {
      return ConstantExpression((value * Random().nextDouble() + 0.01).roundToDouble());
    }

    return this;
  }

  Iterable<ConstantExpression> get constants sync* {
    var self = this;
    if (self case BinaryExpression(:var left, :var right)) {
      yield* left.constants;
      yield* right.constants;
    } else if (self case UnaryExpression(:var operand)) {
      yield* operand.constants;
    } else if (self case ConstantExpression()) {
      yield self;
    }
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
