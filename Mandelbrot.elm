module Mandelbrot
    exposing
        ( Model
        , init
        , computeCell
        , computeRow
        , computeAll
        , view
        )

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Complex exposing (Complex)


maxIterations =
    200


type alias Point =
    ( Int, Int )


type alias Model =
    { width : Int
    , height : Int
    , computed : Dict Point Int
    , min : Complex
    , max : Complex
    }


init : Int -> Model
init size =
    { width = size
    , height = size
    , computed = Dict.empty
    , min = Complex.complex -2 -1.5
    , max = Complex.complex 1 1.5
    }


calculate : Int -> Complex -> Int -> Complex -> Maybe Int
calculate maxIterations c iterations z =
    let
        -- z' = z^2 + c
        z' =
            Complex.mult z z
                |> Complex.add c
    in
        if iterations >= maxIterations then
            Nothing
        else if Complex.abs z' >= 2 then
            Just iterations
        else
            calculate maxIterations c (iterations + 1) z'


computeCell : Int -> Int -> Model -> Model
computeCell row col model =
    let
        colPercent =
            toFloat col / toFloat model.width

        rowPercent =
            toFloat row / toFloat model.height

        c =
            Complex.complex
                (model.min.re + (model.max.re - model.min.re) * colPercent)
                (model.min.im + (model.max.im - model.min.im) * rowPercent)

        value =
            calculate maxIterations c 0 c
    in
        case value of
            Just iterations ->
                { model
                    | computed = Dict.insert ( col, row ) iterations model.computed
                }

            Nothing ->
                { model
                    | computed = Dict.remove ( col, row ) model.computed
                }


computeRow : Int -> Model -> Model
computeRow row model =
    List.foldl (computeCell row) model [0..model.width]


computeAll : Model -> Model
computeAll model =
    List.foldl computeRow model [0..model.height]


view : Model -> Html msg
view model =
    div [ style [ ( "padding", "8px" ) ] ]
        (List.map (viewRow model) [0..model.height])


viewRow : Model -> Int -> Html msg
viewRow model row =
    div
        [ style
            [ ( "height", "2px" ) ]
        ]
        (List.map (viewCell model row) [0..model.width])


determineColor : Int -> String
determineColor iterations =
    let
        x =
            iterations % 5
    in
        if x < 1 then
            "yellow"
        else if x < 2 then
            "orange"
        else if x < 3 then
            "red"
        else if x < 4 then
            "pink"
        else
            "white"


viewCell : Model -> Int -> Int -> Html msg
viewCell model row col =
    let
        color =
            Dict.get ( col, row ) model.computed
                |> Maybe.map determineColor
                |> Maybe.withDefault "black"
    in
        div
            [ style
                [ ( "width", "2px" )
                , ( "height", "2px" )
                , ( "background-color", color )
                , ( "display", "inline-block" )
                ]
            ]
            []
