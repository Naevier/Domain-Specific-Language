module Pred (
    Pred,
    cambiar, anyDib, allDib, orP, andP, auxiliarAnyAll
) where

import Dibujo
type Pred a = a -> Bool

-- Generalizacion de un fold a bool para dibujos
auxiliarAnyAll :: Pred a -> (Bool -> Bool -> Bool) -> Dibujo a -> Bool
auxiliarAnyAll predicado funcionBooleana = foldDib predicado id id id (\ _ _ a b -> funcionBooleana a b) (\ _ _ a b -> funcionBooleana a b) funcionBooleana

-- Intento de generalizacion para
--auxiliarAnyAll :: (a -> b) -> (a -> a -> a) -> Dibujo a -> b
--auxiliarAnyAll func_pred func2 = foldDib func_pred id id id (\ _ _ a b -> func2 a b) (\ _ _ a b -> func2 a b) func2

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento
-- Generalizada para aplicar cualquier funcion al 
-- encontrar una basica que cumpla el predicado
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar predicado func = mapDib (\x -> if predicado x then func x else figura x) 

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib pred = auxiliarAnyAll pred (||)

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool 
allDib pred = auxiliarAnyAll pred (&&)

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> a -> Bool
andP pred1 pred2 elem = pred1 elem && pred2 elem

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> a -> Bool
orP pred1 pred2 elem = pred1 elem || pred2 elem