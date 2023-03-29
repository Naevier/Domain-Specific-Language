module Pred (
  Pred,
  cambiar, anyDib, allDib, orP, andP
) where

type Pred a = a -> Bool

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento.
cambiar :: Pred a -> a -> Dibujo a -> Dibujo a
cambiar predicado a dibujo = (predicado == a) = dibujo 
                            

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib pred dibujo = pred dibujo || anyDib pred dibujo -- Aplicar la recursion a todos los Dibujos

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool
allDib pred dibujo = pred dibujo && allDib pred dibujo -- Aplicar la recursion a todos los Dibujos

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> a -> Bool
andP pred1 pred2 elem = pred1 elem && pred2 elem

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> a -> Bool
orP pred1 pred2 elem = pred1 elem || pred2 elem
