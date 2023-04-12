-- "definen un sinónimo de tipos"


-- Supongamos que eligen
type Escher = Bool

-- El dibujo u.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = undefined

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT p = undefined

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina n p = undefined -- reemplazar con rotar

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado n p = undefined -- reemplazar con rotar

-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = undefined
-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher = undefined


-- "implementan los siguientes combinadores, en función de la siguiente descripción de los dos primeros niveles"

lado(1, f) = cuarteto(blank, blank, rot45(f), f)
lado(2, f) = cuarteto(lado(1, f), lado(1, f), rot45(f), f)
esquina(1, f) = cuarteto(blank, blank, blank, dibujo_u(f))
esquina(2, f) = cuarteto(esquina(1, f), lado(1, f), rot45(lado(1, f)), dibujo_u(f))