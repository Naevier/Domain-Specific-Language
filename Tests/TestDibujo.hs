import Dibujo
import Test.HUnit

-- Test Figura
testFigura = TestCase(assertEqual "Figura Cuadrado" (Figura "Cuadrado") (figura "Cuadrado"))

-- Test funciones
testRotar = TestCase(assertEqual "Rotar" (Rotar (Figura "Cuadrado")) (rotar(figura "Cuadrado")))

-- Test Espejar
testEspejar = TestCase(assertEqual "Espejar" (Espejar (Figura "Cuadrado")) (espejar(figura "Cuadrado")))

--ah no para, no tenes que pushear para que lo pueda hacer?

-- Definición de la función suma
suma :: Int -> Int -> Int
suma a b = a + b

-- Definición de las pruebas
testSuma :: Test
testSuma = TestList [
    TestCase $ assertEqual "Suma de dos números positivos" 5 (suma 2 3),
    TestCase $ assertEqual "Suma de un número positivo y cero" 3 (suma 3 0),
    TestCase $ assertEqual "Suma de dos números negativos" (-7) (suma (-3) (-4))
    ]



main = runTestTT testDibujo