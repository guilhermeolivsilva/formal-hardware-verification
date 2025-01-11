# Lecture 7 Questions (07/01/2025)

**Guilherme de Oliveira Silva**

## Question 1

`f: (a || b) && (!a || !b || c)`

`f` is satisfiable. If we choose `a = 0` and `b = 1`, `f` will be `true`
regardless of the value assumed by `c`:

```markdown
f: (0 || 1) && (!0 || !1 || X)
= f: (1) && (1 || 0 || X)
= f: (1) && (1)
= f: 1
```

## Question 2

The formula `f: (x1 && x2) || (!(x3 && x4))` is not in the Conjunctive Normal Form (CNF) because the
clauses are in disjunction, and each clause is a conjunction. CNF is the opposite of that: the
clauses themselves must be disjunctions, and be connected with conjunction operators.

So, we convert:

```markdown
f: (x1 && x2) || (!(x3 && x4))
= f: (x1 && x2) || (!x3 || !x4)
= f: (x1 || (!x3 || !x4)) && (x2 || (!x3 || !x4))
= f: (x1 || !x3 || !x4) && (x2 || !x3 || !x4)
```

## Question 3

### First item

In the first implementation of the half-adder, the next state of `c[0]` is simply its inverted value.
So, `c[0]'` is `!c[0]`. The next state of `c[1]` is the result of `c[0] ^ c[1]`. So we can write
`c[1]' = (c[0] && c[1]) || (!c[0] && c[1])`.

### Second item

In the second implementation of the half-adder, the next state of `c[0]` is the result of
`c[0] ^ 1`. We can rewrite this expression:

```markdown
c[0]' = c[0] ^ 1
c[0]' = (c[0] && !1) || (!c[0] && 1)
c[0]' = (c[0] && 0) || (!c[0])
c[0]' = !c[0]
```

`c[1]'`, on the other hand, is the result of `c[1] ^ (c[0] && c[1])`. This expression can also be
simplified:

```markdown
c[1]' = c[1] ^ (c[0] && c[1])
c[1]' = (c[1] && !(c[0] && c[1])) || (!c[1] && (c[0] && c[1]))
c[1]' = (c[1] && (!c[0] || !c[1])) || (0)
c[1]' = ((c1 && !c[0]) || (c1 && !c[1]))
c[1]' = ((c1 && !c[0]) || 0)
c[1]' = (c1 && !c[0])
```

## Question 4

`c` is a 32-bit integer, so there are 2**32 possible values it might assume. However, from the reset
state, its value can only be in the interval `[0, 5]` – a total of 6 feasible states.

The following assertion can check this:

```verilog
always @(posedge clk or posedge rst) begin
    assert (c >= 0 && c <= 5)
end
```

## Question 5

The circuit would require:

* `not` gate: `b = !a`
* `and` and `not` gates: `ready && (!empty)`
* `mux` gate: `sel ? a : b`

But the number of elements could be reduced to just `a`: after all, `sel` can be simplified to `1`,
which also simplifies `out` to `a`.

## Question 6

This circuit requires a DFF (`a -> D`, `clk -> clk`, `en -> en`; `Q -> q`) and can't be simplified.

## Question 7

The circuit would require:

* two `or` gates;
* two `mux` gates.

However, the circuit can be entirely ignored. This is because the signals `b`, `c`, `d`, `e` and `f`
are not driven – thus, `a` is never used.

## Question 8

### First item

1. To process = {a}; visited = {};
2. To process = {b, j}; visited = {a};
3. To process = {j, c}; visited = {a, b};
4. To process = {c, k}; visited = {a, b, j};
5. To process = {k, d, h, i}; visited = {a, b, j, c};
6. To process = {d, h, i, l}; visited = {a, b, j, c, k};
7. To process = {h, i, l, e}; visited = {a, b, j, c, k, d};
8. To process = {i, l, e}; visited = {a, b, j, c, k, d, h};
9. To process = {l, e}; visited = {a, b, j, c, k, d, h, i};
10. To process = {e}; visited = {a, b, j, c, k, d, h, i, l};
11. To process = {f, g}; visited = {a, b, j, c, k, d, h, i, l, e};
12. To process = {g}; visited = {a, b, j, c, k, d, h, i, l, e, f};
13. To process = {}; visited = {a, b, j, c, k, d, h, i, l, e, f, g};

### Second item

To identify whether `f` is in the fanin of `a`, one could use the Depth-First Search algorithm while
walking backwards – i.e., recursively visiting the parents of each node during the traversal. For
the traversal to not visit all the nodes in the graph, it is sufficient to start the search from `f`
and stop when there are no (recursive) parents to visit.
