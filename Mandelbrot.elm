module Mandelbrot exposing (Model, init, view)

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Point =
    ( Int, Int )


type alias Model =
    { width : Int
    , height : Int
    , computed : Dict Point Int
    }


init : Int -> Model
init size =
    { width = size
    , height = size
    , computed =
        Dict.empty
            |> Dict.insert ( 5, 5 ) 1
            |> Dict.insert ( 5, 6 ) 1
    }


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


viewCell : Model -> Int -> Int -> Html msg
viewCell model row col =
    let
        color =
            case Dict.get ( col, row ) model.computed of
                Nothing ->
                    "black"

                Just _ ->
                    "yellow"
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
