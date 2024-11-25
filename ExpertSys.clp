%ExpertSystem
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


--------------------------------------------------------------------------------------------------------

% Knowledge Base


% First Aid Recommendations

first_aid([cut], "Clean the area with water and cover with a sterile bandage.").
%first_aid([cut, bleeding], "Apply direct pressure to the wound to stop bleeding. Clean the area with water and cover with a sterile bandage. Seek medical attention if bleeding doesn't stop.").
first_aid([burn, redness], "Stop the burning process. Run cool water over the burn for at least 10 minutes. Cover the burn with a sterile dressing. Do not apply ice or butter.").
first_aid([sprain, swelling], "Rest the injured area and avoid using it. Apply ice to reduce swelling. If pain persists, seek medical attention.").
first_aid([choking, coughing], "Encourage the person to cough if they can. If not, perform 5 back blows followed by 5 abdominal thrusts (Heimlich maneuver). Call emergency services if the person cannot breathe.").
first_aid([nosebleed], "Sit upright and lean forward slightly. Pinch the nostrils together for 5-10 minutes. Avoid swallowing the blood and seek medical help if the bleeding doesn't stop.").
first_aid([headache], "Rest in a quiet, dark room. Apply a cool compress to your forehead. Stay hydrated and consider over-the-counter pain relievers if necessary. If the headache persists, consult a doctor.").
first_aid([dizziness], "Sit or lie down until the feeling passes. Avoid sudden movements and hydrate. If dizziness continues or worsens, seek medical attention.").
first_aid([poisoning], "Call emergency services immediately. If the person is conscious, give them water to drink (avoid milk). Do not induce vomiting unless directed by a poison control center.").
first_aid([fracture], "Immobilize the injured area. Do not attempt to realign the bone. Apply ice to reduce swelling. Seek immediate medical help.").
first_aid([hypothermia], "Move the person to a warmer environment and wrap them in blankets. Provide warm, non-alcoholic beverages if conscious. Seek medical attention as hypothermia can be serious.").
first_aid([heatstroke], "Move the person to a cooler place, remove excess clothing, and hydrate with cool fluids. Apply cool cloths to the skin. If the person is unconscious or not improving, seek immediate medical help.").
first_aid([seizure], "Clear the area around the person to prevent injury. Do not restrain them or put anything in their mouth. After the seizure, help the person into a safe position and provide reassurance. Seek medical help if it's their first seizure or if it lasts more than 5 minutes.").

convert_input_to_list(Symptom, [Symptom]) :- 
    atom(Symptom).  % If it's an atom, make a list from it
convert_input_to_list(Symptoms, Symptoms) :- 
    is_list(Symptoms).  % If it's already a list, keep it as is


% Main predicate that prompts for symptoms and provides remedies
run_program :-
    write('Enter symptoms as a Prolog list, e.g., [cut, bleeding], or a single symptom, e.g., cut: '), nl,
    read(Input),  % Read input as a Prolog term (can be an atom or a list)
    convert_input_to_list(Input, Symptoms),  % Convert to a list if needed
    (   first_aid(Symptoms, Recommendation)
    ->  format('First Aid Recommendation: ~s~n', [Recommendation])  % Use ~s for strings
    ;   write('No recommendation available for these symptoms.'), nl).

% Entry point for the program
start :-
    run_program.

% Initialization directive
:- initialization(start).




-------------------------------------------------------------------------------------------------




% Define facts and rules for sport suggestion
likes_running(yes, running).
prefers_contact(yes, basketball).
prefers_contact(no, tennis).
likes_throwing(yes, basketball).
likes_throwing(no, football).
likes_playing_alone(yes, swimming).
likes_playing_alone(no, archery).
likes_water_sports(yes, swimming).
likes_water_sports(no, archery).
likes_music_exercise(yes, 'ballroom dancing').
likes_music_exercise(no, 'table tennis').

% Start the expert system with hard-coded inputs
start :-
    % Hard-coded answers for testing
    RunningAnswer = yes,         % Change this to no if needed
    ContactAnswer = yes,         % Change this to no if needed
    ThrowingAnswer = yes,        % Change this to no if needed
    AloneAnswer = yes,           % Change this to no if needed
    WaterAnswer = no,            % Change this to yes if needed
    MusicAnswer = yes,           % Change this to no if needed

    % Question 1: Do you like running?
    (RunningAnswer = yes ->
        (ContactAnswer = yes ->
            (ThrowingAnswer = yes ->
                Sport = basketball
            ;
                Sport = football)
        ;
            Sport = tennis)
    ;
        (AloneAnswer = yes ->
            (WaterAnswer = yes ->
                Sport = swimming
            ;
                Sport = archery)
        ;
            (MusicAnswer = yes ->
                Sport = 'ballroom dancing'
            ;
                Sport = 'table tennis'))),
    format('Based on your preferences, you may enjoy ~w.~n', [Sport]).

% Initialization directive for OneCompiler compatibility
:- initialization(start).
