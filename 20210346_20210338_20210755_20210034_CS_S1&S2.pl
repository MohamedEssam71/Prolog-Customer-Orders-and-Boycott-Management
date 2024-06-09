:-consult(data).

:- dynamic(item/3).
:- dynamic(alternative/2).
:- dynamic(boycott_company/2).

member(X,[X|_]).
member(X,[_|T]):-
    member(X,T).


list_orders(CustName,L):-
    customer(CustID, CustName),
    list_orders_helper(CustID,[],L).

list_orders_helper(CustID, Acc, L):-
    order(CustID,OrderID,Items),
    \+ member(order(_,OrderID,_),Acc),
    list_orders_helper(CustID,[order(CustID,OrderID,Items)|Acc],L),!.

list_orders_helper(_,Acc,Acc).
/*----------------------------------------*/

countOrdersOfCustomer(CustName, Count):-
    customer(CustID, CustName),
    count_helper(CustID,[],0,Count).

count_helper(CustID, AccList, Acc, Count):-
    order(CustID,OrderID,_),
    \+ member(order(_,OrderID,_),AccList),
    Acc2 is Acc + 1,
    count_helper(CustID,[order(_,OrderID,_)|AccList],Acc2, Count),!.

count_helper(_,_,Acc,Acc).
/*---------------------------------*/


getItemsOrderById(CustName,OrderID,Items):-
    customer(CustID,CustName),
    order(CustID,OrderID,Items),!.
/*----------------------------*/

getNumOfItems(CustName,OrderID,Count):-
    customer(CustID,CustName),
    order(CustID,OrderID,Items),
    getNum_helper(Items,0,Count).

getNum_helper([_|T],Acc,Count):-
    Acc2 is Acc + 1,
    getNum_helper(T,Acc2,Count).

getNum_helper([],Acc,Acc).


/*------------------------------*/
calcPriceOfOrder(CustName,OrderID,TotalPrice):-
    customer(CustID, CustName),
    order(CustID,OrderID,Items),
    price_helper(Items,0,TotalPrice).

price_helper([H|T],Acc,TotalPrice):-
    item(H,_,Price),
    Acc2 is Acc + Price,
    price_helper(T,Acc2,TotalPrice).

price_helper([],Acc,Acc).

/*------------------------------*/
isBoycott(Item_or_Company):-
    (boycott_company(Item_or_Company,_),!) |
    (item(Item_or_Company,CompanyName,_),
    boycott_company(CompanyName,_)).
/*------------------------------*/


whyToBoycott(Item_or_Company,Justification):-
   ( boycott_company(Item_or_Company,Justification),!)
   |(item(Item_or_Company,CompanyName,_),
    boycott_company(CompanyName,Justification)).


/*------------------------------*/
removeBoycottItemsFromAnOrder(CustName,OrderID,NewList):-
    customer(CustID,CustName),
    order(CustID,OrderID,Items),
    remove_boycott_helper(Items,[],NewList),!.
remove_boycott_helper([H|T],Acc,NewList):-
    (   \+isBoycott(H),
    remove_boycott_helper(T,[H|Acc],NewList))|
    (     isBoycott(H),
    remove_boycott_helper(T, Acc, NewList)).


remove_boycott_helper([],Acc,Acc).

/*------------------------------*/
replaceBoycottItemsFromAnOrder(CustName,OrderID,NewList):-
    customer(CustID,CustName),
    order(CustID,OrderID,Items),
    replace_boycott_helper(Items,[],NewList),!.
replace_boycott_helper([H|T], Acc, NewList):-
    (   (\+isBoycott(H) | \+alternative(H,_)),
    replace_boycott_helper(T, [H|Acc] , NewList))|
    (   isBoycott(H),
        (alternative(H,AltItem),
         replace_boycott_helper(T, [AltItem|Acc], NewList))
    ).

replace_boycott_helper([],Acc,Acc).
/*------------------------------*/
calcPriceAfterReplacingBoycottItemsFromAnOrder(CustName,OrderID,NewList,TotalPrice):-
    customer(CustID,CustName),
    order(CustID,OrderID,Items),
    replace_boycott_helper(Items,[],NewList),
    price_helper(NewList, 0, TotalPrice),!.

/*------------------------------*/
getTheDifferenceInPriceBetweenItemAndAlternative(Item,Alternative,DiffPrice):-
    item(Item,_,Price1),
    alternative(Item,Alternative),
    item(Alternative,_,Price2),
    DiffPrice is Price1-Price2.
/*------------------------------*/
add_item(ItemName,CompanyName,Price):-
    \+item(ItemName,CompanyName,Price),
    assert(item(ItemName,CompanyName,Price)).

remove_item(ItemName, CompanyName, Price):-
    item(ItemName,CompanyName,Price),
    retract(item(ItemName,CompanyName,Price)).

add_alternative_item(ItemName, AlternativeItem):-
    \+alternative(ItemName,AlternativeItem),
    assert(alternative(ItemName,AlternativeItem)).
remove_alternative_item(ItemName, AlternativeItem):-
    alternative(ItemName,AlternativeItem),
    retract(alternative(ItemName,AlternativeItem)).

add_boycott(CompanyName, Justification):-
    \+boycott_company(CompanyName, Justification),
    assert(boycott_company(CompanyName, Justification)).

remove_boycott(CompanyName, Justification):-
    boycott_company(CompanyName, Justification),
    retract(boycott_company(CompanyName, Justification)).
