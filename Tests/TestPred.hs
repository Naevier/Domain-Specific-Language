import Pred
import Dibujo
import Test.HUnit

-- Test cambiar
testCambiar = TestCase(assertEqual "Test cambiar" () (cambiar))

-- Test AnyDib
testAnyDib = TestCase(assertEqual "Test anyDib" True 
                     (anyDib (==1) (encimar (Dibujo 1) (Dibujo 2))))

-- Test AllDib
testAllDib = TestCase(assertEqual "Test allDib" False (allDib (==1) 
                     (encimar (Dibujo 1) (Dibujo 2)))) 

-- Test AndP
testAndP = TestCase(assertEqual "Test andP" False (andP (==1) (==2) 2))

-- Test orP
testOrP = TestCase(assertEqual "Test orP" True (orP (== 1) (==2) 2))


testPred = 
    TestList [testCambiar, testAnyDib, testAllDib, testandP, testorP]

main = runTestTT testPred
