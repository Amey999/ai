%Family Tree
% Defining males and females
male(baliramji).
male(namdev).
male(sukhdeo).
male(eknath).
male(ram).
male(prashant).
male(suresh).
male(shrikant).
male(pramod).
male(ankush).
male(roshan).
male(ninad).
male(anil).
male(praveen).
male(dadu).
male(aaryan).
male(amey).
male(shrivesh).
male(tushar).
male(rudra).

female(kamla).
female(usha).
female(sarika).
female(jaymala).
female(kavita).
female(surekanta).
female(kalyani).
female(nilima).
female(harsha).
female(nita).
female(asha).
female(roshni).
female(dipali).
female(aarti).
female(sayli).
female(poonam).
female(swara).

% Defining parent-child relationships
parent(baliramji, usha).
parent(baliramji, namdev).
parent(baliramji, sukhdeo).
parent(baliramji, eknath).
parent(baliramji, ram).

parent(kamla, usha).
parent(kamla, namdev).
parent(kamla, sukhdeo).
parent(kamla, eknath).
parent(kamla, ram).

% Usha and Prashant couple and their children
parent(usha, ankush).
parent(usha, roshan).
parent(prashant, ankush).
parent(prashant, roshan).

% Roshan and Kalyani couple and their child
parent(roshan, rudra).
parent(kalyani, rudra).

% Namdev and Sarika couple and their child
parent(namdev, suresh).
parent(sarika, suresh).

% Suresh and Nilima couple and their children
parent(suresh, sayli).
parent(suresh, aaryan).
parent(nilima, sayli).
parent(nilima, aaryan).

% Sukhdeo and Jaymala couple and their children
parent(sukhdeo, shrikant).
parent(sukhdeo, pramod).
parent(jaymala, shrikant).
parent(jaymala, pramod).

% Shrikant and Harsha couple and their children
parent(shrikant, amey).
parent(shrikant, shrivesh).
parent(harsha, amey).
parent(harsha, shrivesh).

% Pramod and Nita couple and their children
parent(pramod, sakshi).
parent(pramod, aashay).
parent(nita, sakshi).
parent(nita, aashay).

% Eknath and Kavita couple and their children
parent(eknath, asha).
parent(eknath, rahul).
parent(kavita, asha).
parent(kavita, rahul).

% Asha and Sanket couple and their children
parent(asha, poonam).
parent(asha, tushar).
parent(sanket, poonam).
parent(sanket, tushar).

% Rahul and Roshni couple and their child
parent(rahul, ninad).
parent(roshni, ninad).

% Ram and Surekanta couple and their children
parent(ram, anil).
parent(ram, praveen).
parent(surekanta, anil).
parent(surekanta, praveen).

% Anil and Dipali couple and their child
parent(anil, dadu).
parent(dipali, dadu).

% Praveen and Aarti couple and their children
parent(praveen, swara).
parent(praveen, anav).
parent(aarti, swara).
parent(aarti, anav).

% Basic family relationships
father(X, Y) :- male(X), parent(X, Y).
mother(X, Y) :- female(X), parent(X, Y).
child(X, Y) :- parent(Y, X).
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
brother(X, Y) :- male(X), sibling(X, Y).
sister(X, Y) :- female(X), sibling(X, Y).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandfather(X, Y) :- male(X), grandparent(X, Y).
grandmother(X, Y) :- female(X), grandparent(X, Y).
wife(X, Y) :- female(X), male(Y), parent(X, Z), parent(Y, Z).
husband(X, Y) :- male(X), female(Y), parent(X, Z), parent(Y, Z).
niece(X, Y) :- female(X), sibling(Y, Z), parent(Z, X).
nephew(X, Y) :- male(X), sibling(Y, Z), parent(Z, X).
father_in_law(X, Y) :- male(X), wife(W, Y), parent(X, W).
father_in_law(X, Y) :- male(X), husband(W, Y), parent(X, W).
mother_in_law(X, Y) :- female(X), wife(W, Y), parent(X, W).
mother_in_law(X, Y) :- female(X), husband(W, Y), parent(X, W).
cousin(X, Y) :- parent(A, X), parent(B, Y), sibling(A, B).
maternal_uncle(X, Y) :- male(X), parent(Z, Y), sister(Z, X).
maternal_aunt(X, Y) :- female(X), parent(Z, Y), sister(X, Z).
paternal_uncle(X, Y) :- male(X), parent(Z, Y), brother(X, Z).
paternal_aunt(X, Y) :- female(X), parent(Z, Y), sister(X, Z).
son_in_law(X, Y) :- male(X), wife(W, X), parent(Y, W).
daughter_in_law(X, Y) :- female(X), husband(W, X), parent(Y, W).
great_grandfather(X, Y) :- male(X), parent(X, Z), grandparent(Z, Y).
great_great_grandfather(X, Y) :- male(X), parent(X, Z), grandparent(Z, W), parent(W, Y).
son(X, Y) :- male(X), child(X, Y).
daughter(X, Y) :- female(X), child(X, Y).

% Find parents, grandparents, cousins, and relations
find_parents(Person, Parents) :- 
    setof(P, parent(P, Person), Parents).

find_grandparents(Person, Grandparents) :- 
    setof(G, grandparent(G, Person), Grandparents).

find_cousins(Person, Cousins) :- 
    setof(C, cousin(Person, C), Cousins).

find_relation(Person1, Person2, Relation) :- 
    ( parent(Person1, Person2) -> Relation = 'parent'  
    ; parent(Person2, Person1) -> Relation = 'child'
    ; grandparent(Person1, Person2) -> Relation = 'grandparent'
    ; grandparent(Person2, Person1) -> Relation = 'grandchild'
    ; great_grandfather(Person1, Person2) -> Relation = 'great-grandfather'
    ; great_great_grandfather(Person1, Person2) -> Relation = 'great-great-grandfather'
    ; great_grandfather(Person2, Person1) -> Relation = 'great-grandchild'
    ; great_great_grandfather(Person2, Person1) -> Relation = 'great-great-grandchild'
    ; cousin(Person1, Person2) -> Relation = 'cousin'
    ; sibling(Person1, Person2) -> Relation = 'sibling'
    ; brother(Person1, Person2) -> Relation = 'brother'
    ; sister(Person1, Person2) -> Relation = 'sister'
    ; niece(Person1, Person2) -> Relation = 'niece'
    ; nephew(Person1, Person2) -> Relation = 'nephew'
    ; maternal_uncle(Person1, Person2) -> Relation = 'maternal uncle'
    ; paternal_uncle(Person1, Person2) -> Relation = 'paternal uncle'
    ; maternal_aunt(Person1, Person2) -> Relation = 'maternal aunt'
    ; paternal_aunt(Person1, Person2) -> Relation = 'paternal aunt'
    ; son_in_law(Person1, Person2) -> Relation = 'son-in-law'
    ; daughter_in_law(Person1, Person2) -> Relation = 'daughter-in-law'
    ; father_in_law(Person1, Person2) -> Relation = 'father-in-law'
    ; mother_in_law(Person1, Person2) -> Relation = 'mother-in-law'
    ; Relation = 'no direct relation'  % Default case if no relation is found
    ).


    --------------------------------------------------------------------------------------------


    % Family Tree
% Defining males and females
male(baliramji). male(namdev). male(sukhdeo). male(eknath). male(ram).
male(prashant). male(suresh). male(shrikant). male(pramod). male(ankush).
male(roshan). male(ninad). male(anil). male(praveen). male(dadu).
male(aaryan). male(amey). male(shrivesh). male(tushar). male(rudra).

female(kamla). female(usha). female(sarika). female(jaymala). female(kavita).
female(surekanta). female(kalyani). female(nilima). female(harsha). female(nita).
female(asha). female(roshni). female(dipali). female(aarti). female(sayli).
female(poonam). female(swara).

% Defining parent-child relationships
parent(baliramji, usha). parent(baliramji, namdev). parent(baliramji, sukhdeo).
parent(baliramji, eknath). parent(baliramji, ram).

parent(kamla, usha). parent(kamla, namdev). parent(kamla, sukhdeo).
parent(kamla, eknath). parent(kamla, ram).

parent(usha, ankush). parent(usha, roshan). parent(prashant, ankush).
parent(prashant, roshan).

parent(roshan, rudra). parent(kalyani, rudra).

parent(namdev, suresh). parent(sarika, suresh).

parent(suresh, sayli). parent(suresh, aaryan). parent(nilima, sayli).
parent(nilima, aaryan).

parent(sukhdeo, shrikant). parent(sukhdeo, pramod). parent(jaymala, shrikant).
parent(jaymala, pramod).

parent(shrikant, amey). parent(shrikant, shrivesh). parent(harsha, amey).
parent(harsha, shrivesh).

parent(pramod, sakshi). parent(pramod, aashay). parent(nita, sakshi).
parent(nita, aashay).

parent(eknath, asha). parent(eknath, rahul). parent(kavita, asha).
parent(kavita, rahul).

parent(asha, poonam). parent(asha, tushar). parent(sanket, poonam).
parent(sanket, tushar).

parent(rahul, ninad). parent(roshni, ninad).

parent(ram, anil). parent(ram, praveen). parent(surekanta, anil).
parent(surekanta, praveen).

parent(anil, dadu). parent(dipali, dadu).

parent(praveen, swara). parent(praveen, anav). parent(aarti, swara).
parent(aarti, anav).

% Basic family relationships
father(X, Y) :- male(X), parent(X, Y).
mother(X, Y) :- female(X), parent(X, Y).
child(X, Y) :- parent(Y, X).
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
brother(X, Y) :- male(X), sibling(X, Y).
sister(X, Y) :- female(X), sibling(X, Y).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandfather(X, Y) :- male(X), grandparent(X, Y).
grandmother(X, Y) :- female(X), grandparent(X, Y).
wife(X, Y) :- female(X), male(Y), parent(X, Z), parent(Y, Z).
husband(X, Y) :- male(X), female(Y), parent(X, Z), parent(Y, Z).
niece(X, Y) :- female(X), sibling(Y, Z), parent(Z, X).
nephew(X, Y) :- male(X), sibling(Y, Z), parent(Z, X).
cousin(X, Y) :- parent(A, X), parent(B, Y), sibling(A, B).

% Querying parents, grandparents, and cousins

% Find the relationship between two persons
find_relation(X, Y) :-
    (   father(X, Y) -> format('~w is the father of ~w.~n', [X, Y])
    ;   mother(X, Y) -> format('~w is the mother of ~w.~n', [X, Y])
    ;   brother(X, Y) -> format('~w is the brother of ~w.~n', [X, Y])
    ;   sister(X, Y) -> format('~w is the sister of ~w.~n', [X, Y])
    ;   husband(X, Y) -> format('~w is the husband of ~w.~n', [X, Y])
    ;   wife(X, Y) -> format('~w is the wife of ~w.~n', [X, Y])
    ;   child(X, Y) -> format('~w is the child of ~w.~n', [X, Y])
    ;   grandparent(X, Y) -> format('~w is the grandparent of ~w.~n', [X, Y])
    ;   grandfather(X, Y) -> format('~w is the grandfather of ~w.~n', [X, Y])
    ;   grandmother(X, Y) -> format('~w is the grandmother of ~w.~n', [X, Y])
    ;   cousin(X, Y) -> format('~w is the cousin of ~w.~n', [X, Y])
    ;   sibling(X, Y) -> format('~w is the sibling of ~w.~n', [X, Y])
    ;   format('No direct relationship found between ~w and ~w.~n', [X, Y])
    ).

% Query for Parents
find_parents(Person) :- 
    setof(Parent, parent(Parent, Person), Parents),
    format('~w\'s parents are: ~w.~n', [Person, Parents]).

% Query for Grandparents
find_grandparents(Person) :- 
    setof(GP, grandparent(GP, Person), Grandparents),
    format('~w\'s grandparents are: ~w.~n', [Person, Grandparents]).

% Query for Cousins
find_cousins(Person) :- 
    setof(C, cousin(Person, C), Cousins),
    format('~w\'s cousins are: ~w.~n', [Person, Cousins]).

% Query for Siblings
find_siblings(Person) :- 
    setof(Sibling, sibling(Sibling, Person), Siblings),
    format('~w\'s siblings are: ~w.~n', [Person, Siblings]).

% Query for Brothers
find_brothers(Person) :-
    (   setof(Brother, brother(Brother, Person), Brothers)
    ->  format('~w\'s brothers are: ~w.~n', [Person, Brothers])
    ;   format('~w has no brothers.~n', [Person])
    ).


% Query for Sisters
find_sisters(Person) :-
    (   setof(Sister, sister(Sister, Person), Sisters)
    ->  format('~w\'s sisters are: ~w.~n', [Person, Sisters])
    ;   format('~w has no sisters.~n', [Person])
    ).


% Query for Aunts
find_aunts(Person) :- 
    setof(Aunt, (sister(Aunt, Parent), parent(Parent, Person)), Aunts),
    format('~w\'s aunts are: ~w.~n', [Person, Aunts]).

% Query for Uncles
find_uncles(Person) :- 
    setof(Uncle, (brother(Uncle, Parent), parent(Parent, Person)), Uncles),
    format('~w\'s uncles are: ~w.~n', [Person, Uncles]).

% Query for Nieces
find_nieces(Person) :- 
    setof(Niece, (niece(Niece, Person)), Nieces),
    format('~w\'s nieces are: ~w.~n', [Person, Nieces]).

% Query for Nephews
find_nephews(Person) :- 
    setof(Nephew, (nephew(Nephew, Person)), Nephews),
    format('~w\'s nephews are: ~w.~n', [Person, Nephews]).

% Query for Grandfathers
find_grandfathers(Person) :- 
    setof(GF, grandfather(GF, Person), Grandfathers),
    format('~w\'s grandfathers are: ~w.~n', [Person, Grandfathers]).

% Query for Grandmothers
find_grandmothers(Person) :- 
    setof(GM, grandmother(GM, Person), Grandmothers),
    format('~w\'s grandmothers are: ~w.~n', [Person, Grandmothers]).

% Query for Husbands
find_husband(Person) :- 
    setof(Husband, husband(Husband, Person), Husbands),
    format('~w\'s husband is: ~w.~n', [Person, Husbands]).

% Query for Wives
find_wife(Person) :- 
    setof(Wife, wife(Wife, Person), Wives),
    format('~w\'s wife is: ~w.~n', [Person, Wives]).

% Main entry point for OneCompiler compatibility
:- initialization(main).

main :-
    % Example queries for testing
    find_relation(ankush, usha),

    find_parents(ankush),
    find_grandparents(ankush),
    find_siblings(ankush),
    find_brothers(ankush),
    find_sisters(ankush),
    find_cousins(ankush),
    find_aunts(ankush),
    find_uncles(ankush),
    find_nieces(ankush),
    find_nephews(ankush),
    find_grandfathers(ankush),
    find_grandmothers(ankush).
