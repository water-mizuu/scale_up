sealed class TemplateNode {
  const TemplateNode();

  String evaluate(Map<String, String> env);
}

final class MultiNode extends TemplateNode {
  const MultiNode(this.nodes);

  final List<TemplateNode> nodes;

  @override
  String evaluate(Map<String, String> env) {
    return nodes.map((node) => node.evaluate(env)).join();
  }

  @override
  String toString() {
    return "MultiNode(${nodes.map((node) => node.toString()).join(", ")})";
  }
}

final class RawStringNode extends TemplateNode {
  const RawStringNode(this.value);

  final String value;

  @override
  String evaluate(Map<String, String> env) => value;

  @override
  String toString() {
    return "RawStringNode($value)";
  }
}

final class VariableNode extends TemplateNode {
  const VariableNode(this.name);

  final String name;

  @override
  String evaluate(Map<String, String> env) {
    final value = env[name];

    if (value == null) {
      throw Exception("Variable $name not found in environment.");
    }

    return value;
  }

  @override
  String toString() {
    return "VariableNode($name)";
  }
}
