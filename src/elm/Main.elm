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


view : Model -> Html Msg
view model =
    let
        lines =
            List.range 1 22

        linenumber : Int -> Html msg
        linenumber n =
            div
                [ attribute "linenumber" (toString n)
                , style [ "position" => "absolute", "top" => ((toString <| (n - 1) * 19) ++ "px"), "width" => "100%", "height" => "19px" ]
                ]
                [ div [ class "line-numbers", attribute "style" "left:0px;width:38px;" ]
                    [ text (toString n) ]
                ]
    in
        div [ class "editor-frame" ]
            [ div [ class "loading editor", attribute "style" "display: none;" ]
                [ div [ class "progress progress-striped active" ]
                    [ div [ class "bar" ]
                        []
                    ]
                ]
            , div [ attribute "data-keybinding-context" "1", attribute "data-mode-id" "typescript", id "editor" ]
                [ div [ class "monaco-editor vs", attribute "style" "width: 868px; height: 400px;" ]
                    [ div [ class "overflow-guard", attribute "data-mprt" "3", attribute "style" "width: 868px; height: 400px;" ]
                        [ div [ attribute "aria-hidden" "true", class "margin monaco-editor-background", attribute "data-transform" "translate3d(0px, 0px, 0px)", attribute "role" "presentation", attribute "style" "position: absolute; transform: translate3d(0px, 0px, 0px); top: 0px; height: 2756px; width: 48px;" ]
                            [ div [ class "glyph-margin", attribute "style" "left: 0px; width: 0px; height: 2756px;" ]
                                []
                            , div [ attribute "aria-hidden" "true", class "margin-view-zones", attribute "role" "presentation", attribute "style" "position: absolute;" ]
                                []
                            , div [ attribute "aria-hidden" "true", class "margin-view-overlays", attribute "role" "presentation", attribute "style" "position: absolute; width: 48px; font-family: Consolas, \" Courier New \", monospace; font-weight: normal; font-size: 14px; line-height: 19px; height: 2756px;" ] <|
                                List.map linenumber lines
                            ]
                        , div [ class "monaco-scrollable-element editor-scrollable vs", attribute "data-mprt" "5", attribute "role" "presentation", attribute "style" "position: absolute; overflow: hidden; left: 48px; width: 820px; height: 400px;" ]
                            [ div [ class "lines-content monaco-editor-background", attribute "data-transform" "translate3d(0px, 0px, 0px)", attribute "style" "position: absolute; overflow: hidden; width: 1e+06px; height: 1e+06px; transform: translate3d(0px, 0px, 0px); top: 0px; left: 0px;" ]
                                [ div [ attribute "aria-hidden" "true", class "view-overlays", attribute "role" "presentation", attribute "style" "position: absolute; width: 820px; height: 0px;" ]
                                    [ div [ attribute "linenumber" "1", attribute "style" "position:absolute;top:0px;width:100%;height:19px;" ]
                                        [ div [ class "current-line", attribute "style" "width:820px; height:19px;" ]
                                            []
                                        ]
                                    , div [ attribute "linenumber" "2", attribute "style" "position:absolute;top:19px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "3", attribute "style" "position:absolute;top:38px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "4", attribute "style" "position:absolute;top:57px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "5", attribute "style" "position:absolute;top:76px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "6", attribute "style" "position:absolute;top:95px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "7", attribute "style" "position:absolute;top:114px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "8", attribute "style" "position:absolute;top:133px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "9", attribute "style" "position:absolute;top:152px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "10", attribute "style" "position:absolute;top:171px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "11", attribute "style" "position:absolute;top:190px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "12", attribute "style" "position:absolute;top:209px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "13", attribute "style" "position:absolute;top:228px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "14", attribute "style" "position:absolute;top:247px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "15", attribute "style" "position:absolute;top:266px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "16", attribute "style" "position:absolute;top:285px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "17", attribute "style" "position:absolute;top:304px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "18", attribute "style" "position:absolute;top:323px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "19", attribute "style" "position:absolute;top:342px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "20", attribute "style" "position:absolute;top:361px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "21", attribute "style" "position:absolute;top:380px;width:100%;height:19px;" ]
                                        []
                                    , div [ attribute "linenumber" "22", attribute "style" "position:absolute;top:399px;width:100%;height:19px;" ]
                                        []
                                    ]
                                , div [ class "view-rulers" ]
                                    []
                                , div [ attribute "aria-hidden" "true", class "view-zones", attribute "role" "presentation", attribute "style" "position: absolute;" ]
                                    []
                                , div [ attribute "aria-hidden" "true", class "view-lines", attribute "data-mprt" "7", attribute "role" "presentation", attribute "style" "position: absolute; font-family: Consolas, \" Courier New \", monospace; font-weight: normal; font-size: 14px; line-height: 19px; width: 820px; height: 2756px;" ]
                                    [ div [ class "view-line", attribute "linenumber" "1", attribute "style" "top:0px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk8" ]
                                                [ text "/* Game of Life" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "2", attribute "style" "top:19px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk8" ]
                                                [ text " * Implemented in TypeScript" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "3", attribute "style" "top:38px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk8" ]
                                                [ text " * To learn more about TypeScript, please visit " ]
                                            , span [ class "mtk8 detected-link" ]
                                                [ text "http://www.typescriptlang.org/" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "4", attribute "style" "top:57px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk8" ]
                                                [ text " */" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "5", attribute "style" "top:76px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text " " ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "6", attribute "style" "top:95px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk6" ]
                                                [ text "module" ]
                                            , span [ class "mtk1" ]
                                                [ text " Conway {" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "7", attribute "style" "top:114px;height:19px;" ]
                                        [ span []
                                            [ span []
                                                [ text " " ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "8", attribute "style" "top:133px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "    " ]
                                            , span [ class "mtk6" ]
                                                [ text "export" ]
                                            , span [ class "mtk1" ]
                                                [ text " " ]
                                            , span [ class "mtk6" ]
                                                [ text "class" ]
                                            , span [ class "mtk1" ]
                                                [ text " Cell {" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "9", attribute "style" "top:152px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "        " ]
                                            , span [ class "mtk6" ]
                                                [ text "public" ]
                                            , span [ class "mtk1" ]
                                                [ text " row: " ]
                                            , span [ class "mtk6" ]
                                                [ text "number" ]
                                            , span [ class "mtk1" ]
                                                [ text ";" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "10", attribute "style" "top:171px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "        " ]
                                            , span [ class "mtk6" ]
                                                [ text "public" ]
                                            , span [ class "mtk1" ]
                                                [ text " col: " ]
                                            , span [ class "mtk6" ]
                                                [ text "number" ]
                                            , span [ class "mtk1" ]
                                                [ text ";" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "11", attribute "style" "top:190px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "        " ]
                                            , span [ class "mtk6" ]
                                                [ text "public" ]
                                            , span [ class "mtk1" ]
                                                [ text " live: " ]
                                            , span [ class "mtk6" ]
                                                [ text "boolean" ]
                                            , span [ class "mtk1" ]
                                                [ text ";" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "12", attribute "style" "top:209px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "        " ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "13", attribute "style" "top:228px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "        " ]
                                            , span [ class "mtk6" ]
                                                [ text "constructor" ]
                                            , span [ class "mtk1" ]
                                                [ text "(row: " ]
                                            , span [ class "mtk6" ]
                                                [ text "number" ]
                                            , span [ class "mtk1" ]
                                                [ text ", col: " ]
                                            , span [ class "mtk6" ]
                                                [ text "number" ]
                                            , span [ class "mtk1" ]
                                                [ text ", live: " ]
                                            , span [ class "mtk6" ]
                                                [ text "boolean" ]
                                            , span [ class "mtk1" ]
                                                [ text ") {" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "14", attribute "style" "top:247px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "            " ]
                                            , span [ class "mtk6" ]
                                                [ text "this" ]
                                            , span [ class "mtk1" ]
                                                [ text ".row = row;" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "15", attribute "style" "top:266px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "            " ]
                                            , span [ class "mtk6" ]
                                                [ text "this" ]
                                            , span [ class "mtk1" ]
                                                [ text ".col = col;" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "16", attribute "style" "top:285px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "            " ]
                                            , span [ class "mtk6" ]
                                                [ text "this" ]
                                            , span [ class "mtk1" ]
                                                [ text ".live = live" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "17", attribute "style" "top:304px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "        }" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "18", attribute "style" "top:323px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "    }" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "19", attribute "style" "top:342px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "    " ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "20", attribute "style" "top:361px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "    " ]
                                            , span [ class "mtk6" ]
                                                [ text "export" ]
                                            , span [ class "mtk1" ]
                                                [ text " " ]
                                            , span [ class "mtk6" ]
                                                [ text "class" ]
                                            , span [ class "mtk1" ]
                                                [ text " GameOfLife {" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "21", attribute "style" "top:380px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "        " ]
                                            , span [ class "mtk6" ]
                                                [ text "private" ]
                                            , span [ class "mtk1" ]
                                                [ text " gridSize: " ]
                                            , span [ class "mtk6" ]
                                                [ text "number" ]
                                            , span [ class "mtk1" ]
                                                [ text ";" ]
                                            ]
                                        ]
                                    , div [ class "view-line", attribute "linenumber" "22", attribute "style" "top:399px;height:19px;" ]
                                        [ span []
                                            [ span [ class "mtk1" ]
                                                [ text "        " ]
                                            , span [ class "mtk6" ]
                                                [ text "private" ]
                                            , span [ class "mtk1" ]
                                                [ text " canvasSize: " ]
                                            , span [ class "mtk6" ]
                                                [ text "number" ]
                                            , span [ class "mtk1" ]
                                                [ text ";" ]
                                            ]
                                        ]
                                    ]
                                , div [ class "contentWidgets", attribute "data-mprt" "1", attribute "style" "position: absolute; top: 0px;" ]
                                    []
                                , div [ class "cursors-layer cursor-line-style cursor-solid" ]
                                    [ div [ attribute "aria-hidden" "true", class "cursor", attribute "column" "2", attribute "linenumber" "1", attribute "role" "presentation", attribute "style" "height: 19px; top: 0px; left: 8px; font-family: Consolas, \" Courier New \", monospace; font-weight: normal; font-size: 14px; line-height: 19px; display: block; visibility: hidden; width: 2px;" ]
                                        []
                                    ]
                                ]
                            , div [ class "invisible scrollbar horizontal", attribute "style" "position: absolute; transform: translate3d(0px, 0px, 0px); width: 806px; height: 10px; left: 0px; bottom: 0px;" ]
                                [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; height: 10px; width: 806px; transform: translate3d(0px, 0px, 0px);" ]
                                    []
                                ]
                            , canvas [ class "decorationsOverviewRuler", attribute "data-transform" "translate3d(0px, 0px, 0px)", attribute "height" "400", attribute "style" "position: absolute; top: 0px; right: 0px; width: 14px; height: 400px; transform: translate3d(0px, 0px, 0px);", attribute "width" "14" ]
                                []
                            , div [ class "invisible scrollbar vertical fade", attribute "style" "position: absolute; transform: translate3d(0px, 0px, 0px); width: 14px; height: 400px; right: 0px; top: 0px;" ]
                                [ div [ class "slider", attribute "style" "position: absolute; top: 0px; left: 0px; width: 14px; height: 58px; transform: translate3d(0px, 0px, 0px);" ]
                                    []
                                ]
                            ]
                        , div [ attribute "style" "width: 868px;" ]
                            []
                        , div [ class "overlayWidgets", attribute "data-mprt" "4", attribute "style" "width: 868px;" ]
                            [ div [ attribute "aria-hidden" "false", class "editor-widget find-widget", attribute "style" "position: absolute;", attribute "widgetid" "editor.contrib.findWidget" ]
                                [ div [ attribute "aria-disabled" "true", attribute "aria-expanded" "false", attribute "aria-label" "Toggle Replace mode", class "button toggle left collapse disabled", attribute "role" "button", attribute "tabindex" "-1", title "Toggle Replace mode" ]
                                    []
                                , div [ class "find-part" ]
                                    [ div [ class "monaco-findInput disabled", attribute "style" "width: 221px;" ]
                                        [ div [ class "monaco-inputbox idle" ]
                                            [ div [ class "wrapper" ]
                                                [ input [ attribute "aria-label" "Find", attribute "autocapitalize" "off", attribute "autocorrect" "off", class "input", attribute "disabled" "", placeholder "Find", attribute "spellcheck" "false", attribute "style" "width: 155px;", title "Find", type_ "text", wrap "off" ]
                                                    []
                                                ]
                                            ]
                                        , div [ class "controls" ]
                                            [ div [ attribute "aria-checked" "false", attribute "aria-disabled" "true", attribute "aria-label" "Match Case (Alt+C)", class "custom-checkbox monaco-case-sensitive unchecked", attribute "role" "checkbox", title "Match Case (Alt+C)" ]
                                                []
                                            , div [ attribute "aria-checked" "false", attribute "aria-disabled" "true", attribute "aria-label" "Match Whole Word (Alt+W)", class "custom-checkbox monaco-whole-word unchecked", attribute "role" "checkbox", title "Match Whole Word (Alt+W)" ]
                                                []
                                            , div [ attribute "aria-checked" "false", attribute "aria-disabled" "true", attribute "aria-label" "Use Regular Expression (Alt+R)", class "custom-checkbox monaco-regex unchecked", attribute "role" "checkbox", title "Use Regular Expression (Alt+R)" ]
                                                []
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
                                , div [ class "replace-part" ]
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
                                ]
                            , div [ attribute "aria-hidden" "true", class "monaco-editor-background findOptionsWidget", attribute "data-editor-restorestyletop" "10px", attribute "role" "presentation", attribute "style" "display: none; top: 0px; position: absolute; right: 28px;", attribute "widgetid" "editor.contrib.findOptionsWidget" ]
                                [ div [ attribute "aria-checked" "false", attribute "aria-label" "Match Case (Alt+C)", class "custom-checkbox monaco-case-sensitive unchecked", attribute "role" "checkbox", attribute "tabindex" "0", title "Match Case (Alt+C)" ]
                                    []
                                , div [ attribute "aria-checked" "false", attribute "aria-label" "Match Whole Word (Alt+W)", class "custom-checkbox monaco-whole-word unchecked", attribute "role" "checkbox", attribute "tabindex" "0", title "Match Whole Word (Alt+W)" ]
                                    []
                                ]
                            , div [ attribute "aria-hidden" "true", class "monaco-editor-hover hidden", attribute "role" "presentation", attribute "style" "position: absolute;", attribute "widgetid" "editor.contrib.modesGlyphHoverWidget" ]
                                []
                            , div [ class "lightbulb-glyph hidden", attribute "style" "width: 21px; height: 20px; position: absolute;", title "Show Fixes (Ctrl+.)", attribute "widgetid" "__lightBulbWidget" ]
                                []
                            ]
                        , textarea [ attribute "aria-autocomplete" "both", attribute "aria-haspopup" "false", attribute "aria-label" "Editor content", attribute "aria-multiline" "true", attribute "autocapitalize" "off", attribute "autocorrect" "off", class "inputarea", attribute "data-mprt" "6", attribute "role" "textbox", attribute "spellcheck" "false", attribute "style" "top: 0px; left: 0px; font-family: Consolas, \" Courier New \", monospace; font-weight: normal; font-size: 14px; line-height: 19px;", wrap "off" ]
                            []
                        , div [ class "monaco-editor-background line-numbers textAreaCover", attribute "style" "position: absolute; width: 1px; height: 1px; top: 0px; left: 0px;" ]
                            []
                        ]
                    , div [ class "overflowingContentWidgets", attribute "data-mprt" "2" ]
                        [ div [ class "monaco-editor-hover hidden", attribute "style" "position: absolute; max-width: 1366px; visibility: hidden;", attribute "tabindex" "0", attribute "widgetid" "editor.contrib.modesContentHoverWidget" ]
                            [ div [ class "monaco-scrollable-element ", attribute "role" "presentation", attribute "style" "position: relative; overflow: hidden;" ]
                                [ div [ class "monaco-editor-hover-content", attribute "style" "overflow: hidden; font-size: 14px; line-height: 19px; max-height: 250px;" ]
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
                        , div [ class "editor-widget parameter-hints-widget", attribute "style" "font-size: 14px; max-height: 250px; position: absolute; max-width: 1366px; visibility: hidden;", attribute "widgetid" "editor.widget.parameterHintsWidget" ]
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
                        , div [ class "monaco-editor rename-box", attribute "style" "height: 19px; position: absolute; max-width: 1366px; visibility: hidden;", attribute "widgetid" "__renameInputWidget" ]
                            [ input [ attribute "aria-label" "Rename input. Type new name and press Enter to commit.", class "rename-input", attribute "style" "font-family: Consolas, \" Courier New \", monospace; font-weight: normal; font-size: 14px;", type_ "text" ]
                                []
                            ]
                        , div [ class "editor-widget suggest-widget", attribute "style" "position: absolute; max-width: 1366px; visibility: hidden;", attribute "widgetid" "editor.widget.suggestWidget" ]
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
                                    , span [ class "go-back", attribute "style" "height: 19px; width: 19px;", title "Go back" ]
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
                        ]
                    , div [ attribute "aria-hidden" "false", class "context-view monaco-menu-container bottom left builder-hidden", attribute "style" "top: 9px; left: 55.5px; width: initial;" ]
                        [ div [ class "monaco-menu" ]
                            [ div [ class "monaco-action-bar animated vertical" ]
                                [ ul [ class "actions-container", attribute "role" "toolbar" ]
                                    [ li [ class "action-item", attribute "role" "presentation" ]
                                        [ a [ class "action-label", attribute "role" "button", attribute "tabindex" "0" ]
                                            [ text "Go to Definition" ]
                                        , span [ class "keybinding" ]
                                            [ text "Ctrl+F12" ]
                                        ]
                                    , li [ class "action-item", attribute "role" "presentation" ]
                                        [ a [ class "action-label", attribute "role" "button", attribute "tabindex" "0" ]
                                            [ text "Peek Definition" ]
                                        , span [ class "keybinding" ]
                                            [ text "Alt+F12" ]
                                        ]
                                    , li [ class "action-item", attribute "role" "presentation" ]
                                        [ a [ class "action-label", attribute "role" "button", attribute "tabindex" "0" ]
                                            [ text "Find All References" ]
                                        , span [ class "keybinding" ]
                                            [ text "Shift+F12" ]
                                        ]
                                    , li [ class "action-item", attribute "role" "presentation" ]
                                        [ a [ class "action-label", attribute "role" "button", attribute "tabindex" "0" ]
                                            [ text "Go to Symbol..." ]
                                        , span [ class "keybinding" ]
                                            [ text "Ctrl+Shift+O" ]
                                        ]
                                    , li [ class "action-item disabled", attribute "role" "presentation" ]
                                        [ a [ class "action-label icon separator disabled", attribute "role" "button" ]
                                            []
                                        ]
                                    , li [ class "action-item", attribute "role" "presentation" ]
                                        [ a [ class "action-label", attribute "role" "button", attribute "tabindex" "0" ]
                                            [ text "Change All Occurrences" ]
                                        , span [ class "keybinding" ]
                                            [ text "Ctrl+F2" ]
                                        ]
                                    , li [ class "action-item", attribute "role" "presentation" ]
                                        [ a [ class "action-label", attribute "role" "button", attribute "tabindex" "0" ]
                                            [ text "Format Document" ]
                                        , span [ class "keybinding" ]
                                            [ text "Shift+Alt+F" ]
                                        ]
                                    , li [ class "action-item disabled", attribute "role" "presentation" ]
                                        [ a [ class "action-label icon separator disabled", attribute "role" "button" ]
                                            []
                                        ]
                                    , li [ class "action-item", attribute "role" "presentation" ]
                                        [ a [ class "action-label", attribute "role" "button", attribute "tabindex" "0" ]
                                            [ text "Command Palette" ]
                                        , span [ class "keybinding" ]
                                            [ text "F1" ]
                                        ]
                                    ]
                                ]
                            ]
                        ]
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
