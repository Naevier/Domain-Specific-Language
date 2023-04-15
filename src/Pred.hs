module Pred (
    Pred,
    cambiar, anyDib, allDib, orP, andP, auxiliarAnyAll
) where

import Dibujo
type Pred a = a -> Bool

-- Generalizacion de un fold a bool para dibujos
{-}
auxiliarAnyAll :: Pred a -> (a -> Bool) -> Dibujo a -> Bool
auxiliarAnyAll pred func dibujo = foldDib (pred dibujo) (pred dibujo) 
            (pred dibujo) (pred dibujo) apilar_juntar apilar_juntar caso_encimar
    where
        apilarJuntar :: (a -> Bool) -> Pred a -> Float -> Float -> Dibujo a -> Dibujo a -> Bool
        apilarJuntar func predicado _ _ dibu1 dibu2 = func (predicado dibu1) (predicado dibu2)

        casoEncimar :: (a -> Bool) -> Pred a ->  Dibujo a -> Dibujo a -> Bool
        casoEncimar func predicado dibu1 dibu2 = func (predicado dibu1) (predicado dibu2) 
-}

auxiliarAnyAll :: (a -> b) -> (a -> b) -> Dibujo a -> b
auxiliarAnyAll func1 func2 = foldDib func1 id id id (\ _ _ a b -> func a b) (\ _ _ a b -> func a b)



{-
allDib :: Pred a -> Dibujo a -> Bool
allDib f_pred = foldDib f_pred id id id (\ _ _ a b -> a&&b) (\ _ _ a b -> a&&b) (&&)

anyDib :: Pred a -> Dibujo a -> Bool
anyDib f_pred = foldDib f_pred id id id (\ _ _ a b -> a||b) (\ _ _ a b -> a||b) (||)
-}


-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento
-- Generalizada para aplicar cualquier funcion al 
-- encontrar una basica que cumpla el predicado
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar predicado func dibujo = 
    mapDib(if predicado dibujo then func dibujo else dibujo) dibujo

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib pred dibujo = auxiliarAnyAll pred (||)
-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool 
allDib pred dibu = auxiliarAnyAll pred (&&)  

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> a -> Bool
andP pred1 pred2 elem = pred1 elem && pred2 elem

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> a -> Bool
orP pred1 pred2 elem = pred1 elem || pred2 elem