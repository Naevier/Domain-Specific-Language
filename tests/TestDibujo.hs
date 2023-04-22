import Dibujo
import Test.HUnit

-- Test Figura
testFigura = 
    TestCase(assertEqual "Figura Cuadrado" (Figura "Cuadrado") 
            (figura "Cuadrado"))

-- Test funciones
testRotar = 
    TestCase(assertEqual "Rotar" (Rotar (Figura "Cuadrado")) 
            (rotar(figura "Cuadrado")))

-- Test Espejar
testEspejar = 
    TestCase(assertEqual "Espejar" (Espejar (Figura "Cuadrado")) 
            (espejar(figura "Cuadrado")))

-- Test Rot45
testRotar45 = 
    TestCase(assertEqual "Rotar45" (Rot45 (Figura "Cuadrado")) 
            (rot45(figura "Cuadrado")))

-- Test Apilar
testApilar = 
    TestCase(assertEqual "Apilar" (Apilar 1.0 1.0 (Figura "Cuadrado") (Figura "Circulo")) 
            (apilar 1.0 1.0 (figura "Cuadrado") (figura "Circulo")))

-- Test Juntar
testJuntar = 
    TestCase(assertEqual "Juntar" (Juntar 1.0 1.0 (Figura "Cuadrado") 
            (Figura "Circulo")) (juntar 1.0 1.0 (figura "Cuadrado") (figura "Circulo")))

-- Test Encimar
testEncimar = 
    TestCase(assertEqual "Encimar" (Encimar (Figura "Cuadrado") 
            (Figura "Circulo")) (encimar (figura "Cuadrado") (figura "Circulo")))

-- Test Composicion
testComp = 
    TestCase(assertEqual "Test composicion" (1+1+1) (comp (+1) 3 0))

-- Test r180
testR180 = 
    TestCase(assertEqual "Test r180" (Rotar(Rotar(Figura "Cuadrado"))) 
            (r180 (figura "Cuadrado")))

-- Test r270
testR270 = 
    TestCase(assertEqual "Test r270" (Rotar(Rotar(Rotar(Figura "Cuadrado")))) 
            (r270 (figura "Cuadrado")))


-- Test figuras (incluye folddib)
testFiguras = TestCase(assertEqual "Test figuras y foldDib" ["Cuadrado", "Circulo"] 
                (figuras (Apilar 1.0 1.0 (Figura "Cuadrado") (Figura "Circulo"))))

-- Test MapDib
testMapDib = TestCase (assertEqual "Test mapDib" (Figura "Cuadrado") (mapDib figura (Figura "Cuadrado")))

-- Test ciclar
testCiclar = TestCase (assertEqual "Test ciclar" (cuarteto (Figura "Cuadrado") 
                (rotar (Figura "Cuadrado")) (r180 (Figura "Cuadrado")) (r270 (Figura "Cuadrado"))) 
                (ciclar (figura "Cuadrado")))


testDibujo = 
    TestList [testFigura, testRotar, testEspejar, testRotar45, testApilar, testJuntar, testComp, testR180, testR270, testFiguras, testMapDib, testCiclar]

main = runTestTT testDibujo