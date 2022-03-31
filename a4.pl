:- dynamic xpositive/2.
:- dynamic xnegative/2.

car_is(daytona):-
    it_is(ferrari),
    it_is(sports_car),
    positive(is,old),
    positive(has,front_engine).


car_is(sf90_spider):-
    it_is(ferrari),
    it_is(sports_car),
    positive(has,mid_engine),
    positive(is,convertible).

car_is(m3):-
    it_is(bmw),
    it_is(sports_car),
    positive(has,front_engine).


car_is(x5):-
    it_is(bmw),
    it_is(off_road_car),
    positive(has,front_engine).

car_is(yaris):-
    it_is(toyota),
    it_is(city_car),
    positive(has,5_doors),
    positive(has,front_engine).

it_is(ferrari):-
    positive(is,from_italy),
    negative(has,high_price),!.

it_is(toyota):-
    positive(is,from_japan), 
    positive(has,high_price),!.
    
it_is(bmw):-
    positive(is,from_germany), 
    positive(has,high_price),!.

it_is(sports_car):-
    positive(is,fast),
    negative(is,big),!.

it_is(off_road_car):-
    positive(is,big),
    negative(is,fast),!.

it_is(city_car):-
    positive(is,economical),
    negative(is,big),!.

positive(X,Y) :- 
    xpositive(X,Y), !. 
positive(X,Y) :-
    not(xnegative(X,Y)) ,
    ask(X,Y).

negative(X,Y) :- 
    xnegative(X,Y), !.
negative(X,Y) :-
    not(xpositive(X,Y)) ,
    ask(X,Y).

ask(X,Y) :-
    write(X), write(' it '),write(Y), write('\n'),
    read(Reply),
    (sub_string(Reply,0,1,_,'y') 
    -> remember_y(X,Y), write('yes'), nl  
    ; (sub_string(Reply,0,1,_,'n') 
        -> remember_n(X,Y), write('no'), nl, fail  
        ; ask(X,Y)) ),
     !.


remember_y(X,Y) :- assert(xpositive(X,Y)).

remember_n(X,Y) :- assert(xnegative(X,Y)).


run :-
    car_is(X),!,
    write('\nYour car may be a(n) '),write(X),
    nl,nl,clear_facts.

run :-
    write('\nUnable to determine what'),
    write('your car is.\n\n'),clear_facts.

clear_facts :-
    retract(xpositive(_,_)),fail.
clear_facts :-
    retract(xnegative(_,_)),fail.
clear_facts :-
    write('\n\nPlease press the space bar to exit\n').