defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "test1" do
    assert Calc.eval("23+54/38+9-(3-4)") == 34
  end
  test "test2" do
    assert Calc.eval("4+6/2*5+(34+7+(64+7+(44-2+77+(5*5))))") == 275
  end
  test "test3" do
    assert Calc.eval("737+324-32+45/2*3+(234+32-(23+5))") == 1333
  end
  test "test4" do
    assert Calc.eval("72-234*45/42") == -178
  end
  test "test5" do
    assert Calc.eval("73+34-(3*5*4*3*1/2)") == 17
  end
  test "test6" do
    assert Calc.eval("728+75/55+32+(23+2*(3+2-1))") == 792
  end
  test "test7" do
    assert Calc.eval("8+3-2+1+(4-2*4/2)/(1+24-5)") == 10
  end
  test "test8" do
    assert Calc.eval("73-2+5*243+23*5/10") == 1297
  end
  test "test9" do
    assert Calc.eval("73+54+(23+1)/2+(53*23)+(234+6)-3232+324*(234-3)") == 73210
  end
  test "test10" do
    assert Calc.eval("73-33+324-47+(234+27)-73/324+324-23") == 879
  end
  test "test11" do
    assert Calc.eval("35-38+2387+(234/234)+347*0") == 2385
  end
  test "test12" do
    assert Calc.eval("636+347-3847+2348+3247+2348+2348+239+354+2394+3248-2384-329-2346-239-3545-324998-457234") === -777413
  end
  test "test13" do
    assert Calc.eval("(238+2384+3246+(347-348*346+324/2/(347+384*346+(347/347+48*23)/8)))") == -114193
  end
  test "test14" do
    assert Calc.eval("7234-453-23466-23467-2342347*34+(2364+24523)*2345*364/234") == 18397851
  end
  test "test15" do
    assert Calc.eval("(1+213+(1/23)+(123-123)*(2-2)+134+(34/12)*123-13)") == 581
  end
end
