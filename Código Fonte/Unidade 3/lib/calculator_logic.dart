import 'package:expressions/expressions.dart';

class Logic {
  String currentExpression = "";
  String currentNumber = "";
  String currentOperator = "";
  bool allowFloat = true;
  final void Function() updateDisplay;

  Logic(this.updateDisplay);

  void numberFunction(String number) {
    if (currentOperator != "") {
      currentOperator = "";
    }
    // Ao colocarmos um ponto, não permitiremos outro até que haja um novo operador
    // Além disso, verificamos se há números na tela
    if (number == ".") {
      if (!allowFloat || currentNumber == "") {
        return;
      }
      allowFloat = false;
    }
    currentNumber += number;
    currentExpression += number;

    updateDisplay();
  }

  void operationFunction(String operation) {
    // Não fará nada se não houver nada na tela
    if (currentExpression == "") {
      return;
    }

    // Agora podem existir números com ponto
    allowFloat = true;
    // Agora podemos ter um novo número
    currentNumber = "";

    // Lógica de igualdade
    if (operation == "=") {
      // Verifica se a expressão está completa
      if ("*+-/".contains(currentExpression[currentExpression.length - 2])) {
        return;
      } else if ("."
          .contains(currentExpression[currentExpression.length - 1])) {
        return;
      }

      currentExpression = result();
      currentNumber = result();
      updateDisplay();

      // Tratamento para divisão por zero
      if (currentExpression == "Infinity" || currentExpression == "NaN") {
        currentExpression = "";
        currentNumber = "";
      }

      // Caso o resultado seja decimal, não permitiremos ponto nesse número
      if (currentExpression.contains(".")) {
        allowFloat = false;
      }

      return;
    }
    if (".".contains(currentExpression[currentExpression.length - 1])) {
      return;
    }

    // Caso não haja operador, adiciona o selecionado
    if (currentOperator == "") {
      currentOperator = operation;
      currentExpression += " $operation ";
      // Caso haja, substitui
    } else {
      currentExpression = currentExpression.replaceRange(
          currentExpression.length - 2,
          currentExpression.length - 1,
          operation);
      currentOperator = operation;
    }
    updateDisplay();
  }

  dynamic result() {
    Expression expression = Expression.parse(currentExpression);
    const evaluator = ExpressionEvaluator();
    var result = evaluator.eval(expression, {}).toString();

    return result;
  }

  void clear() {
    currentExpression = "";
    currentNumber = "";
    currentOperator = "";

    updateDisplay();
  }
}
