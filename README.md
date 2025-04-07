# Advanced Reasoning Technique

This repository contains my progress in learning Prolog using the book **Simply Logical: Intelligent Reasoning by Peter Flach**. The learning process is divided into three main sections, each with separate folders for better organization.

## 📚 Sections of the Book

The book is divided into three main sections:

1. **Logical and Logical Programming**
2. **Reasoning with Structured Knowledge**
3. **Advanced Reasoning Technique**

For detailed information about the chapters in each section, you can refer to the official online version of the book: [Simply Logical](https://book.simply-logical.space/src/simply-logical.html)

Each section in this repository is organized into separate folders with `.pl` files representing Prolog programs and exercises from the chapters.

---

## 📁 Repository Structure

```
Advanced_Reasoning_Technique/
│
├── Logical_and_Logical_Programming/   # Section 1 - Chapters 1, 2, 3 ...
├── Reasoning_with_Structured_Knowledge/   # Section 2 - Chapters 4, 5, 6 ...
├── Advanced_Reasoning_Technique/   # Section 3 - Chapters 7, 8, 9 ...
└── README.md
```

---

## 🚀 Installation (Linux - Ubuntu Based Systems)

To install SWI-Prolog on Ubuntu or Ubuntu-based systems (like Linux Mint):

```bash
sudo apt update
sudo apt install swi-prolog
```

### Checking Installation

Verify the installation by running:

```bash
swipl --version
```

You should see something like:

```
SWI-Prolog version 8.4.0 for x86_64-linux
```

### Running a Prolog File

1. Open the terminal and navigate to the directory containing your `.pl` file.
2. Start the Prolog interpreter:

```bash
swipl
```

3. Load your file:

```prolog
?- [filename].  % Replace 'filename' with your actual file name without the .pl extension
```

4. Run your queries.

5. To exit Prolog, use:

```prolog
?- halt.
```

---

## 🔥 Section 1: Logical and Logical Programming

This section covers the fundamentals of clausal logic, how to write and query Prolog programs, and how to use recursion and structured terms.

### 1. Clausal Logic

Clausal logic is the foundation of logical programming and Prolog. It involves expressing facts, rules, and queries as logical clauses. This section is divided into three main topics:

in this chapter we are going to use a small part of the [London underground plan](https://book.simply-logical.space/_images/image002.svg).

#### A. Facts and Rules in Prolog

**Facts** : they represent simple, atomic statements that are true, in the context of the London underground example facts describe connections between stations and the line they belong to 

```prolog
% Facts
connected(bond_street, oxford_circus, central).
connected(oxford_circus, tottenham_court_road, central).
connected(bond_street, green_park, jubilee).
connected(green_park, charing_cross, jubilee).
connected(green_park, piccadilly_circus, piccadilly).
connected(piccadilly_circus, leicester_square, piccadilly).
connected(green_park, oxford_circus, victoria).
connected(oxford_circus, piccadilly_circus, bakerloo).
connected(piccadilly_circus, charing_cross, bakerloo).
connected(tottenham_court_road, leicester_square, northern).
connected(leicester_square, charing_cross, northern).
```

**Rules** : are conditional statements that describe the relationships between facts or other rules, they allow for reasoning and inferring new knowledge based on existing facts.

```prolog
% Rules
connected(Y,X,L):- connected(X,Y,L).
nearby(X,Y):- connected(X,Y,_L).
nearby(X,Y):- connected(X,Z,L),connected(Z,Y,L).
```



#### B. Answering Queries

- Queries are the way we ask questions to the Prolog interpreter.
- They are constructed by providing a goal that Prolog attempts to satisfy using known facts and rules.

**Example:**

```prolog
% Query:
?- nearby(tottenham_court_road,W).

% Output:
W = leicester_square.
```

#### C. Recursion

- Prolog supports recursion, which is essential for defining complex relationships.
- Recursive rules allow Prolog to explore indefinite or structured relationships.
- recursion is the only looping structure in prolog.

**Example:**

we will define a reachabillity relation in the underground lines example, where a station is reachable from another station if they are connected by one or more lines we can do that manually by defining 20 ground facts : 

```prolog
% Facts :
reachable(bond_street,charing_cross).
reachable(bond_street,green_park).
reachable(bond_street,leicester_square).
reachable(bond_street,oxford_circus).
reachable(bond_street,piccadilly_circus).
reachable(bond_street,tottenham_court_road).
reachable(green_park,charing_cross).
reachable(green_park,leicester_square).
reachable(green_park,oxford_circus).
reachable(green_park,piccadilly_circus).
reachable(green_park,tottenham_court_road).
reachable(leicester_square,charing_cross).
reachable(oxford_circus,charing_cross).
reachable(oxford_circus,leicester_square).
reachable(oxford_circus,piccadilly_circus).
reachable(oxford_circus,tottenham_court_road).
reachable(piccadilly_circus,charing_cross).
reachable(piccadilly_circus,leicester_square).
reachable(tottenham_court_road,charing_cross).
reachable(tottenham_court_road,leicester_square).
```

but this is process is time consuming and if we have a more complex plans it will get harder so we are obliged to create rules to determine if two stations are reachable or not.

here a non-recursive definition

```prolog
% Non-recursive rule
reachable(X,Y):-connected(X,Y,L).
reachable(X,Y):-connected(X,Z,L1),connected(Z,Y,L2).
reachable(X,Y):-connected(X,Z1,L1),connected(Z1,Z2,L2),connected(Z2,Y,L3).
```

but the problem is if we are going to define the reachability for the entire London Underground we would need a lot more longer rules so here is much convenient to use recursive definition

```prolog
% Recursive Rule
reachable(X,Y):-connected(X,Y,_L).
reachable(X,Y):-connected(X,Z,L1),connected(Z,Y,L2).

% Query:
?- reachable(bond_street,Y)

% Output:
Y = oxford_circus;
Y = green_park;
Y = tottenham_court_road.
```

#### D. Structured Terms

- Prolog allows using **compound terms** to represent complex data structures.
- A structured term consists of a **functor** and its **arguments**.

**Example:**

Suppose we want to redefine the reachability relation , such that it also specifies the intermediatiate stations. we could adapt the non-recursive definition of reachable as follows:

```prolog
reachable0(X,Y):-connected(X,Y,L).
reachable1(X,Y,Z):-connected(X,Z,L1),connected(Z,Y,L2).
reachable2(X,Y,Z1,Z2):-connected(X,Z1,L1),connected(Z1,Z2,L2),connected(Z2,Y,L3).
```

the suffix of reachable indicates the number of intermediate stations even if the rules has the same number but they are actually different rules and that's create a problem. also a huge problem accures here is that we have to know exaclty the intermediate stations in advance before adding the query and that's not possible

so to solve this problem we are going to use *functors*. a *functor* is like a function name or label that groups values together, allowing prolog tp handle complex data structures.

For instance, a route with Oxford Circus and Tottenham Court Road as intermediate stations could be represeneted by 

```prolog
route(oxford_circus,tottenham_court_road)
```
that is not a ground fact, but rather an argument for a logical formula.the reachability relation can now be defined as follows:

``` prolog
% non-recursive Rule
reachable(X,Y,noroute):-connected(X,Y,_L).
reachable(X,Y,route(Z)):-connected(X,Z,_L1),connected(Z,Y,_L2).
reachable(X,Y,route(Z1,Z2)):-connected(X,Z1,_L1),connected(Z1,Z2,_L2),
                             connected(Z2,Y,_L3).

reachable(X,Y,route(Z,R)):-connected(X,Z,_L),connected(Z,Y,_R).
```
the query `?-reachable(oxford_circus,charing_cross,R)` now has three possible answers:
```prolog
% Query:
?- reachable(oxford_circus,charing_cross,R).

% Output:
{R->route(piccadilly_circys)}
{R->route(tottenham_court_road,leicester_square)}
{R->route(piccadilly_circus,leicester_square)}
```
Now we are going to use recursion.

``` prolog
% recursive Rule
reachable(X,Y,noroute):-connected(X,Y,_L).
reachable(X,Y,route(Z,R)):-connected(X,Z,_L),reachable(Z,Y,_R).
```
the query `?-reachable(oxford_circus,charing_cross,R)` now has three possible answers:
```prolog
% Query:
?- reachable(oxford_circus,charing_cross,R).

% Output:
{R->route(piccadilly_circys,noroute)}
{R->route(tottenham_court_road,route(leicester_square,noroute))}
{R->route(piccadilly_circus,route(leicester_square,noroute))}
```


### 2. Clausal Logic and Resolution (Not yet covered)

### 3. Logic Programming and Prolog (Not yet covered)

## 🔥 Section 2: Reasoning with structured Knowledge (Not yet coverd)

## 🔥 Section 3: Advanced Reasoning Techniques (Not yet coverd)

## 📌 Understanding Arguments in Rules: `L` vs `_L`

In Prolog, the **arguments of rules** can be written in different ways depending on how we want Prolog to **process or ignore them**. Understanding the difference between `L` and `_L` is crucial.

### `L` (Named Variable)

- `L` is a **named variable**. When you use `L` in a rule, Prolog will **attempt to match and return its value**.
- It is useful when you **want to know or compare the specific value** of the argument.

**Example:**

```prolog
connected(bond_street, oxford_circus, L).
```

- When you query:

```prolog
?- connected(bond_street, oxford_circus, L).
```

- Prolog will respond:

```
L = central.
```

- Here, Prolog returns the name of the line connecting the two stations.

### `_L` (Anonymous Variable)

- `_L` is an **anonymous variable** (or a wildcard). Prolog **ignores its value** and only checks whether a connection exists, regardless of the specific line name.
- It is useful when you **do not care about the value** of the argument.

**Example:**

```prolog
connected(bond_street, oxford_circus, _L).
```

- When you query:

```prolog
?- connected(bond_street, oxford_circus, _L).
```

- Prolog will simply respond:

```
true.
```

- It confirms that a connection exists without specifying which line.

### 🔑 Key Differences

| Argument Type | Description                        | When to Use                          | Example Output |
| ------------- | ---------------------------------- | ------------------------------------ | -------------- |
| `L`           | Named variable. Returns the value. | When you want to know the line name. | `L = central.` |
| `_L`          | Anonymous variable. Ignores value. | When the value is irrelevant.        | `true.`        |

Use `_L` when you only care about the existence of a connection, but use `L` when you want to **identify or compare the specific line name**.

---

