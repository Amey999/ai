% Facts for responses
:- dynamic likes_running/2.
:- dynamic prefers_contact/2.
:- dynamic likes_playing_alone/2.
:- dynamic likes_throwing/2.
:- dynamic likes_water_sports/2.
:- dynamic likes_music_exercise/2.
:- dynamic likes_team_sports/2.

% Questions
ask(Question, Answer) :-
    write(Question), nl,
    read(Response),
    (Response = yes -> Answer = yes ; Answer = no).


% Sports Expert System rules


% Start the system
start :-
    write("Welcome to the Sports Expert System"), nl,
    sport_suggestion(_, Sport),
    format('Based on your preferences, you may enjoy ~w.~n', [Sport]).


% Running Question
sport_suggestion(Person, Sport) :-
    ask("Do you like running? (yes/no)", Answer),
    assert(likes_running(Person, Answer)),
    
    (Answer = yes ->
        contact_sport(Person, Sport)
    ;
        likes_alone_sport(Person, Sport)).


% Contact Sport Question
contact_sport(Person, Sport) :-
    ask("Do you prefer contact sports? (yes/no)", Answer),
    assert(prefers_contact(Person, Answer)),
    
    (Answer = yes ->
        throwing_sport(Person, Sport)
    ;
        team_or_individual(Person, Sport)).


% Throwing or Kicking Sport Question
throwing_sport(Person, Sport) :-
    ask("Do you like throwing or kicking? (yes - throwing/no - kicking)", Answer),
    assert(likes_throwing(Person, Answer)),
    
    (Answer = yes ->
        Sport = basketball/ rugby
    ;
     Answer = no ->
        Sport = football
   
    ).


% Team or Individual Sport Question
team_or_individual(Person, Sport) :-
    ask("Do you like playing on a team? (yes/no)", Answer),
    assert(likes_team_sports(Person, Answer)),
    (Answer = yes ->
        Sport = cricket 
    ;
        Sport = tennis).  


% Likes Playing Alone Question
likes_alone_sport(Person, Sport) :-
    ask("Do you like playing sports alone? (yes/no)", Answer),
    assert(likes_playing_alone(Person, Answer)),
    
    (Answer = yes ->
        water_sport(Person, Sport)
    ;
        music_exercise(Person, Sport)).


% Water Sport Question
water_sport(Person, Sport) :-
    ask("Do you like water sports? (yes/no)", Answer),
    assert(likes_water_sports(Person, Answer)),
    
    (Answer = yes ->
        Sport = swimming
    ;
        Sport = archery).


% Exercising to Music Question
music_exercise(Person, Sport) :-
    ask("Do you like exercising to music? (yes/no)", Answer),
    assert(likes_music_exercise(Person, Answer)),
    
    (Answer = yes ->
        Sport = ballroom_dancing
    ;
        Sport = table_tennis).