@echo off
:: SET IT AS FULLSCREEN
MODE CON COLS=999 LINES=999
title POKEBATCH
echo \---------------------------------------------------\
echo  \    PokeBatch - The Pokemon experience in Batch    \
echo   \---------------------------------------------------\
pause



:GENDER
cls
echo Before you journey into the world of
echo pokebatch begins, you must first
echo reveal something about yourself.
pause
echo.
set /p gender=Are you a boy or a girl?: %=%
if (%gender%)==(boy) set gender=boy
if (%gender%)==(girl) set gender=girl
if (%gender%)==(Boy) set gender=boy
if (%gender%)==(Girl) set gender=girl
if (%gender%)==(male) set gender=boy
if (%gender%)==(female) set gender=girl
if (%gender%)==(Male) set gender=boy
if (%gender%)==(Female) set gender=girl
if (%gender%)==(bisexual) set gender=bisex
if (%gender%)==(gay boy) set gender=gb
if (%gender%)==(gay girl) set gender=gg
if (%gender%)==(gay male) set gender=gb
if (%gender%)==(gay female) set gender=gg

if (%gender%)==(boy) set gender_rel_parent=son
if (%gender%)==(girl) set gender_rel_parent=daughter
if (%gender%)==(gb) set gender_rel_parent=son
if (%gender%)==(gg) set gender_rel_parent=daughter

if (%gender%)==(boy) goto INTRO
if (%gender%)==(girl) goto INTRO
if (%gender%)==(bisex) (
	echo ...
	pause
	goto INTRO
)
if (%gender%)==(gb) (
	echo ...
	pause
	goto INTRO
)
if (%gender%)==(gg) (
	echo ...
	pause
	goto INTRO
)
goto REDOGENDER

:REDOGENDER
cls
echo Before you journey into the world of
echo pokebatch begins, you must first
echo reveal something about yourself.
echo Press any key to continue . . .
echo.
set /p gender=Are you a boy or a girl?: %=%
if (%gender%)==(boy) set gender=boy
if (%gender%)==(girl) set gender=girl
if (%gender%)==(Boy) set gender=boy
if (%gender%)==(Girl) set gender=girl
if (%gender%)==(male) set gender=boy
if (%gender%)==(female) set gender=girl
if (%gender%)==(Male) set gender=boy
if (%gender%)==(Female) set gender=girl
if (%gender%)==(bisexual) set gender=bisex
if (%gender%)==(gay boy) set gender=gb
if (%gender%)==(gay girl) set gender=gg
if (%gender%)==(gay male) set gender=gb
if (%gender%)==(gay female) set gender=gg

if (%gender%)==(boy) set gender_rel_parent=son
if (%gender%)==(girl) set gender_rel_parent=daughter
if (%gender%)==(gb) set gender_rel_parent=son
if (%gender%)==(gg) set gender_rel_parent=daughter

if (%gender%)==(boy) goto INTRO
if (%gender%)==(girl) goto INTRO
if (%gender%)==(bisex) (
	echo ...
	pause
	goto INTRO
)
if (%gender%)==(gb) (
	echo ...
	pause
	goto INTRO
)
if (%gender%)==(gg) (
	echo ...
	pause
	goto INTRO
)
goto REDOGENDER



:INTRO            
cls
echo Prof. Oak approaches
pause
echo.
echo Prof. Oak: Hi. My name is Prof. Oak.
pause
echo.
echo Prof. Oak: Welcome to the wonderful world of Pokemon!
pause
echo.
set /p name=Prof. Oak: It seems I don't remember your name. What is it?: %=%
if (%name%)==() goto REDONAME
echo.
if (%gender%)==(bisex) goto EASTER_BISEX_1
echo Prof. Oak: Ahh! %name%! I remember now! You're that %gender_rel_parent%
echo of the new researcher in town!
pause
echo.
:EASTER_RETURN_BISEX_1
echo Prof. Oak: Welcome to town! Would you like to be a pokemon trainer?
pause
echo.
echo %name%: I'm not sure
pause
echo.
echo Prof. Oak: That's fine! I can already tell that you'll make a
echo great pokemon trainer!
pause

cls
echo Prof. Oak: Follow me...
pause
goto CHOOSE_POKEMON

:REDONAME
cls
echo Prof. Oak approaches
echo Press any key to continue . . .
echo.
echo Prof. Oak: Hi. My name is Proffessor Oak.
echo Press any key to continue . . .
echo.
echo Prof. Oak: Welcome to the wonderful world of Pokemon!
echo Press any key to continue . . .
echo.
set /p name=Prof. Oak: It seems I don't remember your name. What is it?: %=%
if (%name%)==() goto REDONAME
echo.
if (%gender%)==(bisex) goto EASTER_BISEX_1
echo Prof. Oak: Ahh! %name%! I remember now! You're that %gender_rel_parent%
echo of the new researcher in town!
pause
echo.
:EASTER_RETURN_BISEX_1
echo Prof. Oak: Welcome to town! How would you like to be a pokemon trainer?
pause
echo.
echo %name%: I'm not sure
pause
echo.
echo Prof. Oak: That's fine! I can already tell that you'll make a
echo great pokemon trainer!
pause

cls
echo Prof. Oak: Follow me...
pause
goto CHOOSE_POKEMON



:CHOOSE_POKEMON
echo Prof. Oak: So %name% what are you waiting for? Choose your pokemon.
pause
set starterno=1
set starter=Bulbasaur

:CHOOSING
if (%name%)==(Ash) goto EASTER_ASH
if (%starterno%)==(4) set starterno=1

:CHOOSING_2
if (%starterno%)==(1) goto CHOOSING_BULBASAUR
if (%starterno%)==(2) goto CHOOSING_CHARMANDER
if (%starterno%)==(3) goto CHOOSING_SQUIRTLE
if (%starterno%)==(4) goto CHOOSING_PIKACHU

:CHOOSING_BULBASAUR
cls

set pokemode=starter
call "resources/pokemon/bulbasaur_graphics.cmd"

echo Prof. Oak: Do you want to pick Bulbasaur?
set /p choosing_pokemon=Y/N: %=%
if (%choosing_pokemon%)==(Y) set choosing_pokemon=y
if (%choosing_pokemon%)==(y) set choosing_pokemon=y
if (%choosing_pokemon%)==(Yes) set choosing_pokemon=y
if (%choosing_pokemon%)==(yes) set choosing_pokemon=y
if (%choosing_pokemon%)==(y) (
	set starter=Bulbasaur
	goto CHOSEN	
)
set /a starterno += 1
goto CHOOSING

:CHOOSING_SQUIRTLE
cls

set pokemode=starter
call "resources/pokemon/squirtle_graphics.cmd"

echo Prof. Oak: Do you want to pick Squirtle?
set /p choosing_pokemon=Y/N: %=%
if (%choosing_pokemon%)==(Y) set choosing_pokemon=y
if (%choosing_pokemon%)==(y) set choosing_pokemon=y
if (%choosing_pokemon%)==(Yes) set choosing_pokemon=y
if (%choosing_pokemon%)==(yes) set choosing_pokemon=y
if (%choosing_pokemon%)==(y) (
	set starter=Squirtle
	goto CHOSEN	
)
set /a starterno += 1
goto CHOOSING

:CHOOSING_CHARMANDER
cls

set pokemode=starter
call "resources/pokemon/charmander_graphics.cmd"

echo Prof. Oak: Do you want to pick Charmander?
set /p choosing_pokemon=Y/N: %=%
if (%choosing_pokemon%)==(Y) set choosing_pokemon=y
if (%choosing_pokemon%)==(y) set choosing_pokemon=y
if (%choosing_pokemon%)==(Yes) set choosing_pokemon=y
if (%choosing_pokemon%)==(yes) set choosing_pokemon=y
if (%choosing_pokemon%)==(y) (
	set starter=Charmander
	goto CHOSEN	
)
set /a starterno += 1
goto CHOOSING

:CHOOSING_PIKACHU
cls

set pokemode=starter
call "resources/pokemon/pikachu_graphics.cmd"

echo Prof. Oak: Do you want to pick Pikachu?
echo Be careful this pokemon is very energetic.
set /p choosing_pokemon=Y/N: %=%
if (%choosing_pokemon%)==(Y) set choosing_pokemon=y
if (%choosing_pokemon%)==(y) set choosing_pokemon=y
if (%choosing_pokemon%)==(Yes) set choosing_pokemon=y
if (%choosing_pokemon%)==(yes) set choosing_pokemon=y
if (%choosing_pokemon%)==(y) (
	set starter=Pikachu
	goto CHOSEN	
)
set /a starterno=1
goto CHOOSING



:CHOSEN
cls
echo Prof. Oak: Congratulations! From here on you are now a pokemon trainer!
echo Here, take this with you.
echo [%name% obtained the pokegear!]
echo Prof. Oak: This will help you along the way.
pause

cls

set badge_total=0
set mom_event=0
set stone_fire=0
set wing_rainbow=0
set league_level=0

title POKEBATCH - %names%'s journey with %starter% - %badge_total%

echo Prof. Oak: Now your journey begins with %starter%
echo Prof. Oak: Collect gym badges and compete in the Pokemon League.
echo Prof. Oak: Good luck!
pause

goto START





::Only editted up to here
::Easter eggs (move to EOF (or separate file) when possible)

:EASTER_ASH
if (%starterno%)==(5) starterno=1
goto CHOOSING_2

:EASTER_BISEX_1
echo Prof. Oak: Ahh! %name%! I remember now! You're that... hmm...
pause
echo Prof. Oak: Nevermind!
echo.
goto EASTER_RETURN_BISEX_1






:START
::set starter-lvl=4
::set starter-hp=20
::set starter-att=2
::set starter-def=2
::set starter-spd=2
::set starter-spatt=2
::set starter-spdef=2


::Maribou town
::Rienna city
::Vicarian city
::Aminos city

:city1
::Maribou town
cls
echo You are in Maribou town
echo Enter option number to pick an option (1,2,3,4)
echo 1) Go to your home
echo 2) Go to Pokemon Center
echo 3) Go to Pokemon Lab
echo 4) Go to tall grass to exit Maribou town
pause
set /p city1option=

if '%city1option%' == '1' goto city1-1
if '%city1option%' == '2' goto city1-2
if '%city1option%' == '3' goto city1-3
if '%city1option%' == '4' goto city1-4

:city1-1
cls
echo \---------------------------------------------------\
echo  \                         Home                      \
echo   \---------------------------------------------------\
echo      __!!_______________
echo     /  !!             /\\
echo    /  /__\           /  \\
echo   /_________________/    \\
echo   !                !  /\  !
echo   !                ! /  \ !
echo   !________________! !  ! !
echo.
echo You are inside your home
echo Enter option number to pick an option (1,2,3)
echo 1) Talk to your Mom
echo 2) Eat food and take rest
echo 3) Go back to town
pause

set /p city1-1option=

if '%city1-1option%' == '1' goto city1-1-1
if '%city1-1option%' == '2' goto city1-1-2
if '%city1-1option%' == '3' goto city1

:city1-1-1
cls
if '%mom%' == '0' (
    echo Mom: %name%! I hate you and your unknown father.
    echo Mom: Go wander around the world on foot for years and never come back!
    echo Mom: But first take these running shoes.
    echo Mom: These won't have any effect in PokeBatch but I'm just giving it so you don't complain.
    set mom=1
    pause
    goto city1-1
)
if '%mom%' == '1' (
    echo Mom: What's the matter? Did you bring something for me?
    echo Mom: No? Get the hell out of my house then! :D
    pause
    goto city1-1
)
if '%mom%' == '2' (
    echo Mom: What's the matter? Did you bring something for me?
    echo Mom: Ooooh! That's a HUGE diamond! I almost love you! :)
    echo (Handed over the diamond)
    echo Mom: Here, take this fire stone from your father's collection.
    echo (Received Fire stone)
    set fstone=1
    set mom=3
    pause
    goto city1-1
)
if '%mom%' == '3' (
    echo Mom: Yay! Did you bring something else for me?
    echo Mom: No? Oh well, guess I still hate you. :)
    pause
    goto city1-1
)
if '%mom%' == '4' (
    echo Mom: Well? What is it? A surprise you say?
    echo (Hands over the Jade necklace)
    echo Mom: OMG! O_O I love it!!
    echo Mom: You deserve this Rainbow Wing
    echo (Received Rainbow Wing)
    set rwing=1
    set mom=5
    echo Mom: Let me quote your father.
    echo "Only a true Pokemon Champion can make use of this Rainbow Wing."
    echo "The legendary Ho-Oh will appear before only him who is pure of heart and has a strong will."
    echo "He must go to the Bell Tower in Vicarian city at once."
    echo "But there is one thing you should kno... "
    echo Mom: And the rest is unreadable. Your crazy father and his ramblings about some legendary pokemon.
    pause
    goto city1-1
)
if '%mom%' == '5' (
    echo Mom: You know what? You aren't that bad :)
    pause
    goto city1-1
)
if '%mom%' == '6' (
    echo Mom: What the.. Is that a Ho-Oh? :O
    echo Mom: That means your father wasn't a loser!
    pause
    goto city1-1
)

:city1-1-2
cls
echo You ate lots of delicious food.. OM NOM NOM NOM
echo You are feeling sleepy. What was in the food?!
echo You wake up 12 hours later. Your %starter% has recovered his HP.
set /a starter-hp=10*%starter-lvl%
pause
goto :city1-1

:city1-2
cls
echo \---------------------------------------------------\
echo  \                   Pokemon Center                  \
echo   \---------------------------------------------------\
echo.
echo     ___________________
echo    /___________________\
echo    !       //_\\       !
echo    !_______\\_//_______!
echo    !     !  ___  !     !
echo    !     ! !   ! !     !
echo    !_____! !___! !_____!
echo.
echo You are inside the Pokemon Center
echo Enter option number to pick an option (1,2,3)
echo 1) Get your pokemon healed by Nurse Joy
echo 2) Get other services from Nurse Joy ;)
echo 3) Go back to town
pause

set /p city1-2option=

if '%city1-2option%' == '1' goto city1-2-1
if '%city1-2option%' == '2' goto city1-2-2
if '%city1-2option%' == '3' goto city1

:city1-2-1
cls
echo Nurse Joy: My my, your %starter% doesn't look very good
echo Nurse Joy: Here let me fix him with my love!
echo Your %starter% is blushed red
echo Nurse Joy: Here you go better than ever.
echo %starter%: %STARTER%!
echo Your %starter% has recovered his HP.
set /a starter-hp=10*%starter-lvl%
pause
goto city1-2

:city1-2-2
cls
echo %name%: Hey Joy, how about you show me your "Pokemons" ;)
if '%leaguecup%' == '0' (
echo Nurse Joy: I don't think you are trained enough to handle them kid.
echo Nurse Joy: Buzz off like a Beedrill before I doublekick you!
echo You run away to town hiding your face.
)
if '%leaguecup%' == '1' (
:: ;)
)
pause
goto city1

:city1-3
cls
echo \---------------------------------------------------\
echo  \                     Pokemon Lab                   \
echo   \---------------------------------------------------\
echo.
echo           _______
echo        .           .
echo     /      //_\\      \
echo    !_______\\ //_______!
echo    /___________________\
echo    !     !  ___  !     !
echo    !     ! /   \ !     !
echo    !_____! !___! !_____!
echo.
echo You are inside the Pokemon Lab
echo Enter option number to pick an option (1,2)
echo 1) Talk to Professor Oak
echo 2) Go back to town
pause

set /p city1-2option=

if '%city1-2option%' == '1' goto city1-3-1
if '%city1-2option%' == '2' goto city1

:city1-3-1
cls
echo Prof Oak: Oh hi %name% I am a little busy right now.
echo Prof Oak: Come back after you've won a gym batch.
pause
goto city1

:city1-4
cls
echo \---------------------------------------------------\
echo  \                     Tall grass                    \
echo   \---------------------------------------------------\
echo.
echo    )\  )\ )\ )\ /(  (\ )\  )\  )\  /( /( )\  (\ (\ /)  )\
echo    /( /( )\  (\ (\ /)  )\  )\  )\ )\ )\ /(  (\ )\  )\  )\
echo    )\  (\ (\ /)  )\ (\ )\  )\  )\  /( /( )\ )\ )\ )\ /(  (\
echo.
echo You stepped out of Maribou town.
echo Since your town is very small you can already see Rienna city.
echo Rienna city is famous for their berries and grass pokemon.
echo.
echo You are walking on tall grass
echo Something is inside the grass

setlocal ENABLEDELAYEDEXPANSION
set /a r=%random% %%!3 +1
::Caterpie Oddish Rattata Cubone
if '%r%' == '0' (
    set wildpkmn=Caterpie
    goto wildpokemon
)
if '%r%' == '1' (
    set wildpkmn=Oddish
    goto wildpokemon
)
if '%r%' == '2' (
    set wildpkmn=Rattata
    goto wildpokemon
)
if '%r%' == '3' (
    set wildpkmn=Cubone
    goto wildpokemon
)
:wildpokemon
echo A wild %wildpkmn% has appeared
echo.
echo %wildpkmn%: %wildpkmn%
set wildpkmn-lvl=2
set wildpkmn-hp=10
set wildpkmn-hp=20
set wildpkmn-att=2
set wildpkmn-def=2
set wildpkmn-spd=2
set wildpkmn-spatt=2
set wildpkmn-spdef=2
echo.
echo %name%: Go %starter% I choose you!
echo %starter%: %starter%
pause

:wildpokemon-battle
cls
echo \---------------------------------------------------\
echo  \                 %wildpkmn% (Lvl %wildpkmn-lvl%)                \
echo   \---------------------------------------------------\
echo.
echo HP: %wildpkmn-hp%
echo.
echo.
echo \---------------------------------------------------\
echo  \                 %starter% (Lvl %starter-lvl%)                \
echo   \---------------------------------------------------\
echo.
echo HP: %starter-hp%
echo.
echo.
echo What do you want to do?
echo.
echo Enter option number to pick an option (1,2)
echo 1) Tackle Attack
echo 2) Bite
echo 3) [Run]

set /p starter-atk=
pause

set /a critical=%random% %%!100

if (%wildpkmn-atk%)== '1' set impact-wildpkmn=((2*%wildpkmn-att%)/2)*(%critical%+1)
if (%wildpkmn-atk%)== '2' set impact-wildpkmn=((3*%wildpkmn-att%)/2)*(%critical%+1)

cls
echo \---------------------------------------------------\
echo  \                 %wildpkmn% (Lvl %wildpkmn-lvl%)                \
echo   \---------------------------------------------------\
echo.
echo HP: %wildpkmn-hp%

set wildpkmn-hp=%wildpkmn-hp%-(%impact-wildpkmn%-%wildpkmn-def%)

if '%critical%' == '0' echo %wildpkmn% lost %impact-wildpkmn% HP
if '%critical%' == '1' (
    echo Critical Hit!
    echo %wildpkmn% lost %impact-wildpkmn% HP
)

echo HP: %wildpkmn-hp%
echo.
if %wildpkmn-hp% <=0 goto wild-1-victory

echo \---------------------------------------------------\
echo  \                 %starter% (Lvl %starter-lvl%)                \
echo   \---------------------------------------------------\
echo.
echo HP: %starter-hp%
echo.
echo.

set /a wildpkmn-hit=%random% %%!1 +1
set /a critical=%random% %%!1 +1

if '%wildpkmn-hit%' == '0' set impact-starter=((2*%starter-att%)/2)*(%critical%+1)
if '%wildpkmn-hit%' == '1' set impact-starter=((3*%starter-att%)/2)*(%critical%+1)
set starter-hp=%starter-hp%-(%impact-starter%-%starter-def%)

if '%critical%' == '0' echo %starter% lost %impact-starter% HP
if '%critical%' == '1' (
    echo Critical Hit!
    echo %starter% lost %impact-starter% HP
)

echo HP: %starter-hp%
echo.
echo.

if %starter-hp% <=0 goto gameover

goto wildpokemon-battle

:wild-1-victory
cls
echo \---------------------------------------------------\
echo  \                 %wildpkmn% (Lvl %wildpkmn-lvl%)                \
echo   \---------------------------------------------------\
echo.
echo HP: 0
echo.
echo.
echo \---------------------------------------------------\
echo  \                 %starter% (Lvl %starter-lvl%)                \
echo   \---------------------------------------------------\
echo.
echo HP: %starter-hp%
echo.
echo.
echo %wildpkmn% has fainted
echo.
echo %starter% gained 100 experience points
set /a starter-lvl=%starter-lvl%+1
set /a starter-hp=10*%starter-lvl%
set /a starter-att=%starter-att%+1
set /a starter-def=%starter-def%+1
set /a starter-spd=10*%starter-spd%+1
set /a starter-spatt=10*%starter-spatt%+1
set /a starter-spdef=10*%starter-spdef%+1

echo %starter% reached Level %starter-lvl%
echo %starter%'s HP increased to %starter-hp%
echo %starter%'s Attack increased to %starter-att%
echo %starter%'s Defense increased to %starter-def%
echo %starter%'s Speed increased to %starter-spd%
echo %starter%'s Sp.Attack increased to %starter-spatt%
echo %starter%'s Sp.Defense increased to %starter-spdef%
pause
goto city-2

:gameover
cls
echo \---------------------------------------------------\
echo  \                 %wildpkmn% (Lvl %wildpkmn-lvl%)                \
echo   \---------------------------------------------------\
echo.
echo HP: %wildpkmn-hp%
echo.
echo.
echo \---------------------------------------------------\
echo  \                 %starter% (Lvl %starter-lvl%)                \
echo   \---------------------------------------------------\
echo.
echo HP: 0
echo.
echo.
echo %starter% has fainted
echo You don't have any more Pokemon
echo %name% runs away to Maribou town to his home.
goto start

:city-2
::Rienna city
cls
echo You are in Rienna city
echo Enter option number to pick an option (1,2,3,4)
echo 1) Talk to the camper
echo 2) Go near the fountain
echo 3) Go to the crossroads
echo 4) Go to Pokemon center
pause
set /p city2option=

if '%city2option%' == '1' goto city2-1
if '%city2option%' == '2' goto city2-2
if '%city2option%' == '3' goto city2-3
if '%city2option%' == '4' goto city2-4