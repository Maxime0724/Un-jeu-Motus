
%%%%%%% Begin Game %%%%%%%
begin:-
    bienvenu(ListeChoix),
	waitUserInput(ListeChoix).


%%%%%%% Acueill %%%%%%%
bienvenu(ListeChoix):-
	write('Bienvenu a Motus'), nl, nl,
	ListeChoix = [0, 1, 2, 3],
    write('Vous entrez: '), nl,
	write('    (0) : Quitter le jeu'), nl,
	write('    (1) : Demarrer un jeu Joueur VS Ordinateur'), nl,
	write('    (2) : Demarrer un jeu Ordinateur stupide VS Joueur'), nl,
    write('    (3) : Demarrer un jeu Ordinateur intelligent VS Joueur'), nl.

waitUserInput(ListeChoix) :-
	read(R),
	element(R, ListeChoix).

element(R, ListChoix):-
    member(R, ListChoix),
    R is 0,
    write('Le jeu est termine.').

element(R, ListChoix):-
    member(R, ListChoix),
    R is 1,
    jvso.

element(R, ListChoix):-
    member(R, ListChoix),
    R is 2,
    ovsj.

element(R, ListChoix):-
    member(R, ListChoix),
    R is 3,
    ovsj2.

element(R, ListChoix):-
    \+member(R, ListChoix),
    write('Veuillez entrer un bon numero.'), nl,
    begin, nl.

%%%%%%% mode j vs o %%%%%%%
jvso:-
    write('Nous commencons le jeu Joueur VS Ordinateur.'), nl,
    random(5, 10, Length),
    random(65, 90, NumLetter),
    char_code(Letter, NumLetter),
    number_atom(Length, Length_char),
    atom_concat(Letter, Length_char, Pr),
    atom_concat(Pr, '.txt', Filename),
    lire(Dictionnaire, Filename),
    length(Dictionnaire, Length_list),
    random(1, Length_list, Num_mots),
    nth(Num_mots, Dictionnaire, Mots), nl,
    atom_chars(Mots, List_mots),
    nth(1, List_mots, First_mots),
    write(First_mots),
    printn(Length - 1, '.'), nl,
    write('*************************'), nl,
    write('Votre proposition : '),
    read(Propo),
    atom_chars(Propo, List_propo),
    judge(List_propo, List_mots, Length, ''),
    !.

%%%%%%% fonctions de mode j vs o  %%%%%%%

judge(List_propo, List_mots, 1, String):-
    nth(1, List_propo, A),
    nth(1, List_mots, B),
    A == B,
    atom_concat(String, '!', S2),
    atom_chars(S2, List_S2),
    reverse(List_S2, List),
    list_string(List, String2),
    write(String2), nl, nl,
    length(List_mots, Length2),
    print_new(List, List_mots, Length2, ''),
    rejudge(List_propo, List_mots, Length2, ''),
    !.

judge(List_propo, List_mots, 1, String):-
    nth(1, List_propo, A),
    nth(1, List_mots, B),
    A \== B,
    member(A, List_mots),
    atom_concat(String, '?', S2),
    atom_chars(S2, List_S2),
    reverse(List_S2, List),
    list_string(List, String2),
    write(String2), nl, nl,
    length(List_mots, Length2),
    print_new(List, List_mots, Length2, ''),
    rejudge(List_propo, List_mots, Length2, ''),
    !.

judge(List_propo, List_mots, 1, String):-
    nth(1, List_propo, A),
    nth(1, List_mots, B),
    A \== B,
    \+member(A, List_mots),
    atom_concat(String, '.', S2),
    atom_chars(S2, List_S2),
    reverse(List_S2, List),
    list_string(List, String2),
    write(String2), nl, nl,
    length(List_mots, Length2),
    print_new(List, List_mots, Length2, ''),
    rejudge(List_propo, List_mots, Length2, ''),
    !.


judge(List_propo, List_mots, Length, String):-
    L2 is Length - 1,
    nth(Length, List_propo, A),
    nth(Length, List_mots, B),
    A == B,
    atom_concat(String, '!', S2),
    judge(List_propo, List_mots, L2, S2).

judge(List_propo, List_mots, Length, String):-
    L2 is Length - 1,
    nth(Length, List_propo, A),
    nth(Length, List_mots, B),
    A \== B,
    member(A, List_mots),
    atom_concat(String, '?', S2),
    judge(List_propo, List_mots, L2, S2).

judge(List_propo, List_mots, Length, String):-
    L2 is Length - 1,
    nth(Length, List_propo, A),
    nth(Length, List_mots, B),
    A \== B,
    \+member(A, List_mots),
    atom_concat(String, '.', S2),
    judge(List_propo, List_mots, L2, S2).


print_new(List, List_mots, 1, S):-
    nth(1, List, A),
    A == '!',
    nth(1, List_mots, B),
    atom_concat(S, B, S2),
    atom_chars(S2, List_S2),
    reverse(List_S2, List2),
    list_string(List2, String2),
    write(String2), nl, nl,
    !.

print_new(List, List_mots, 1, S):-
    nth(1, List, A),
    A \== '!',
    atom_concat(S, '.', S2),
    atom_chars(S2, List_S2),
    reverse(List_S2, List2),
    list_string(List2, String2),
    write(String2), nl, nl,
    !.


print_new(List, List_mots, Length, S):-
    L2 is Length - 1,
    nth(Length, List, A),
    A == '!',
    nth(Length, List_mots, B),
    atom_concat(S, B, S2),
    print_new(List, List_mots, L2, S2),
    !.

print_new(List, List_mots, Length, S):-
    L2 is Length - 1,
    nth(Length, List, A),
    A \== '!',
    atom_concat(S, '.', S2),
    print_new(List, List_mots, L2, S2),
    !.


rejudge(List_propo, List_mots, Length, ''):-
    List_propo == List_mots,
    write(' *********************'), nl,
    write(' *                   *'), nl,
    write(' * Vous avez gagne ! *'), nl,
    write(' *                   *'), nl,
    write(' *********************').

rejudge(List_propo, List_mots, Length, ''):-
    List_propo \== List_mots,
    write('*************************'), nl,
    write('Votre proposition : '),
    read(R),
    atom_chars(R, List_propo2),
    judge(List_propo2, List_mots, Length, '').



list_codes([], "").

list_codes([Atom], Codes) :- atom_codes(Atom, Codes).

list_codes([Atom|ListTail], Codes) :-
        atom_codes(Atom, AtomCodes),
        append(AtomCodes, ListTailCodes, Codes),
        list_codes(ListTail, ListTailCodes).

list_string(List, String) :-
        ground(List),
        list_codes(List, Codes),
        atom_codes(String, Codes).

list_string(List, String) :-
        ground(String),
        atom_codes(String, Codes),
        list_codes(List, Codes).




%%%%%%% mode o vs j %%%%%%%
ovsj:-
    write('Nous commencons le jeu Joueur VS Ordinateur.'), nl,
    write('Mot a deviner: '),nl,
    read(Mot),
    check_mot(Mot,Dico),
    nth(1, Dico, F_mot),
    atom_chars(Mot, List_mot),
    length(List_mot, L),
    compare(Mot, F_mot, Dico, L, 1).

printn(0, A):- write('').
printn(N, A):-
    write(A),
    N2 is N - 1,
    printn(N2, A).

check_mot(Mot, Dico):-
    atom_length(Mot,L),
    L @>= 5,
    L @=< 10,
    atom_chars(Mot, List_mot),
    nth(1,List_mot,First_letter),
    lower_upper(First_letter, First_letter_up),
    number_atom(L, L_char),
    atom_concat(First_letter_up, L_char, Pr),
    atom_concat(Pr, '.txt', Filename),
    lire(Dico, Filename),
    member(Mot, Dico),
    write('Ce mot est dans le dictionnaire'),nl,
    nth(1,Dico,First_mot_dico),
    write(First_mot_dico),nl,
    !.

check_mot(Mot,Dico):-
    atom_length(Mot,L),
    L @>= 5,
    L @=< 10,
    atom_chars(Mot, List_mot),
    nth(1,List_mot,First_letter),
    lower_upper(First_letter, First_letter_up),
    number_atom(L, L_char),
    atom_concat(First_letter_up, L_char, Pr),
    atom_concat(Pr, '.txt', Filename),
    lire(Dico, Filename),
    \+member(Mot,Dico),
    write('Ce mot n\'est pas dans le dictionnaire'),nl,
    write('Mot a deviner: '),nl,
    read(Mot2),
    check_mot(Mot2),
    !.

compare(Mot, Mot_in_dico, Dico, L, Num_dico):-
    Mot \= Mot_in_dico,
    atom_chars(Mot, List_mot),
    atom_chars(Mot_in_dico, List_mot_dico),
    judge2(List_mot_dico, List_mot, L, ''),
    Num_dico2 is Num_dico + 1,
    nth(Num_dico2, Dico, Mot_in_dico2),
    write(Mot_in_dico2), nl,
    compare(Mot, Mot_in_dico2,Dico, L, Num_dico2).

compare(Mot,Mot_in_dico, Dico, L, Num_dico):-
    Mot == Mot_in_dico,
    printn(L, '!'), nl,
    write('GAGNEZ!').

judge2(List_propo, List_mots, 1, String):-
    nth(1, List_propo, A),
    nth(1, List_mots, B),
    A == B,
    atom_concat(String, '!', S2),
    atom_chars(S2, List_S2),
    reverse(List_S2, List),
    list_string(List, String2),
    write(String2), nl, nl.

judge2(List_propo, List_mots, 1, String):-
    nth(1, List_propo, A),
    nth(1, List_mots, B),
    A \== B,
    member(A, List_mots),
    atom_concat(String, '?', S2),
    atom_chars(S2, List_S2),
    reverse(List_S2, List),
    list_string(List, String2),
    write(String2), nl, nl.

judge2(List_propo, List_mots, 1, String):-
    nth(1, List_propo, A),
    nth(1, List_mots, B),
    A \== B,
    \+member(A, List_mots),
    atom_concat(String, '.', S2),
    atom_chars(S2, List_S2),
    reverse(List_S2, List),
    list_string(List, String2),
    write(String2), nl, nl.

judge2(List_propo, List_mots, Length, String):-
    L2 is Length - 1,
    nth(Length, List_propo, A),
    nth(Length, List_mots, B),
    A == B,
    atom_concat(String, '!', S2),
    judge2(List_propo, List_mots, L2, S2).

judge2(List_propo, List_mots, Length, String):-
    L2 is Length - 1,
    nth(Length, List_propo, A),
    nth(Length, List_mots, B),
    A \== B,
    member(A, List_mots),
    atom_concat(String, '?', S2),
    judge2(List_propo, List_mots, L2, S2).

judge2(List_propo, List_mots, Length, String):-
    L2 is Length - 1,
    nth(Length, List_propo, A),
    nth(Length, List_mots, B),
    A \== B,
    \+member(A, List_mots),
    atom_concat(String, '.', S2),
    judge2(List_propo, List_mots, L2, S2).


ovsj2:-
    write('Nous commencons le jeu Joueur VS Ordinateur.'), nl,
    write('Mot a deviner: '), nl,
    read(Mot),
    check_mot(Mot,Dico),
    nth(1, Dico, F_mot),
    atom_chars(Mot, List_mot),
    length(List_mot, L),
    compare(Mot, F_mot, Dico, L, 1).


compare2(Mot, Mot_in_dico, Dico, L, Num_dico, S2):-
    Mot \= Mot_in_dico,
    atom_chars(Mot, List_mot),
    atom_chars(Mot_in_dico, List_mot_dico),
    judge2(List_mot_dico, List_mot, L, '', S2, SF),
    Num_dico2 is Num_dico + 1,
    nth(Num_dico2, Dico, Mot_in_dico2),
    write(Mot_in_dico2), nl,
    remove(SF, Dico, Mot, Newdico),
    compare2(Mot, Mot_in_dico2, Dico, L, Num_dico2).

compare2(Mot,Mot_in_dico, Dico, L, Num_dico):-
    Mot == Mot_in_dico,
    printn(L, '!'), nl,
    write('GAGNEZ!').

remove(SF, Dico, Mot, Newdico):-
    select('!', SF, SF2),
    nth(N, SF2, '!'),
    nth(N, Mot, Lettre),


judge3(List_propo, List_mots, 1, String, SF):-
        nth(1, List_propo, A),
        nth(1, List_mots, B),
        A == B,
        atom_concat(String, '!', S2),
        atom_chars(S2, List_S2),
        reverse(List_S2, SF),
        list_string(SF, String2),
        write(String2), nl, nl.

judge3(List_propo, List_mots, 1, String, SF):-
        nth(1, List_propo, A),
        nth(1, List_mots, B),
        A \== B,
        member(A, List_mots),
        atom_concat(String, '?', S2),
        atom_chars(S2, List_S2),
        reverse(List_S2, SF),
        list_string(SF, String2),
        write(String2), nl, nl.

judge3(List_propo, List_mots, 1, String, SF):-
        nth(1, List_propo, A),
        nth(1, List_mots, B),
        A \== B,
        \+member(A, List_mots),
        atom_concat(String, '.', S2),
        atom_chars(S2, List_S2),
        reverse(List_S2, SF),
        list_string(SF, String2),
        write(String2), nl, nl.

judge3(List_propo, List_mots, Length, String, SF):-
        L2 is Length - 1,
        nth(Length, List_propo, A),
        nth(Length, List_mots, B),
        A == B,
        atom_concat(String, '!', S2),
        judge2(List_propo, List_mots, L2, S2, SF).

judge3(List_propo, List_mots, Length, String, SF):-
        L2 is Length - 1,
        nth(Length, List_propo, A),
        nth(Length, List_mots, B),
        A \== B,
        member(A, List_mots),
        atom_concat(String, '?', S2),
        judge2(List_propo, List_mots, L2, S2, SF).

judge3(List_propo, List_mots, Length, String, SF):-
        L2 is Length - 1,
        nth(Length, List_propo, A),
        nth(Length, List_mots, B),
        A \== B,
        \+member(A, List_mots),
        atom_concat(String, '.', S2),
        judge2(List_propo, List_mots, L2, S2, SF).


lire(Dictionnaire, Filename):-
    atom_concat('dicos/dicos-txt/', Filename, Filepath),
    open(Filepath, read, Str),
    lire_mots(Str, Dictionnaire),
    close(Str).

lire_mots(Stream, []):-
    at_end_of_stream(Stream), !.

lire_mots(Stream, [Mot|L]):-
    \+ at_end_of_stream(Stream),
    read(Stream, Mot),
    lire_mots(Stream, L).
