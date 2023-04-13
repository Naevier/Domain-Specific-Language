{-# LANGUAGE TupleSections #-}

module Dibujos.GrillaNumerada (
    grillaConf
) where

import Grilla
import Dibujo
import Graphics.Gloss
import Interp (Conf(..), interp)
import FloatingPic (Output, half, zero, grid)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

type Basica = (Int, Int) -- Coordenadas (x,y)

-- Inserta nuestros numeros en la grilla
grillanum :: Dibujo Basica
grillanum = grilla coords

-- Genera una lista de listas con las n x n coordenadas como dibujos
coords :: [[Dibujo Basica]]
coords = map (\num -> map (figura . (num,)) [0,1..7]) [0,1..7]

interpBas :: Output Basica
interpBas tupla (x, y) _ _ =  translate (x+5) (y+15) $ scale 0.15 0.15 $ text $ show tupla

grillaConf :: Conf
grillaConf = Conf {
    name = "Grilla",
    pic = interp interpBas grillanum
}