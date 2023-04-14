module Dibujos.Escher(
    escherConf
) where

import Dibujo
import FloatingPic
import Graphics.Gloss
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Grilla(grilla)
import Interp (Conf (..), interp)

type Escher = Bool 


notEsch :: Dibujo Escher
notEsch = figura False

-- El dibujo u.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU esch = encimar4 (espejar (rot45 esch))

--dibujoU p = rot45 (cuarteto p)
--dibujoU p = cuarteto (rot45 p)
{-
    * Las figuras están encimadas (porque están en el mismo cuadrante) -> Cuarteto
    * Cada una está rotada 45 grados
    [fig1][fig2]
    [fig3][fig4]
-}

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT esch = encimar esch ( encimar (espejar  (rot45 esch)) (r270 (espejar (rot45  esch))))

{-
dibujoT :: Dibujo Escher
dibujoT = encimar base $ encimar rbase (r270 rbase)
-}

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 1 esch = cuarteto notEsch notEsch notEsch (dibujoU esch)
esquina n esch = cuarteto (esquina (n-1) esch) (lado (n-1) esch ) (rotar (lado (n-1) esch )) (dibujoU
 esch)


-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 1 esch = cuarteto notEsch notEsch (rotar (dibujoT esch)) (dibujoT esch)
lado n esch = cuarteto (lado (n-1) esch) (lado (n-1) esch) (rotar (dibujoT esch)) (dibujoT esch)


-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = grilla [[p, q, r], 
                                   [s, t, u], 
                                   [v, w, x]]
--noneto p q r s t u v x w = encimar(1, 2, juntar(1, 2, p juntar(1,1,q,r)), encimar (1, 1, juntar(1, 2, s, juntar(1, 1, t, u)), juntar (1, 2, v, juntar(1, 1, w, x))))
--formula del paper, creo que esto no hace falta porque haskell lo hace solo

-- El dibujo de Escher:
{-
escher :: Int -> Escher -> Dibujo Escher
escher n esch = noneto (esquina(n esch) lado(n esch) esquina(n esch) lado(n esch) dibujoU lado(n esch) esquina(n esch) lado(n esch) esquina(n esch))
-}

escher :: Int -> Escher -> Dibujo Escher
escher n esch =
  noneto 
    (esquina n (figura esch)) (lado n (figura esch)) (r270 (esquina n (figura esch)))
    (rotar (lado n (figura esch))) (dibujoU(figura esch)) (r270 (lado n (figura esch)))
    (rotar (esquina n (figura esch))) (r180 (lado n (figura esch))) (r180 (esquina n (figura esch)))


interpBas :: Output Escher
interpBas False a b c = Blank
interpBas True a b c = pictures [line $ triangulo a b c, cara a b c]
    where
        triangulo a b c = map (a V.+) [zero, c, b, zero]
        cara a b c = polygon $ triangulo (a V.+ half c) (half b) (half c)


escherConf :: Conf
escherConf = Conf {
    name = "Escher",
    pic = interp interpBas (escher 3 True) -- Estan bien estos args?
}