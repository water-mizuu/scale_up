import "dart:math";

/// A simple mathematical expression evaluator.
sealed class NumericalExpression {
  const NumericalExpression();

  static const int significantDigits = 5;

  num evaluate(Map<String, Object> variables);
  NumericalExpression substitute(String id, NumericalExpression expression);
  NumericalExpression substituteString(String id, String expression) =>
      substitute(id, VariableExpression(expression));

  Iterable<VariableExpression> get variables;
  String get str;

  @override
  String toString() => str;

  O captureGeneric<O>(O Function<E>() f);

  String toLatex() {
    return switch (this) {
      ConstantExpression(:var value) => value.toString(),
      VariableExpression(:var variable) => variable,
      AdditionExpression(:var left, :var right) => "${left.toLatex()} + ${right.toLatex()}",
      SubtractionExpression(:var left, :var right) => "${left.toLatex()} - ${right.toLatex()}",
      MultiplicationExpression(:var left, :var right) => "${left.toLatex()} * ${right.toLatex()}",
      DivisionExpression(:var left, :var right) =>
        "\\frac{${left.toLatex()}}{${right.toLatex()}}",
      PowerExpression(:var left, :var right) => "${left.toLatex()}^{${right.toLatex()}}",
      LogarithmExpression(:var left, :var right) =>
        "\\log_{${left.toLatex()}}(${right.toLatex()})",
      NegationExpression(:var operand) => "-${operand.toLatex()}",
    };
  }

  static (NumericalExpression, VariableExpression) inverse(
    VariableExpression left,
    NumericalExpression right,
  ) {
    var lhs = left as NumericalExpression;
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
          lhs = PowerExpression(lhs, DivisionExpression(const ConstantExpression(1), right));
          rhs = left;

        /// This case occurs when the variable is on the right.
        /// lhs = a^x
        /// log[a](lhs) = x
        case PowerExpression():
          lhs = LogarithmExpression(left, lhs);
          rhs = right;

        /// This occurs when the variable is on the left (it is the base.)
        /// lhs                  = log[x](a)
        /// lhs                  = ln(a)/ln(x)
        /// 1 / lhs              = ln(x) / ln(a)
        /// ln(a) / lhs          = ln(x)
        /// e^(ln(a) / lhs)      = x
        /// (e^(ln a))^(1 / lhs) = x
        /// a^(1 / lhs)          = x
        case LogarithmExpression() when isLeftHoldingVariable:
          lhs = PowerExpression(right, DivisionExpression(const ConstantExpression(1), left));
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

  static String? toLeftEnglish(NumericalExpression expr) {
    // 1. Walk down the left-aligned chain and collect nodes
    var chain = <BinaryExpression>[];
    var current = expr;
    while (current is BinaryExpression) {
      chain.add(current);
      current = current.left;
    }

    // 2. Process in root-to-leaf order (chain[0] is the outermost, chain.last is the deepest)
    var parts = <String>[];
    for (var node in chain.reversed) {
      // Determine verb
      var verb = switch (node) {
        AdditionExpression() => "add",
        SubtractionExpression() => "subtract",
        MultiplicationExpression() => "multiply it by",
        DivisionExpression() => "divide it by",
        PowerExpression(right: ConstantExpression(value: 2)) => "square it",
        PowerExpression(right: ConstantExpression(value: 3)) => "cube it",
        PowerExpression() => "raise it to the power of",
        _ => null,
      };

      if (verb == null) {
        return null;
      }

      // Render operand
      var right = node.right;
      var operand = right.str;

      parts.add("$verb $operand");
    }

    // 3, Join with ", then "
    if (parts.isEmpty) {
      return null;
    }
    return parts.join(", then ");
  }
}

sealed class BinaryExpression extends NumericalExpression {
  final NumericalExpression left;
  final NumericalExpression right;

  const BinaryExpression(this.left, this.right);

  @override
  get variables sync* {
    yield* left.variables;
    yield* right.variables;
  }

  BinaryExpression makeCopy(NumericalExpression left, NumericalExpression right) {
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
  num evaluate(Map<String, Object> variables) =>
      left.evaluate(variables) + right.evaluate(variables);

  @override
  NumericalExpression substitute(String id, NumericalExpression expression) =>
      AdditionExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} + ${right.string}";

  @override
  O captureGeneric<O>(O Function<E>() f) => f<AdditionExpression>();
}

final class SubtractionExpression extends BinaryExpression {
  const SubtractionExpression(super.left, super.right);

  @override
  num evaluate(Map<String, Object> variables) =>
      left.evaluate(variables) - right.evaluate(variables);

  @override
  NumericalExpression substitute(String id, NumericalExpression expression) =>
      SubtractionExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} - ${right.string}";

  @override
  O captureGeneric<O>(O Function<E>() f) => f<SubtractionExpression>();
}

final class MultiplicationExpression extends BinaryExpression {
  const MultiplicationExpression(super.left, super.right);

  @override
  num evaluate(Map<String, Object> variables) =>
      left.evaluate(variables) * right.evaluate(variables);

  @override
  NumericalExpression substitute(String id, NumericalExpression expression) =>
      MultiplicationExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} * ${right.string}";

  @override
  O captureGeneric<O>(O Function<E>() f) => f<MultiplicationExpression>();
}

final class DivisionExpression extends BinaryExpression {
  const DivisionExpression(super.left, super.right);

  @override
  num evaluate(Map<String, Object> variables) =>
      left.evaluate(variables) / right.evaluate(variables);

  @override
  NumericalExpression substitute(String id, NumericalExpression expression) =>
      DivisionExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} / ${right.string}";

  @override
  O captureGeneric<O>(O Function<E>() f) => f<DivisionExpression>();
}

final class PowerExpression extends BinaryExpression {
  const PowerExpression(super.left, super.right);

  @override
  num evaluate(Map<String, Object> variables) =>
      pow(left.evaluate(variables), right.evaluate(variables));

  @override
  NumericalExpression substitute(String id, NumericalExpression expression) =>
      PowerExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "${left.string} ^ ${right.string}";

  @override
  O captureGeneric<O>(O Function<E>() f) => f<PowerExpression>();
}

final class LogarithmExpression extends BinaryExpression {
  const LogarithmExpression(super.left, super.right);

  @override
  num evaluate(Map<String, Object> variables) =>
      log(right.evaluate(variables)) / log(left.evaluate(variables));

  @override
  NumericalExpression substitute(String id, NumericalExpression expression) =>
      LogarithmExpression(left.substitute(id, expression), right.substitute(id, expression));

  @override
  get str => "log[${left.string}](${right.string})";

  @override
  O captureGeneric<O>(O Function<E>() f) => f<LogarithmExpression>();
}

sealed class UnaryExpression extends NumericalExpression {
  final NumericalExpression operand;

  const UnaryExpression(this.operand);

  @override
  get variables sync* {
    yield* operand.variables;
  }

  UnaryExpression makeCopy(NumericalExpression operand) {
    return switch (this) {
      NegationExpression() => NegationExpression(operand),
    };
  }
}

final class NegationExpression extends UnaryExpression {
  const NegationExpression(super.operand);

  @override
  num evaluate(Map<String, Object> variables) => -operand.evaluate(variables);

  @override
  NumericalExpression substitute(String id, NumericalExpression expression) =>
      NegationExpression(operand.substitute(id, expression));

  @override
  get str => "-${operand.string}";

  @override
  O captureGeneric<O>(O Function<E>() f) => f<NegationExpression>();
}

final class ConstantExpression extends NumericalExpression {
  final num value;

  const ConstantExpression(this.value);

  @override
  num evaluate(Map<String, Object> variables) => value;

  @override
  NumericalExpression substitute(String id, NumericalExpression expression) => this;

  @override
  get variables sync* {}

  @override
  get str => "$value";

  @override
  O captureGeneric<O>(O Function<E>() f) => f<ConstantExpression>();
}

final class VariableExpression extends NumericalExpression {
  final String variable;

  const VariableExpression(this.variable);

  @override
  num evaluate(Map<String, Object> variables) => variables[variable] as num? ?? 0;

  @override
  NumericalExpression substitute(String id, NumericalExpression expression) =>
      variable == id ? expression : this;

  @override
  get variables sync* {
    yield this;
  }

  @override
  get str => variable;

  @override
  O captureGeneric<O>(O Function<E>() f) => f<VariableExpression>();
}

extension ExpressionList on List<NumericalExpression> {
  num evaluate(num from, {int significantDigits = NumericalExpression.significantDigits}) {
    return fold(from, (value, expr) => expr.evaluate({"from": value}));
  }
}

extension CustomExpressionExtension on NumericalExpression {
  static final Random _random = Random();

  NumericalExpression mutate({double probability = 0.5}) {
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
          mutated = chosen(
            left.mutate(probability: sqrt(probability)),
            right.mutate(probability: sqrt(probability)),
          );
        } while (mutated.captureGeneric(<T>() => this is T));

        return mutated;
      } else {
        return self.makeCopy(left.mutate(), right.mutate());
      }
    } else if (this case UnaryExpression(:var operand) && var self) {
      return self.makeCopy(operand.mutate(probability: sqrt(probability)));
    } else if (this case ConstantExpression(:var value) when shouldMutate) {
      /// WARNING: This does not work for exponential values.
      var significantDigits = value.computeDecimalPlaces();
      var mutated = value * (Random().nextDouble() + 0.01);
      if (significantDigits == 0) {
        return ConstantExpression(mutated.floorToDouble());
      }

      var truncated = mutated.toStringAsPrecision(significantDigits);
      var parsed = double.parse(truncated);

      return ConstantExpression(parsed);
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

extension on NumericalExpression {
  String get string {
    var string = toString();

    if (string.contains(" ")) {
      return "($string)";
    } else {
      return string;
    }
  }
}

extension on num {
  int computeDecimalPlaces() {
    if (this is int) {
      return 0;
    }

    var str = toString();
    return str.split(".").last.length + 1;
  }
}
