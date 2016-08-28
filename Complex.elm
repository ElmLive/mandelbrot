module Complex exposing (Complex, complex, i, one, zero, real, imaginary, fromReal, abs, conjugate, negation, add, sub, mult, div, sgn, sqrt, arg, ln, exp, pow, cos, sin, tan, asin, acos, atan, euler)

{-| The complex module allows you to work with complex numbers. There is not much else to say. We have basic constructors, basic operations, trig, exponentials, and logarithms. More may be added in the future.

# Basics
@docs complex,i,one,zero,fromReal

# Basic Unary Operations
@docs real, imaginary, abs, conjugate, negation, sgn, arg, sqrt

# Basic Binary Operations
@docs  add, sub, mult, div

# Trig
@docs sin,cos,tan,asin,acos,atan, euler

# Exponents and Logarithms
@docs ln, exp, pow

-}


{-| A complex number is a record of a real part and an imaginary part.


-}
type alias Complex =
    { re : Float, im : Float }


{-| Generates a complex number.

    complex 1 2 == 1+2i

-}
complex : Float -> Float -> Complex
complex a b =
    { re = a, im = b }


{-| The number i

    i == complex 0 1

-}
i : Complex
i =
    { re = 0, im = 1 }


{-| The number 1.

    complex 1 0 == one

-}
one : Complex
one =
    { re = 1, im = 0 }


{-| The number 0.

    complex 0 0 == zero

-}
zero : Complex
zero =
    { re = 0, im = 0 }


{-| Provides the real part of a complex number.

    real 2+3i == 2

-}
real : Complex -> Float
real c =
    c.re


{-| Provides the imaginary part of a complex number.

    imaginary 2+3i == 3

-}
imaginary : Complex -> Float
imaginary c =
    c.im


{-| Creates a complex number from one real numer.

    fromReal 5 == 5 + 0i

-}
fromReal : Float -> Complex
fromReal r =
    { re = r, im = 0 }


{-| Takes the absolute value of a complex number.

    abs 2+2i == sqrt 8
    abs -2-2i == sqrt 8
    abs 0+0i == 0
-}
abs : Complex -> Float
abs c =
    (c.re ^ 2 + c.im ^ 2) ^ (0.5)


{-| Returns the conjugate of a complex number

    conjugate 2+3i == 2 - 3i
    conjugate 2-3i == 2+3i

-}
conjugate : Complex -> Complex
conjugate c1 =
    { re = c1.re, im = (-1) * c1.im }


{-| Negates a complex number.

    negation 1+2i == -1-2i
    negation -1-2i == 1 + 2i
    negation -1+2i == 1 - 2i

-}
negation : Complex -> Complex
negation c =
    { re = (-1) * c.re, im = (-1) * c.im }


{-| Adds two complex numbers by adding the real and imaginary parts.

-}
add : Complex -> Complex -> Complex
add c1 c2 =
    { re = (c1.re + c2.re), im = (c1.im + c2.im) }


{-| Subtacts two complex numbers by negating and adding.

-}
sub : Complex -> Complex -> Complex
sub c1 c2 =
    add c1 (negation c2)


{-| Multiplies two complex numbers so that

    mult (a+bi) (c+di) == (ac-bd) + (ad+bc)

-}
mult : Complex -> Complex -> Complex
mult c1 c2 =
    { re = c1.re * c2.re - (c1.im * c2.im), im = c1.re * c2.im + c2.re * c1.im }


{-| Divides two complex numbers.

    div 2+2i 1+1i == 2+0
    div 2+2i 0+0i == NaN + NaNi

-}
div : Complex -> Complex -> Complex
div c1 c2 =
    let
        numRe =
            c1.re * c2.re + c1.im * c2.im

        numIm =
            c1.im * c2.re - c1.re * c2.im

        den =
            c2.re ^ 2 + c2.im ^ 2
    in
        { re = numRe / den, im = numIm / den }


{-| Returns the sign of a complex number.

    sgn 0 + 0i == 0
    sgn 0 + 2i == 0
    sgn 1 + (-10)i == 1
    sgn (-1) + (10)i == (-1)
    sgn (-1) + (-10)i == (-1)

-}
sgn : Complex -> Float
sgn c =
    case ( c.re, c.im ) of
        ( 0, 0 ) ->
            0

        ( 0, b ) ->
            if b > 0 then
                (1)
            else if b < 0 then
                (-1)
            else
                0

        ( a, b ) ->
            if a > 0 then
                1
            else
                (-1)


{-| Square root of a complex number. Returns only one of two possibilites.

    sqrt (2+2i) == (1.55...) + i0.6435..

-}
sqrt : Complex -> Complex
sqrt c1 =
    let
        gamma =
            ((c1.re + (abs c1)) / 2) ^ (0.5)

        delta =
            (((-1) * c1.re + (abs c1)) / 2) ^ (0.5)
    in
        fst ( { re = gamma, im = delta }, { re = (-1) * gamma, im = (-1) * delta } )



--https://hackage.haskell.org/package/base-4.8.2.0/docs/src/GHC.Float.html#atan2


atan2 : number -> number' -> Float
atan2 y x =
    if x > 0 then
        Basics.atan (y / x)
    else if x == 0 && y > 0 then
        pi / 2
    else if x < 0 && y > 0 then
        pi + Basics.atan (y / x)
    else if (x <= 0 && y < 0) then
        0 - (atan2 (-y) x)
    else if (y == 0 && (x < 0)) then
        pi
    else if x == 0 && y == 0 then
        y
    else
        x + y


{-| The argument of a complex number. It is in radians. This is also known as the phase or angle.

    arg 0+0i == 0
    arg 0+i == pi/2

-}
arg : Complex -> Float
arg c =
    case ( c.re, c.im ) of
        ( 0, 0 ) ->
            0

        ( x, y ) ->
            atan2 y x


nln : Complex -> (Int -> Complex)
nln z =
    \k -> { re = logBase (Basics.e) (abs z), im = (arg z) + 2 * Basics.pi * (toFloat k) }


{-| The natrual log of a complex number.

-}
ln : Complex -> Complex
ln =
    flip nln 0


{-| Euler's formula.

           euler 2 == e^{i*2} == cos 2 + i*sin 2
-}
euler : Float -> Complex
euler x =
    { re = Basics.cos x, im = Basics.sin x }


{-| The exponent of a complex number.

-}
exp : Complex -> Complex
exp c =
    mult { re = Basics.e ^ (real c), im = 0 } { re = Basics.cos (imaginary c), im = Basics.sin (imaginary c) }


{-| Take a complex number to a complex power.

    pow 1+0i 2+2i == (1)^{2+2i} == 1

-}
pow : Complex -> Complex -> Complex
pow z w =
    if z == zero then
        zero
    else
        exp (mult w (ln z))


{-| Complex cosine.

-}
cos : Complex -> Complex
cos z =
    div (add (exp (mult i z)) (exp (negation (mult i z)))) { re = 2, im = 0 }


{-| Complex sine.

-}
sin : Complex -> Complex
sin z =
    div (sub (exp (mult i z)) (exp (negation (mult i z)))) { re = 0, im = 2 }


{-| Complex tangent.

-}
tan : Complex -> Complex
tan z =
    let
        num =
            mult i (sub (exp (negation (mult i z))) (exp ((mult i z))))

        den =
            (add (exp (negation (mult i z))) (exp ((mult i z))))
    in
        div num den


{-| Complex inverse sine.

-}
asin : Complex -> Complex
asin =
    flip ncasin 0


ncasin : Complex -> (Int -> Complex)
ncasin z =
    \k -> mult (negation i) (nln (add (mult i z) (pow (sub one (pow z { re = 2, im = 0 })) { re = 0.5, im = 0 })) k)


{-| Complex inverse cosine.

-}
acos : Complex -> Complex
acos =
    flip ncacos 0


ncacos : Complex -> (Int -> Complex)
ncacos z =
    \k -> sub { re = Basics.pi / 2, im = 0 } (ncasin z k)


{-| Complex inverse tan.

-}
atan : Complex -> Complex
atan =
    flip ncatan 0


ncatan : Complex -> (Int -> Complex)
ncatan z =
    \k -> mult (mult i { re = 0.5, im = 0 }) (sub (nln (sub one (mult i z)) k) (nln (add one (mult i z)) k))
