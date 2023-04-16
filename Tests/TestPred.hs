import Pred
import Dibujo
import Test.HUnit

-- Test cambiar
testCambiar = TestCase(assertEqual "Test cambiar" (figura 2) 
    (cambiar (==1) (const (figura 2)) (figura 1)))

-- Test AnyDib
testAnyDib = TestCase(assertEqual "Test anyDib" True 
    (anyDib (== "Cuadrado") (encimar (Figura "Cuadrado") (Figura "Circulo"))))

-- Test AllDib
testAllDib = TestCase(assertEqual "Test allDib" False (allDib (=="Triangulo") 
    (encimar (Figura "Cuadrado") (Figura "Triangulo")))) 

-- Test AndP (usa auxiliarAnyAll)
testAndP = TestCase(assertEqual "Test andP" False (andP (=="Triangulo") 
    (=="Cuadrado con formas raras") "Cuadrado con formas raras"))

-- Test orP (usa auxiliarAnyAll)
testOrP = TestCase(assertEqual "Test orP" True 
    (orP (== "Octogono") (=="Figura rara") "Figura rara"))

testPred = 
    TestList [testCambiar, testAnyDib, testAllDib, testAndP, testOrP]

main = runTestTT testPred
