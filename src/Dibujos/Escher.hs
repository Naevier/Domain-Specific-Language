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
dibujoU = rot45 encimar4 

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
dibujoT esch = rot45 (apilar esch espejar(rotar esch))

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher -- reemplazar rot45 por rotar
esquina 1 esch = dibujoU esch -- cuarteto(blank, blank, blank, dibujo_u(f))
esquina n esch = undefined -- cuarteto(esquina(1, f), lado(1, f), rot45(lado(1, f)), dibujo_u(f))

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher -- reemplazar rot45 por rotar
lado 1 esch = dibujoT esch -- cuarteto(blank, blank, rot45(f), f)
lado n esch = undefined --  cuarteto(lado(1, f), lado(1, f), rot45(f), f)

-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = undefined


-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher n esch = p q r s t u v w x
    where
        p = esquina
        q = lado
        r = undefined
        s = undefined
        t = undefined
        u = undefined
        v = undefined
        w = undefined
        x = undefined



{-
"implementan los siguientes combinadores, en función de la siguiente descripción de los dos primeros niveles"

lado(1, f) = cuarteto(blank, blank, rot45(f), f)
lado(2, f) = cuarteto(lado(1, f), lado(1, f), rot45(f), f)

esquina(1, f) = cuarteto(blank, blank, blank, dibujo_u(f))
esquina(2, f) = cuarteto(esquina(1, f), lado(1, f), rot45(lado(1, f)), dibujo_u(f))
-}

escherConf :: Conf
escherConf = Conf {
    name = "Escher",
    pic = interp interpBas escher(3, figura True) -- Estan bien estos args?
}