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

-- El dibujo u.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU esch = rot45 (ciclar esch)

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
dibujoT esch = rot45 (apilar esch (espejar (rotar esch)))

{-
dibujoT :: Dibujo Escher
dibujoT = encimar base $ encimar rbase (r270 rbase)
-}

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 1 esch = cuarteto Borrar Borrar Borrar (dibujoU esch)
esquina n esch = cuarteto esquina((n-1) esch) lado((n-1) esch) rotar(lado) dibujoU(esch) -- lado(n-1, esch) esta bien?

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 1 esch = cuarteto Borrar Borrar (rotar esch) esch
lado n esch = cuarteto (lado (n-1) esch) (lado (n-1) esch) (rotar esch) esch

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
    (esquina n esch) (lado n esch) (r270 (esquina n esch))
    (rotar (lado n esch)) dibujoU  (r270 (lado n esch))
    (rotar (esquina n esch)) (r180 (lado n esch)) (r180 (esquina n esch))

escherConf :: Conf
escherConf = Conf {
    name = "Escher"
    pic = interp interpBas escher (3, figura True) -- Estan bien estos args?
}