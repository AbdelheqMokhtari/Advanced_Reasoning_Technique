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


### 2. Clausal Logic and Resolution

#### A. Propositional Clausal logic

A proposition is any statement which is either true or false, such as `2 + 2 = 4` or `the sky is made of bubbles` this are the propositional logic, the weakest form of logic propositions are abstractly donated by atoms.

**atoms**: are single words starting with lowercase character for example : .
```prolog
married;bachelor:-man,adult.
% somebody is married or a bachelor if he is a man and an adult.
head:-body.
% that the structure of a clause in prolog head:- body
% the head is always a disjunction (or) of atoms
% the body is always a conjunction (and) of atoms.
```
**Exercise 2.1**
Translate the following statements into clauses,using the atoms `person`, `sad` and `happy`:

1. person are happy or sad;
2. no person is both happy and sad;
3. sad persons are not happy;
4. non-happy persons are sad.

**[Solution](Logic_And_Logic_Programming/exercise2-1.pl)**

**Exercise 2.2**

Give the program

```prolog
married;bachelor:-man,adult.
man.
:-bachelor.
```


determine which of the following clauses are logical consequences of this program:

1. `married:-adult`;
2. `married:-bachelor`;
3. `bachelor:-man`;
4. `bachelor:-bachelor`.

**Solution** 
1. True;
2. False;
3. False;
4. False.

**Exercise 2.3**

Write down the six herbrand interpretations that are not models of the program

```prolog
married;bachelor:-man,adult.
has_wife:-man,married.
```

**Solution**
```prolog
{man, adult}
{man, adult, has_wife}
{man, married}
{man, married, adult}
{man,married, bachelor}
{man, married, adult, bachelor}
```
the following clause is a logical consequence of this program:

```prolog
has_wife;bachelor:-man,adult.
```

**Exercise 2.4**

Give a derivation of `friendly` from the following program:

```prolog
happy;friendly:-teacher.
friendly:-teacher,happy.
teacher;wise.
teacher:-wise.
```

**Solution**

derivations of `friendly` are the clauses `friendly:-teacher` and `teacher`.

**Syntax:** 

defines the formal structure of the language used in propositional clausal logic. it specifies the symboles and rules for constructing valid expressions:

1. Atoms: Basic propositional variables representing statements that can be either true or false
   
2. Clauses: Disjunctions of Atoms
   
3. Programs: Sets of clauses that collectively describe a logiacl system.

**Semantics**

assigns meaning to the syntactic elemnts by defining how the truth values of complex expressions depend on their components:

1. The Herbrand Base: is the set of all possible ground atoms that be formed using the predicates and constants defined in a logic program e.g {woman,man,humain}
   
2. The Herbrand Interpretation: is a specific assignment of truth values (True or False) to all the elements of the Harband Base e.g {Woman -> True, man -> False, Humain-> True} and for convention we can just write {Woman, Humain}.

there are four possibilites for the head and body of the clause:

1.  the body is *true*, and the head is *true*.
2.  the body is *true*, and the head is *false*.
3.  the body is *false*, and the head is *true*.
4.  the body is *false*, and the head is *false*.

**Proof Theory**

Provides the mechanisms for deriving new clauses(theorems) from existing ones (axioms) using inference rules.

for instance, given the clauses:
```prolog
married; bachelor :- man, adult.
has_wife :- man,married.
```

One can resolve them to derive

```prolog
has_wife; bechelor :- man, adult.
```

**Meta-Theory**

Examines the properties and capabilities of the logical system itself, addressing quesions like (Soundness, Completeness).

#### B. Relational Clausal logic

is an extension of propositional clausal logic that allows us to use variables and relations (predicates) to describe complex relationships between objects.

**Syntax**

Now we are going talk about terms used in Relational Clausal logic :

1. Constants :
    
    the names tha refer to specific individuals or objects they should be lowercase words or String enclosed in quotes for example : 
    `peter, maria, 'New York'`


2. Variables : 
   
   Names that refer to arbitrary individuals. They can be replace by any constant during evaluation they are UpperCase Words `X`,`Y`,`S`.

3. Ground Terms : 
   
   Terms that do not contain variables For example `peter` is a ground term, but `S` is not.

4. Predicates : 
   
   Relations between individuals follow the same rules as constants always followed by a number of arguments (terms) example `likes` , `student_of`.

5. Atoms : 
   
   A predicate followed by a list of terms enclosed in brackets seperated by commas example : 

   ```prolog
    likes(peter, maria).
    student_of(maria, peter).
   ``` 

6. Ground Atoms: 
   
   an atom that does not contain variables.

7. Arity : 
   
   The number of arguments a predicate takes example

   ```prolog
    likes(peter, maria).  % Arity = 2.
    student_of(maria, peter). % Arity = 2.
   ```

   Predicates with the same name but different arity are considered differnt.

   ```prolog
   likes/2
   likes/1
   ```

8. Facts : 
   
   Statements that are unconditionally true.

   ```prolog
    student_of(maria, peter).
   ```
   
9.  Rules :
    
    Statements that are true under certain conditions.
    ```prolog
    likes(peter, S) :- student_of(S, peter).
    ```


10. Programs: 
    
    A collection of facts and rules.

**Semantics**

We are going to focus in how Herbrand Universe, Herbrand Base, Herbrand interpretation, and Grounding Substituions work in Relational Clausal Logic.

for all the points below we are going to use the following program

```prolog
Likes(peter, S):-student_of(S, peter).
student_of(maria, peter).
```
1. Herbrand Universe :
   
   The Herbrand Universe of a program is the set of all ground terms (constants) that appear in the program.

   So the herbrand Universe is:
    ```prolog
    {peter, maria}
    ```

2. Herbrand Base:
   
    The Herbrand Base is the set of all possible ground atoms that can be constructed using:

   So the herbrand base is:
    ```prolog
    {
        likes(peter, peter), likes(peter, maria),
        likes(maria, peter), likes(maria, maria),
        student_of(peter, peter), student_of(peter, maria),
        student_of(maria, peter), student_of(maria, maria)
    }
    ```
    This list includes every possible combination of predicates and constants.

3. Herbrand Interpretation:

    A Herbrand Interpretation is a subset of the Herbrand Base where each element is considered true.

    Example : 

    ```prolog
    M = { likes(peter, maria), student_of(maria, peter) }
    ```

4. Substituation : 
   
    A Substitution is a mapping from variables to terms (constants or other variables).

    When a substitution is applied, all occurrences of a variable are replaced by the specified term.

5. Ground Substitution :
   
   A Grounding Substitution is a special kind of substitution that replaces all variables with constants

6. Ground Instances :
   
   The Ground Instances of a clause are all the versions of that clause obtained by applying every possible grounding substitution over the Herbrand Universe.

    ```prolog
   likes(peter, S) :- student_of(S, peter).
   ```
    The Herbrand Universe is `{ peter, maria }`.

    The Ground Instances of the clause:

    ```prolog
    { 
        likes(peter, maria) :- student_of(maria, peter),
        likes(peter, peter) :- student_of(peter, peter)
    }   
    ```

    we applied all possible substitutions from the Herbrand Universe.

7. Model for Non-Ground Clauses :
   
   A model for a non-ground clause is an interpretation that satisfies every ground instance of the clause.

   Example: 

   ```prolog
    M = { likes(peter, maria), student_of(maria,peter)}
   ```

   check if M is a model for :

   ```prolog
   likes(peter, S) :- student_of(S, peter).
   ```

   ground instance:

   ```prolog
   likes(peter, maria) :- student_of(maria, peter).
   likes(peter, peter) :- student_of(peter, peter).
   ```

   Interpretation *M* satisfies the first ground instance but not the second, so it is *not a model*.


**Proof Theory**

In Relational Clausal Logic, proof theory is about how we derive conclusions (proofs) from a set of facts and rules. This involves using resolution and handling variables effectively.

1. Naive Proof Method (Grounding Substitutions).
   
   If we ground every clause before trying to apply resolution, we will have to consider all possible substitutions, This is inefficient because most substitutions will be irrelevant to the proof. If the Herbrand Universe contains four constants, a clause with two distinct variables generates 4^2=16 different grounding substitutions.`A program with three such clauses would have 16^3=4096 grounding substitutions.

2. Improved Proof Method (Unification).
   
   Instead of generating all possible groundings, we derive substitutions directly from the clauses. This process is called unification. Two atoms can be unified if we can make them equal by substituting terms for variables. The resulting substitution is called a unifier.

   example :

   ```prolog
   likes(peter, S):- student_of(S,peter).
   student_of(maria, T):- follows(maria, C), teaches(T, C).
   ```

   the unifier : 

   ```prolog
   { S -> maria, T-> peter }
   ```

   Resulting Clauses After Applying Unifer

   ```prolog
    likes(peter, maria) :- student_of(maria, peter).
    student_of(maria, peter) :- follows(maria, C), teaches(peter, C).
   ```

   Resolvent
   ```prolog
   likes(peter, maria) :- follows(maria, C), teaches(peter, C).
   ```

   We drop the resolved literal `student_of(marian peter)` and combine the remaining literals.

3. Generalization of Clauses
   
   The previous example replaced specific constants with variables to make the rule more general.

    New Program :

    ```prolog
    likes(peter, S) :- student_of(S, peter).
    student_of(X, T) :- follows(X, C), teaches(T, C).
    ```

    This program generalizes the previous rule from maria to any individual that's help to capture a wider range of situations.

4. Most General Unifier (MGU)
   
   Not all unifiers are equal. We prefer the most general unifier (MGU), which: Uses the fewest substitutions necessary to make atoms equal, And can be further specialized to obtain more specific unifiers.
   
   Example :

   ```prolog
    student_of(S, peter).
    student_of(maria, T).
   ```

   we have two possible unifiers:

   `{S -> maria, T -> peter}` - more specific.

   `{S -> X, T -> peter}` - more general (X can be any value).

   the second unifier is preferred because it applies to more situations 

5. Proof by Refutation
   
   The actual proof method involves showing that a query is false by deriving a contradiction (empty clause).

    Example : 

    ```prolog
    likes(peter, S) :- student_of(S, peter).
    student_of(S, T) :- follows(S, C), teaches(T, C).
    teaches(peter, ai_techniques).
    follows(maria, ai_techniques).
    ```

    Query : 

    ```prolog
    :- likes(peter, N).  % "Peter likes nobody."
    ```

    Resolution Steps :

    Unify `student_of(S, peter)` and `student_of(maria, T)`

    ```prolog
    { S → maria, T → peter }
    ```

    Resolve

    ```prolog
    likes(peter, maria) :- follows(maria, ai_techniques), teaches(peter, ai_techniques).
    ```

    Grounding the facts

    ```prolog
    follows(maria, ai_techniques).
    teaches(peter, ai_techniques).
    ```

    The goal `:- likes(peter, N)` is refuted because we can derive

    ```prolog
    likes(peter, maria).   % Proves the query false (empty clause is derived).
    ```

    The substitution `{ N → maria }` is the answer to the query.

    The process can be visualized using proof trees: Each step represents a resolution operation, nodes are clauses, and branches are unifiers applied.

6. Multiple Answers to a Query

    prolog can have multiple valid answers

**Meta-Theory**

Relational resolution is sound, meaning it only produces logical consequences of the input clauses, and refutation complete, meaning it always detects inconsistencies in a set of clauses. However, it is not complete, as it does not always generate every logical consequence of the input clauses. An important characteristic of relational clausal logic is that the Herbrand universe (the set of individuals we can reason about) is always finite, resulting in finite models and a finite number of different models for any program. This finiteness ensures that we can, in principle, determine whether a statement is a logical consequence of a program by enumerating all models and checking if they are also models of the statement. This guarantees termination, making relational clausal logic decidable. However, this property does not hold for full clausal logic, where the Herbrand universe can be infinite and undecidable.

**Exercice 2.6**

How many models does  have over the Herbrand universe `{ peter, maria }`?

**Solution**

number of models = 2^8 = 256 because we have 8 atoms but not all the solutions are valid 9 * 2^4 = 144 models

**Exercise 2.7**

Write a clause expressing that Peter teaches all the first-year courses, and apply resolution to this clause and the clause

```prolog
likes(peter,maria):-follows(maria,C),teaches(peter,C).
```

**[Solution](Logic_And_Logic_Programming/exercise2-1.pl)**

####  C. Full clausal logic

Full clausal logic is an extend to the previous clausals but with Full Clausal logic it allow us to reason about infinite domains by inroducing more complex terms besides constants and variables

example :

```prolog
loves(X,person_loved_by(X)).
```

**Syntax**

terms can be either simple or complex. Constants and variables are simple terms. A complex terms is a functor.

- The terms between brackets in functor are called the arguments of the functor.
- All the other definitions (Atom, Clause, literal, Program) are the same as for relational clausal logic.
   
**Semantics**

in full clausal logic involves interpreting these complex terms and their relationships. A Herbrand interpretation assigns truth values to ground atoms derived from the Herbrand base, which includes all possible ground terms and atoms formed using the predicates and constants in the program. This interpretation provides a model for reasoning about the logical consequences of a set of clauses. 

**Proof Theory**

full clausal logic employs unification as a central mechanism. Unification is the process of finding a substitution that makes different terms identical. This is crucial for applying inference rules like resolution, which is used to derive new clauses from existing ones. The ability to unify complex terms allows for more expressive and powerful reasoning, especially when dealing with infinite or undefined domains. 

####  D. Definite clausal logic

is a subset of clausal logic, used primarily in Prolog. It introduces a significant efficiency improvement by restricting clauses to have at most one positive literal. This restriction reduces computational complexity and increases efficiency in reasoning systems.

The main difference between DCL and full clausal logic is that DCL does not allow negative literals in the head of a clause, making it less expressive but more efficient. In contrast, full clausal logic allows negative information to be handled, which introduces complexity in resolution.

A DCL clause has the form:

```prolog
Head :- Body1, Body2,..., Bodyn.
```

Where the Head is the only positive literal and the Body can consist of one or more negative literals. This restriction simplifies the procedural interpretation, where each clause is used to prove the Head by proving all Body literals.

This structure allows more efficient searching and memory usage, making DCL ideal for systems like Prolog. However, to express more complex logic, negated literals can be used, leading to the transition to general clauses.

### 3. Logic Programming and Prolog 


#### A. SLD-Resolution

is the foundational mechanism for query answering in Prolog. it's the method that Prolog uses to determine whether a query is true based on the given facts and rules.

- Prolog selection rules is left to right 
- Prolog searches the clauses in the program top-down.
- this process is called SLD-resolution
- S for selection rule; L for linear resolution; and D for definite clause you can see the [SLD-tree](https://book.simply-logical.space/_images/image022.svg).
  

#### B. Pruning the search by means of cut





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


## ✅ Introduction to Logic Programming: Syntax, Semantics, and Proof Theory

In logic programming (like Prolog), there are **three important parts** you need to understand:

1. **Syntax** (What the language looks like)
2. **Semantics** (What the language means)
3. **Proof Theory** (How we can reason with the language)

Let’s break them down in simple terms. 😊

---

### 📌 1. Syntax (The Structure of the Language)

**Syntax** is like the **grammar and vocabulary** of a language. It defines:
- The **symbols** you can use.
- How to **combine these symbols** to create valid statements (also called **clauses**).

#### 🔑 In Prolog, syntax includes:
1. **Facts:** Statements that are **unconditionally true**.
```prolog
parent(john, mary).   % Means John is a parent of Mary
connected(bond_street, oxford_circus, central).   % Bond Street is connected to Oxford Circus via the Central line
```
2. **Rules:** Statements that are **conditionally true** (depend on other facts or rules).
```prolog
ancestor(X, Y) :- parent(X, Y).   % If X is a parent of Y, then X is an ancestor of Y.
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).  % Recursive definition for ancestors.
```
3. **Queries:** Questions we ask Prolog to **find out if something is true or to find a solution**.
```prolog
?- parent(john, mary).  % Is John a parent of Mary?
?- ancestor(john, sue). % Is John an ancestor of Sue?
```
4. **Operators:** Symbols like `:-` or `,` which have special meanings in the language.

#### 📚 Summary:
**Syntax** is about how to **write valid Prolog programs**. It tells you what kind of sentences (facts, rules, queries) you can write and how to structure them correctly.

---

### 📌 2. Semantics (The Meaning of the Language)

**Semantics** is about the **meaning of what you write**. It defines **what is true or false** in your program.

#### 🔑 In Prolog, semantics includes:
1. **Assigning truth values:**  
   - Prolog assigns a sentence as **true or false** depending on the facts and rules you define.
2. **Truth-functional logic:**  
   - The truth of a sentence depends on whether the conditions specified are **met or not**.

#### 📚 Example:
```prolog
parent(john, mary).
parent(mary, ann).
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
```
- `?- ancestor(john, mary).` ✅ True
- `?- ancestor(john, ann).` ✅ True
- `?- ancestor(mary, john).` ❌ False

#### 📚 Summary:
**Semantics** is about understanding whether your sentences are **true or false** based on the facts and rules you have written.

---

### 📌 3. Proof Theory (How to Reason with the Language)

**Proof Theory** is about **deriving new sentences** from the ones you already know. It’s the **process of reasoning**.

#### 🔑 In Prolog, proof theory includes:
1. **Inference Rules:**  
   - The way Prolog uses rules to **derive conclusions**.
2. **Axioms:**  
   - These are your **facts and base rules**.
3. **Theorems:**  
   - New sentences derived from your axioms and rules.

#### 📚 Example:
```prolog
parent(john, mary).
parent(mary, ann).
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

?- ancestor(john, ann).
```
- Prolog will try to **resolve** the query using facts and rules, confirming it's true.

#### 📚 Summary:
**Proof theory** is about how Prolog **derives answers** using **facts, rules, and logical inference**.

---

### 🔥 Summary of All Three Parts

| Aspect         | Description                                                          | Example in Prolog                                          |
|----------------|---------------------------------------------------------------------|------------------------------------------------------------|
| **Syntax**     | Structure and format of sentences.                                  | Facts, Rules, Queries.                                      |
| **Semantics**  | Meaning of sentences, determining truth or falsehood.              | Whether a query succeeds or fails based on facts/rules.   |
| **Proof Theory**| Process of deriving new knowledge from existing facts and rules. | Resolution, recursion, and inference.                     |


---

