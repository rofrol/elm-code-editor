module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation exposing (Location)
import Html.Events.Extra exposing (onClickPreventDefault)
import UrlParser as Url
import Time exposing (Time)


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }



-- MODEL


type alias Model =
    { history : List Location
    , route : Route
    , flags : Flags
    }


type alias Flags =
    { data_server : String
    , currentTime : Time
    }


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    ( Model [ location ] (parseLocation location) flags
    , Cmd.none
    )



-- UPDATE


type Msg
    = UrlChange Location
    | NavigateTo Route


type Route
    = HomeRoute
    | SettingsRoute
    | NotFoundRoute


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | history = location :: model.history, route = parseLocation location }
            , Cmd.none
            )

        NavigateTo route ->
            ( model
            , Navigation.newUrl (reverseRoute route)
            )



-- VIEW


{-| use for easy creating tuples, like `class [ "width" => "10px" ]``
-}
(=>) : a -> b -> ( a, b )
(=>) =
    (,)


nbsp : String
nbsp =
    " "


leadingSpacesToNbsps : String -> String -> String
leadingSpacesToNbsps times accumulator =
    if times == "" then
        accumulator
    else
        case String.uncons times of
            Just ( c, rest ) ->
                let
                    first =
                        String.fromChar c
                in
                    if first == " " then
                        leadingSpacesToNbsps rest (accumulator ++ nbsp)
                    else
                        accumulator ++ first ++ rest

            Nothing ->
                accumulator


type alias Line =
    { n : Int
    , tokens : List Token
    }


type alias Token =
    { content : String
    , classes : List String
    }


view : Model -> Html Msg
view model =
    let
        lines =
            [ Line 1 [ Token "/* Game of Life" [ "mtk8" ] ]
            , Line 2 [ Token " * Implemented in TypeScript" [ "mtk8" ] ]
            , Line 3
                [ Token " * To learn more about TypeScript, please visit " [ "mtk8" ]
                , Token "http://www.typescriptlang.org/" [ "mtk8", "detected-link" ]
                ]
            , Line 4 [ Token " */" [ "mtk8" ] ]
            , Line 5 [ Token nbsp [ "mtk1" ] ]
            , Line 6
                [ Token "module" [ "mtk6" ]
                , Token " Conway {" [ "mtk1" ]
                ]
            , Line 7
                [ Token nbsp [] ]
            , Line 8
                [ Token (leadingSpacesToNbsps "    " "") [ "mtk1" ]
                , Token "export" [ "mtk6" ]
                , Token nbsp [ "mtk1" ]
                , Token " Cell {" [ "mtk1" ]
                ]
            , Line 9
                [ Token (leadingSpacesToNbsps "        " "") [ "mtk1" ]
                , Token "public" [ "mtk6" ]
                , Token " row: " [ "mtk1" ]
                , Token "number" [ "mtk6" ]
                , Token ";" [ "mtk1" ]
                ]
            , Line 10
                [ Token (leadingSpacesToNbsps "        " "") [ "mtk1" ]
                , Token "public" [ "mtk6" ]
                , Token " col: " [ "mtk1" ]
                , Token "number" [ "mtk6" ]
                , Token ";" [ "mtk1" ]
                ]
            , Line 11
                [ Token (leadingSpacesToNbsps "        " "") [ "mtk1" ]
                , Token "public" [ "mtk6" ]
                , Token " live: " [ "mtk1" ]
                , Token "boolean" [ "mtk6" ]
                , Token ";" [ "mtk1" ]
                ]
            , Line 12
                [ Token (leadingSpacesToNbsps "        " "") [ "mtk1" ]
                ]
            , Line 13
                [ Token (leadingSpacesToNbsps "        " "") [ "mtk1" ]
                , Token "constructor" [ "mtk6" ]
                , Token "(row: " [ "mtk1" ]
                , Token "number" [ "mtk6" ]
                , Token ", col: " [ "mtk1" ]
                , Token "number" [ "mtk6" ]
                , Token ", live: " [ "mtk1" ]
                , Token "boolean" [ "mtk6" ]
                , Token ") {" [ "mtk1" ]
                ]
            , Line 14
                [ Token (leadingSpacesToNbsps "            " "") [ "mtk1" ]
                , Token "this" [ "mtk6" ]
                , Token ".row = row;" [ "mtk1" ]
                ]
            , Line 15
                [ Token (leadingSpacesToNbsps "            " "") [ "mtk1" ]
                , Token "this" [ "mtk6" ]
                , Token ".col = col;" [ "mtk1" ]
                ]
            , Line 16
                [ Token (leadingSpacesToNbsps "            " "") [ "mtk1" ]
                , Token "this" [ "mtk6" ]
                , Token ".live = live" [ "mtk1" ]
                ]
            , Line 17
                [ Token (leadingSpacesToNbsps "        }" "") [ "mtk1" ]
                ]
            , Line 18
                [ Token (leadingSpacesToNbsps "    }" "") [ "mtk1" ]
                ]
            , Line 19
                [ Token "}" [ "mtk1" ]
                ]
            ]

        lineHeight =
            19

        editorHeight =
            400

        lineStyleList n =
            [ "position" => "absolute", "top" => ((toString <| (n - 1) * lineHeight) ++ "px"), "width" => "100%", "height" => ((toString <| lineHeight) ++ "px") ]

        lineNumbers : Int -> Html msg
        lineNumbers n =
            div
                [ attribute "linenumber" (toString n)
                , style <| lineStyleList n
                ]
                [ div [ class "line-numbers", attribute "style" "left:0px;width:38px;" ]
                    [ text (toString n) ]
                ]

        currentLine : Int -> Html msg
        currentLine n =
            div
                [ attribute "linenumber" (toString n)
                , style <| lineStyleList n
                ]
                []

        viewToken token =
            span [ class <| String.join " " token.classes ]
                [ text token.content ]

        viewLine : Line -> Html msg
        viewLine line =
            div [ class "view-line", attribute "linenumber" (toString line.n), style [ "top" => ((toString <| (line.n - 1) * lineHeight) ++ "px"), "height" => ((toString <| lineHeight) ++ "px") ] ]
                [ span [] <|
                    List.map viewToken line.tokens
                ]

        progress =
            div [ class "loading editor", attribute "style" "display: none;" ]
                [ div [ class "progress progress-striped active" ]
                    [ div [ class "bar" ]
                        []
                    ]
                ]

        margin =
            div [ attribute "aria-hidden" "true", class "margin monaco-editor-background", attribute "data-transform" "translate3d(0px, 0px, 0px)", attribute "role" "presentation", attribute "style" "position: absolute; transform: translate3d(0px, 0px, 0px); top: 0px; height: 2756px; width: 48px;" ]
                [ div [ class "glyph-margin", attribute "style" "left: 0px; width: 0px; height: 2756px;" ]
                    []
                , div [ attribute "aria-hidden" "true", class "margin-view-zones", attribute "role" "presentation", attribute "style" "position: absolute;" ]
                    []
                , div [ attribute "aria-hidden" "true", class "margin-view-overlays", attribute "role" "presentation", style [ "position" => "absolute", "width" => "48px", "font-family" => "Consolas, \" Courier New \", monospace", "font-weight" => "normal", "font-size" => "14px", "line-height" => (toString lineHeight ++ "px"), "height" => "2756px" ] ] <|
                    List.map (\line -> lineNumbers line.n) lines
                ]

        linesContent =
            div [ class "lines-content monaco-editor-background", attribute "data-transform" "translate3d(0px, 0px, 0px)", attribute "style" "position: absolute; overflow: hidden; width: 1e+06px; height: 1e+06px; transform: translate3d(0px, 0px, 0px); top: 0px; left: 0px;" ]
                [ div [ attribute "aria-hidden" "true", class "view-overlays", attribute "role" "presentation", attribute "style" "position: absolute; width: 820px; height: 0px;" ] <|
                    List.map (\line -> currentLine line.n) lines
                , div [ class "view-rulers" ]
                    []
                , div [ attribute "aria-hidden" "true", class "view-zones", attribute "role" "presentation", attribute "style" "position: absolute;" ]
                    []
                , div
                    [ attribute "aria-hidden" "true"
                    , class "view-lines"
                    , attribute "data-mprt" "7"
                    , attribute "role" "presentation"
                    , style [ "position" => "absolute", "font-family" => "Consolas, \" Courier New \", monospace", "font-weight" => "normal", "font-size" => "14px", "line-height" => (toString lineHeight ++ "px"), "width" => "820px", "height" => "2756px" ]
                    ]
                  <|
                    List.map viewLine lines
                , div [ class "contentWidgets", attribute "data-mprt" "1", attribute "style" "position: absolute; top: 0px;" ]
                    []
                , div [ class "cursors-layer cursor-line-style cursor-blink" ]
                    [ div [ attribute "aria-hidden" "true", class "cursor", attribute "column" "2", attribute "linenumber" "1", attribute "role" "presentation", style [ "height" => (toString lineHeight ++ "px"), "top" => "0px", "left" => "8px", "font-family" => "Consolas, \" Courier New \", monospace", "font-weight" => "normal", "font-size" => "14px", "line-height" => (toString lineHeight ++ "px"), "display" => "block", "visibility" => "inherit", "width" => "2px" ] ]
                        []
                    ]
                ]

        scrollbarHorizontal =
            div [ class "invisible scrollbar horizontal", attribute "style" "position: absolute; transform: translate3d(0px, 0px, 0px); width: 806px; height: 10px; left: 0px; bottom: 0px;" ]
                [ div [ class "slider", style [ "position" => "absolute", "top" => "0px", "left" => "0px", "height" => "10px", "width" => "806px", "transform" => "translate3d(0px, 0px, 0px)" ] ]
                    []
                ]

        decorationsOverviewRuler =
            canvas [ class "decorationsOverviewRuler", attribute "data-transform" "translate3d(0px, 0px, 0px)", attribute "height" (toString editorHeight), style [ "position" => "absolute", "top" => "0px", "right" => "0px", "width" => "14px", "height" => (toString editorHeight ++ "px"), "transform" => "translate3d(0px, 0px, 0px)" ], attribute "width" "14" ]
                []

        scrollbarVertical =
            div [ class "invisible scrollbar vertical fade", style [ "position" => "absolute", "transform" => "translate3d(0px, 0px, 0px)", "width" => "14px", "height" => (toString editorHeight ++ "px"), "right" => "0px", "top" => "0px" ] ]
                [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; width: 14px; height: 58px; transform: translate3d(0px, 0px, 0px);" ]
                    []
                ]

        editorScrollable =
            div [ class "monaco-scrollable-element editor-scrollable vs", attribute "data-mprt" "5", attribute "role" "presentation", style [ "position" => "absolute", "overflow" => "hidden", "left" => "48px", "width" => "820px", "height" => (toString editorHeight ++ "px") ] ]
                [ linesContent
                , scrollbarHorizontal
                , decorationsOverviewRuler
                , scrollbarVertical
                ]

        control ariaLabel class_ title_ =
            div [ attribute "aria-checked" "false", attribute "aria-disabled" "true", attribute "aria-label" ariaLabel, class <| "custom-checkbox " ++ class_ ++ " unchecked", attribute "role" "checkbox", title title_ ]
                []

        findPart =
            div [ class "find-part" ]
                [ div [ class "monaco-findInput disabled", attribute "style" "width: 221px;" ]
                    [ div [ class "monaco-inputbox idle" ]
                        [ div [ class "wrapper" ]
                            [ input [ attribute "aria-label" "Find", attribute "autocapitalize" "off", attribute "autocorrect" "off", class "input", attribute "disabled" "", placeholder "Find", attribute "spellcheck" "false", attribute "style" "width: 155px;", title "Find", type_ "text", wrap "off" ]
                                []
                            ]
                        ]
                    , div [ class "controls" ]
                        [ control "Match Case (Alt+C)" "monaco-whole-word" "Match Case (Alt+C)"
                        , control "Match Whole Word (Alt+W)" "monaco-case-sensitive" "Match Whole Word (Alt+W)"
                        , control "Use Regular Expression (Alt+R)" "monaco-regex" "Use Regular Expression (Alt+R)"
                        ]
                    ]
                , div [ class "matchesCount", attribute "style" "min-width: 69px;", title "" ]
                    [ text "No Results" ]
                , div [ attribute "aria-disabled" "true", attribute "aria-label" "Previous match (Shift+F3)", class "button previous disabled", attribute "role" "button", attribute "tabindex" "-1", title "Previous match (Shift+F3)" ]
                    []
                , div [ attribute "aria-disabled" "true", attribute "aria-label" "Next match (F3)", class "button next disabled", attribute "role" "button", attribute "tabindex" "-1", title "Next match (F3)" ]
                    []
                , div [ class "monaco-checkbox", title "Find in selection" ]
                    [ input [ class "checkbox", attribute "disabled" "", id "checkbox-0", type_ "checkbox" ]
                        []
                    , label [ class "label", for "checkbox-0" ]
                        []
                    ]
                , div [ attribute "aria-disabled" "true", attribute "aria-label" "Close (Escape)", class "button close-fw disabled", attribute "role" "button", attribute "tabindex" "-1", title "Close (Escape)" ]
                    []
                ]

        replacePart =
            div [ class "replace-part" ]
                [ div [ class "replace-input", attribute "style" "width: 221px;" ]
                    [ div [ class "monaco-inputbox idle" ]
                        [ div [ class "wrapper" ]
                            [ input [ attribute "aria-label" "Replace", attribute "autocapitalize" "off", attribute "autocorrect" "off", class "input", attribute "disabled" "", placeholder "Replace", attribute "spellcheck" "false", title "Replace", type_ "text", wrap "off" ]
                                []
                            ]
                        ]
                    ]
                , div [ attribute "aria-disabled" "true", attribute "aria-label" "Replace (Ctrl+Shift+1)", class "button replace disabled", attribute "role" "button", attribute "tabindex" "-1", title "Replace (Ctrl+Shift+1)" ]
                    []
                , div [ attribute "aria-disabled" "true", attribute "aria-label" "Replace All (Ctrl+Alt+Enter)", class "button replace-all disabled", attribute "role" "button", attribute "tabindex" "-1", title "Replace All (Ctrl+Alt+Enter)" ]
                    []
                ]

        findWidget =
            div [ attribute "aria-hidden" "false", class "editor-widget find-widget", attribute "style" "position: absolute;", attribute "widgetid" "editor.contrib.findWidget" ]
                [ div [ attribute "aria-disabled" "true", attribute "aria-expanded" "false", attribute "aria-label" "Toggle Replace mode", class "button toggle left collapse disabled", attribute "role" "button", attribute "tabindex" "-1", title "Toggle Replace mode" ]
                    []
                , findPart
                , replacePart
                ]

        findOptionsWidget =
            div [ attribute "aria-hidden" "true", class "monaco-editor-background findOptionsWidget", attribute "data-editor-restorestyletop" "10px", attribute "role" "presentation", attribute "style" "display: none; top: 0px; position: absolute; right: 28px;", attribute "widgetid" "editor.contrib.findOptionsWidget" ]
                [ div [ attribute "aria-checked" "false", attribute "aria-label" "Match Case (Alt+C)", class "custom-checkbox monaco-case-sensitive unchecked", attribute "role" "checkbox", attribute "tabindex" "0", title "Match Case (Alt+C)" ]
                    []
                , div [ attribute "aria-checked" "false", attribute "aria-label" "Match Whole Word (Alt+W)", class "custom-checkbox monaco-whole-word unchecked", attribute "role" "checkbox", attribute "tabindex" "0", title "Match Whole Word (Alt+W)" ]
                    []
                ]

        modesGlyphHoverWidget =
            div [ attribute "aria-hidden" "true", class "monaco-editor-hover hidden", attribute "role" "presentation", attribute "style" "position: absolute;", attribute "widgetid" "editor.contrib.modesGlyphHoverWidget" ]
                []

        modesContentHoverWidget =
            div [ class "monaco-editor-hover hidden", attribute "style" "position: absolute; max-width: 1366px; visibility: hidden;", attribute "tabindex" "0", attribute "widgetid" "editor.contrib.modesContentHoverWidget" ]
                [ div [ class "monaco-scrollable-element ", attribute "role" "presentation", attribute "style" "position: relative; overflow: hidden;" ]
                    [ div [ class "monaco-editor-hover-content", style [ "overflow" => "hidden", "font-size" => "14px", "line-height" => (toString lineHeight ++ "px"), "max-height" => "250px" ] ]
                        []
                    , div [ class "invisible scrollbar horizontal", attribute "style" "position: absolute;" ]
                        [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; height: 10px;" ]
                            []
                        ]
                    , div [ class "invisible scrollbar vertical", attribute "style" "position: absolute;" ]
                        [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; width: 10px;" ]
                            []
                        ]
                    , div [ class "shadow" ]
                        []
                    , div [ class "shadow" ]
                        []
                    , div [ class "shadow top-left-corner" ]
                        []
                    ]
                ]

        parameterHintsWidget =
            div [ class "editor-widget parameter-hints-widget", attribute "style" "font-size: 14px; max-height: 250px; position: absolute; max-width: 1366px; visibility: hidden;", attribute "widgetid" "editor.widget.parameterHintsWidget" ]
                [ div [ class "wrapper" ]
                    [ div [ class "buttons" ]
                        [ div [ class "button previous" ]
                            []
                        , div [ class "button next" ]
                            []
                        ]
                    , div [ class "overloads" ]
                        []
                    , div [ class "monaco-scrollable-element ", attribute "role" "presentation", attribute "style" "position: relative; overflow: hidden;" ]
                        [ div [ class "body", attribute "style" "overflow: hidden;" ]
                            [ div [ class "signature" ]
                                []
                            , div [ class "docs" ]
                                []
                            ]
                        , div [ class "invisible scrollbar horizontal", attribute "style" "position: absolute;" ]
                            [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; height: 10px;" ]
                                []
                            ]
                        , div [ class "invisible scrollbar vertical", attribute "style" "position: absolute;" ]
                            [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; width: 10px;" ]
                                []
                            ]
                        , div [ class "shadow" ]
                            []
                        , div [ class "shadow" ]
                            []
                        , div [ class "shadow top-left-corner" ]
                            []
                        ]
                    ]
                ]

        renameBox =
            div [ class "monaco-editor rename-box", style [ "height" => (toString lineHeight ++ "px"), "position" => "absolute", "max-width" => "1366px", "visibility" => "hidden" ], attribute "widgetid" "__renameInputWidget" ]
                [ input [ attribute "aria-label" "Rename input. Type new name and press Enter to commit.", class "rename-input", attribute "style" "font-family: Consolas, \" Courier New \", monospace; font-weight: normal; font-size: 14px;", type_ "text" ]
                    []
                ]

        suggestWidget =
            div [ class "editor-widget suggest-widget", attribute "style" "position: absolute; max-width: 1366px; visibility: hidden;", attribute "widgetid" "editor.widget.suggestWidget" ]
                [ div [ class "message", attribute "style" "display: none;" ]
                    []
                , div [ class "tree" ]
                    [ div [ class "monaco-list", attribute "role" "tree", attribute "tabindex" "0" ]
                        [ div [ class "monaco-scrollable-element ", attribute "role" "presentation", attribute "style" "position: relative; overflow: hidden;" ]
                            [ div [ class "monaco-list-rows", attribute "style" "overflow: hidden; height: 0px;" ]
                                []
                            , div [ class "invisible scrollbar horizontal", attribute "style" "position: absolute;" ]
                                [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; height: 10px;" ]
                                    []
                                ]
                            , div [ class "invisible scrollbar vertical", attribute "style" "position: absolute;" ]
                                [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; width: 10px;" ]
                                    []
                                ]
                            ]
                        ]
                    ]
                , div [ class "details", attribute "style" "font-size: 14px; display: none;" ]
                    [ div [ class "header" ]
                        [ span [ class "title", attribute "style" "font-family: Consolas, \" Courier New \", monospace;" ]
                            [ span [ class "monaco-highlighted-label" ]
                                []
                            ]
                        , span [ class "go-back", style [ "height" => (toString lineHeight ++ "px"), "width" => (toString lineHeight ++ "px") ], title "Go back" ]
                            []
                        ]
                    , div [ class "monaco-scrollable-element ", attribute "role" "presentation", attribute "style" "position: relative; overflow: hidden;" ]
                        [ div [ class "body", attribute "style" "overflow: hidden;" ]
                            [ p [ class "type", attribute "style" "font-family: Consolas, \" Courier New \", monospace;" ]
                                []
                            , p [ class "docs" ]
                                []
                            ]
                        , div [ class "invisible scrollbar horizontal", attribute "style" "position: absolute;" ]
                            [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; height: 10px;" ]
                                []
                            ]
                        , div [ class "invisible scrollbar vertical", attribute "style" "position: absolute;" ]
                            [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; width: 10px;" ]
                                []
                            ]
                        , div [ class "shadow" ]
                            []
                        , div [ class "shadow" ]
                            []
                        , div [ class "shadow top-left-corner" ]
                            []
                        ]
                    ]
                ]

        actionItem text_ keybinding =
            li [ class "action-item", attribute "role" "presentation" ]
                [ a [ class "action-label", attribute "role" "button", attribute "tabindex" "0" ]
                    [ text text_ ]
                , span [ class "keybinding" ]
                    [ text keybinding ]
                ]

        actionItemSeparator =
            li [ class "action-item disabled", attribute "role" "presentation" ]
                [ a [ class "action-label icon separator disabled", attribute "role" "button" ]
                    []
                ]

        monacoMenuContainer =
            div [ attribute "aria-hidden" "false", class "context-view monaco-menu-container bottom left builder-hidden", attribute "style" "top: 9px; left: 55.5px; width: initial;" ]
                [ div [ class "monaco-menu" ]
                    [ div [ class "monaco-action-bar animated vertical" ]
                        [ ul [ class "actions-container", attribute "role" "toolbar" ]
                            [ actionItem "Go to Definition" "Ctrl+F12"
                            , actionItem "Peek Definition" "Alt+F12"
                            , actionItem "Find All References" "Shift+F12"
                            , actionItem "Go to Symbol..." "Ctrl+Shift+O"
                            , actionItemSeparator
                            , actionItem "Change All Occurrences" "Ctrl+F2"
                            , actionItem "Format Document" "Shift+Alt+F"
                            , actionItemSeparator
                            , actionItem "Command Palette" "F1"
                            ]
                        ]
                    ]
                ]
    in
        div [ class "editor-frame" ]
            [ progress
            , div [ attribute "data-keybinding-context" "1", attribute "data-mode-id" "typescript", id "editor" ]
                [ div [ class "monaco-editor vs", style [ "width" => "868px", "height" => (toString editorHeight ++ "px") ] ]
                    [ div [ class "overflow-guard", attribute "data-mprt" "3", style [ "width" => "868px", "height" => (toString editorHeight ++ "px") ] ]
                        [ margin
                        , editorScrollable
                        , div [ attribute "style" "width: 868px;" ]
                            []
                        , div [ class "overlayWidgets", attribute "data-mprt" "4", attribute "style" "width: 868px;" ]
                            [ findWidget
                            , findOptionsWidget
                            , modesGlyphHoverWidget
                            , div [ class "lightbulb-glyph hidden", attribute "style" "width: 21px; height: 20px; position: absolute;", title "Show Fixes (Ctrl+.)", attribute "widgetid" "__lightBulbWidget" ]
                                []
                            ]
                        , textarea [ attribute "aria-autocomplete" "both", attribute "aria-haspopup" "false", attribute "aria-label" "Editor content", attribute "aria-multiline" "true", attribute "autocapitalize" "off", attribute "autocorrect" "off", class "inputarea", attribute "data-mprt" "6", attribute "role" "textbox", attribute "spellcheck" "false", style [ "top" => "0px", "left" => "0px", "font-family" => "Consolas, \" Courier New \", monospace", "font-weight" => "normal", "font-size" => "14px", "line-height" => (toString lineHeight ++ "px") ], wrap "off" ]
                            []
                        , div [ class "monaco-editor-background line-numbers textAreaCover", attribute "style" "position: absolute; width: 1px; height: 1px; top: 0px; left: 0px;" ]
                            []
                        ]
                    , div [ class "overflowingContentWidgets", attribute "data-mprt" "2" ]
                        [ modesContentHoverWidget
                        , parameterHintsWidget
                        , renameBox
                        , suggestWidget
                        ]
                    , monacoMenuContainer
                    ]
                ]
            ]


pageView : Model -> Html Msg
pageView model =
    div []
        [ text
            (case model.route of
                HomeRoute ->
                    "Home"

                SettingsRoute ->
                    "Settings"

                NotFoundRoute ->
                    "404 :("
            )
        ]


viewLink : Route -> Html Msg
viewLink route =
    li [] [ a [ href (reverseRoute route), onClickPreventDefault (NavigateTo route) ] [ text (reverseRoute route) ] ]


viewLocation : Location -> Html Msg
viewLocation location =
    li [] [ text (location.pathname) ]


reverseRoute : Route -> String
reverseRoute route =
    case route of
        HomeRoute ->
            "/"

        SettingsRoute ->
            "/settings"

        NotFoundRoute ->
            ""


routeParser : Url.Parser (Route -> a) a
routeParser =
    Url.oneOf
        [ Url.map HomeRoute Url.top
        , Url.map SettingsRoute (Url.s "settings")
        ]


parseLocation : Location -> Route
parseLocation location =
    location
        |> Url.parsePath routeParser
        |> Maybe.withDefault NotFoundRoute
