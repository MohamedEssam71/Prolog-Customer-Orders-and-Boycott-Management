# Prolog-Customer-Orders-and-Boycott-Management
This project involves writing a Prolog program to answer questions about customers and their orders, as well as helping customers identify boycott items and suggest alternatives.

## Problem Statement

Using the provided `data.pl` file, write a Prolog program to:

1. **List Customer Orders:** List all orders of a specific customer.
2. **Count Customer Orders:** Get the number of orders for a specific customer.
3. **List Items in Order:** List all items in a specific customer's order.
4. **Count Items in Order:** Get the number of items in a specific customer's order.
5. **Calculate Order Price:** Calculate the total price of a specific order.
6. **Check Boycott Status:** Determine whether an item or company is boycotted.
7. **Boycott Justification:** Find the justification for boycotting a company or item.
8. **Remove Boycott Items:** Remove all boycott items from a specific order.
9. **Price Difference:** Calculate the price difference between a boycott item and its alternative.
10. **Bonus:** Insert/Remove items, alternatives, and boycott companies from the knowledge base.

### Data Facts (data.pl)

The data file includes facts about customers, items, orders, boycott companies, and their alternatives. Examples include:

- **Customer:**
  ```prolog
  customer(104, mazen122).

- **Item:**
  ```prolog
  item(pepsi, 'PepsiCo', 8.5)..
  
- **Order:**
  ```prolog
  order(1, 1, [ariel_4k, biskrem, cheese]).
  
- **Boycott Company:**
  ```prolog
  boycott_company('PepsiCo', 'PepsiCo purchased the ...').
  
- **Alternative**
  ```prolog
  alternative(chipsy, tiger).

## Required Predicates

### 1. List all orders of a specific customer
```prolog
list_orders(CustomerUsername, Orders).
```
### 2. Get the number of orders of a specific customer
```prolog
countOrdersOfCustomer(CustomerUsername, Count).
```

### 3. List all items in a specific customer order
```prolog
getItemsInOrderById(CustomerUsername, OrderID, Items).
```

### 4. Get the number of items in a specific customer order
```prolog
getNumOfItems(CustomerUsername, OrderID, Count).
```

### 5. Calculate the price of a given order
```prolog
calcPriceOfOrder(CustomerUsername, OrderID, TotalPrice).
```

### 6. Determine whether an item or company should be boycotted
```prolog
isBoycott(ItemOrCompany).
```

### 7. Find the justification for boycotting an item or company
```prolog
whyToBoycott(ItemOrCompany, Justification).
```

### 8. Remove all boycott items from a specific order
```prolog
removeBoycottItemsFromAnOrder(CustomerUsername, OrderID, NewList).
```

### 9. Calculate the difference in price between a boycott item and its alternative
```prolog
getTheDifferenceInPriceBetweenItemAndAlternative(ItemName, Alternative, DiffPrice).
```

## Bonus
### 10. Insert/Remove items, alternatives, and boycott companies from the knowledge base
```prolog
add_item(ItemName, CompanyName, Price).
remove_item(ItemName, CompanyName, Price).
```

# Contributors

* [Ahmed Abd El-Wahab](https://github.com/AliveTube)
* [Mohamed Khaled (Amin)](https://github.com/emailam)
* [Alan Samir](https://github.com/alanhakoun)
* [Mohamed Essam](https://github.com/MohamedEssam71)
