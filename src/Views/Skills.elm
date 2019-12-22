module Views.Skills exposing (view)

import Model exposing (Model, Character, Skills, Message)
import SkillCheck exposing (DiceRoll)
import Html exposing (Html, div, span, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import EditableField exposing (editableField)


view : Model -> Html Message
view model = 
    let character = model.character
        base    = character.baseStats
        skills  = character.skills
        skill updater name bonus against = div []
            [ span []
                [ text (name ++ ": "), editableField model updater (String.fromInt bonus)
                ]
            , button [onClick (Model.Roll { bonus = bonus, against = against})] [text "Würfeln"]
            ]
    in 
        div [class "skills"] 
        [ skill updateClimb "Klettern" skills.climb (DiceRoll base.mu base.ge base.kk)
        , skill updateBodyControl "Körperbeherrschung" skills.bodyControl (DiceRoll base.ge base.ge base.ko)
        , skill updateComposure "Selbstbeherrschung" skills.composure (DiceRoll base.mu base.mu base.ko)
        , skill updateAcuity "Sinnesschärfe" skills.acuity (DiceRoll base.kl base.int base.int)
        , skill updatePickpocket "Taschendiebstahl" skills.pickpocket (DiceRoll base.mu base.ff base.ge)
        , skill updateHide "Verbergen" skills.hide (DiceRoll base.mu base.int base.ge)
        , skill updateAlleyLore "Gassenwissen" skills.alleyLore (DiceRoll base.kl base.int base.ch)
        , skill updateInsight "Menschenkenntnis" skills.insight (DiceRoll base.kl base.int base.ch)
        , skill updatePersuade "Überreden" skills.persuade (DiceRoll base.mu base.int base.ch)
        , skill updateLockpicking "Schlösserknacken" skills.lockpicking (DiceRoll base.int base.ff base.ff)
        ]
 

updateClimb : String -> Character -> Character
updateClimb = update .climb (\s v -> {s | climb = v})
updateBodyControl = update .bodyControl (\s v -> {s | bodyControl = v})
updateComposure = update .composure (\s v -> {s | composure = v})
updateAcuity = update .acuity (\s v -> {s | acuity = v})
updatePickpocket = update .pickpocket (\s v -> {s | pickpocket = v})
updateHide = update .hide (\s v -> {s | hide = v})
updateAlleyLore = update .alleyLore (\s v -> {s | alleyLore = v})
updateInsight = update .insight (\s v -> {s | insight = v})
updatePersuade = update .persuade (\s v -> {s | persuade = v})
updateLockpicking = update .lockpicking (\s v -> {s | lockpicking = v})

update : (Skills -> Int) -> (Skills -> Int -> Skills) -> String -> Character -> Character
update defaultGetter setter value character = 
  let skills = character.skills
  in  {character | skills = setter skills (Maybe.withDefault (defaultGetter skills) (String.toInt value))}