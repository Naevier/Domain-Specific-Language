module Pred (
  Pred,
  cambiar, anyDib, allDib, orP, andP
) where

type Pred a = a -> Bool

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento.
cambier :: Pred a -> a -> Dibujo a -> Dibujo a
cambiar = undefined


-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib = undefined

-- Todas las básicas satisfacen el predicado.
allDib :: 
allDib = undefined

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP = undefined

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP = undefined
