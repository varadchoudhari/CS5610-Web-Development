defmodule Calc do
  def main() do
    i = IO.gets ">"
    trim = String.trim(i, "\n")
    answer = eval(trim)
    IO.puts answer
    main()
  end

  #############################################################################

  def eval(string) do
    operators = []
    values = []
    String.replace(string, "(", " ( ")
    |> String.replace(")", " ) ")
    |> String.replace("+", " + ")
    |> String.replace("-", " - ")
    |> String.replace("*", " * ")
    |> String.replace("/", " / ")
    |> String.split(" ")
    |> Enum.filter(fn(n) -> n != " " end)
    |> Enum.filter(fn(n) -> n != "" end)
    |> for_loop(operators, values)
  end

  #############################################################################

  def popOperands(values) do
    {operand1, rest1} = List.pop_at(values, -1)
    {operand2, rest2} = List.pop_at(rest1, -1)
    {operand1, operand2, rest2}
  end

  #############################################################################

  def whileNotLeftParanthesis(list, operators, values) do
    {op, value} = loopGetOperator(list, length(operators), operators, values)
    {op, value}
  end

  #############################################################################

  def hasGreaterPrecedence(op1, op2) do
    has = cond do
      op1 == "*" and op2 == "+" -> true
      op1 == "*" and op2 == "-" -> true
      op1 == "/" and op2 == "+" -> true
      op1 == "/" and op2 == "-" -> true
      op1 == "*" and op2 == "/" -> true
      true -> false
    end
    has
  end

  #############################################################################

  def getStringValues(val1, val2) do
    v1 = if is_integer(val1) do
      Integer.to_string(val1)
    else
      val1
    end

    v2 = if is_integer(val2) do
      Integer.to_string(val2)
    else
      val2
    end
    {v1,v2}
  end

  #############################################################################

  def checkOperatorAndPerform(op, val1, val2) do
    {v1, v2} = getStringValues(val1, val2)
    answer = cond do
      op == "+" -> String.to_integer(v2) + String.to_integer(v1)
      op == "-" -> String.to_integer(v2) - String.to_integer(v1)
      op == "*" -> String.to_integer(v2) * String.to_integer(v1)
      true -> div(String.to_integer(v2), String.to_integer(v1))
    end
    answer
  end

  #############################################################################

  def loopGetOperator(list, length, operators, values) do
    if Enum.at(operators, length - 1) == "(" do
      {_,listWithoutBracket} = List.pop_at(operators,-1)
      {listWithoutBracket, values}
    else
      {op,rest} = List.pop_at(operators,-1)
      {operand1,operand2, restOperands} = popOperands(values)
      ans = checkOperatorAndPerform(op,operand1,operand2)
      loopGetOperator(list, length - 1, rest, restOperands ++ [ans])
    end
  end

  #############################################################################

  def for_loop(list, operators, values) do
    loop(list,length(list), operators, values)
  end

  #############################################################################

  def processUntilOperatorIsEmpty(opr, values) do
    loopUntilOperatorIsEmpty(opr, length(opr), values)
  end

  #############################################################################

  def loopUntilOperatorIsEmpty(opr, oprLength, values) do
    if oprLength == 0 do
      Enum.at(values,0)
    else
      {oper, restopr} = List.pop_at(opr, -1)
      {val1, val2, restval2} = popOperands(values)
      ans = checkOperatorAndPerform(oper, val1, val2)
      loopUntilOperatorIsEmpty(restopr, oprLength - 1, restval2 ++ [ans])
    end
  end

  #############################################################################

  def checkOpStack(currentOp, operators, length, values) do
    {topOp, restOf} = List.pop_at(operators, -1)
    if length == 0 or hasGreaterPrecedence(currentOp,topOp) or topOp == "(" do
      {operators ++ [currentOp], values}
    else
      {val1Plus, val2Plus, valRest2Plus} = popOperands(values)
      ans = checkOperatorAndPerform(topOp, val1Plus, val2Plus)
      checkOpStack(currentOp, restOf, length(restOf), valRest2Plus ++ [ans])
    end
  end

  #############################################################################

  def doCalculations(op, operators, values) do
    {currentOp, restOp} = List.pop_at(operators, -1)
    {val1, val2, restVal} = popOperands(values)
    ans = checkOperatorAndPerform(currentOp, val1, val2)
    {newOp, newVal} = checkOpStack(op, restOp, length(restOp), restVal ++ [ans])
    {newOp, newVal}
  end

  #############################################################################

  def ifGreaterPrecedence(op, curOp, operators, values, list, length) do
    if hasGreaterPrecedence(curOp, op) or curOp == "-" or curOp == "+" do
      {newOperators, newValues} = doCalculations(op, operators, values)
      loop(list, length - 1, newOperators, newValues)
    else
      loop(list, length - 1, operators ++ [op], values)
    end
  end

  #############################################################################

  def ifGreaterPrecedenceMultDiv(op, curOp, operators, values, list, length) do
    if hasGreaterPrecedence(curOp, op) or curOp == "*" or curOp == "/" do
      {newOperators, newValues} = doCalculations(op, operators, values)
      loop(list, length - 1, newOperators, newValues)
    else
      loop(list, length - 1, operators ++ [op], values)
    end
  end

  #############################################################################

  def plus(list, length, operators, values) do
    if length(operators) > 0 do
      {opPlus, _} = List.pop_at(operators, -1)
      ifGreaterPrecedence("+", opPlus, operators, values, list, length)
    else
      loop(list, length - 1, operators ++ ["+"], values)
    end
  end

  #############################################################################

  def minus(list, length, operators, values) do
    if length(operators) > 0 do
      {opMinus, _} = List.pop_at(operators, -1)
      ifGreaterPrecedence("-", opMinus, operators, values, list, length)
    else
      loop(list, length - 1, operators ++ ["-"], values)
    end
  end

  #############################################################################

  def multiply(list, length, operators, values) do
    if length(operators) > 0 do
      {opMult, _} = List.pop_at(operators, -1)
      ifGreaterPrecedenceMultDiv("*", opMult, operators, values, list, length)
    else
      loop(list, length - 1, operators ++ ["*"], values)
    end
  end

  #############################################################################

  def divide(list, length, operators, values) do
    if length(operators) > 0 do
      {opDiv, _} = List.pop_at(operators, -1)
      ifGreaterPrecedenceMultDiv("/", opDiv, operators, values, list, length)
    else
      loop(list, length - 1, operators ++ ["/"], values)
    end
  end

  #############################################################################

  def closingBracket(list, length, operators, values) do
    if Enum.at(list,length(list) - length) == ")" do
      {operator, operand} = whileNotLeftParanthesis(list, operators, values)
      loop(list, length - 1, operator, operand)
    else
      v = Enum.at(list,length(list) - length)
      loop(list, length - 1, operators, values ++ [v])
    end
  end

  #############################################################################

  def loop(list, length, operators, values) do
    if length == 0 do
      processUntilOperatorIsEmpty(operators, values)
    else
      cond do
        Enum.at(list,length(list) - length) == "+" ->
          plus(list, length, operators, values)
        Enum.at(list,length(list) - length) == "-" ->
          minus(list, length, operators, values)
        Enum.at(list,length(list) - length) == "*" ->
          multiply(list, length, operators, values)
        Enum.at(list,length(list) - length) == "/" ->
          divide(list, length, operators, values)
        Enum.at(list,length(list) - length) == "(" ->
          loop(list, length - 1, operators ++ ["("], values)
        true ->
          closingBracket(list, length, operators, values)
      end
    end
  end
end
