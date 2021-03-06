# function programming with Racket

## Who the fuck am I?

- 陳電鋸
- 非 CS 但幾乎天天都寫程式
- R, Python, Lisp

## 我們對語言的認知

| 動作 action | 物件 things |
| --- | --- |
| 動詞 Verbs | 名詞 Nouns |
| 函數 functions | 數據 data |

我(打死)了一個[人]。

f(x) = x<sup>2</sup>

f(100) = 100<sup>2</sup> = 10000

## 為何微積分難以理解 aka 我如何與僱主解釋我會考 A.Maths 只有 E

d(x<sup>2</sup>) dx = 2x

教師從來沒有說明 x<sup>2</sup> 及 2x 是 functions 。

而 dx/dx 亦都是 function 。

事實上更好的寫法是:

d(x↦x<sup>2</sup>)dx = (x↦2x)

語言的例子: 我(分解)了(殺)，結果是(斬)。

## Functions as data

- Functions as argument of another function
- Functions of functions
- Higher-order functions

## First class

functions are the first class citizens in any functional programming language.

何解?

## First class citizen

- value of a variable
- argument to a procedure
- return value from a procedure
- member of an aggregate

## e.g. first class data - integer

- value of a variable

```{c}
int x = 100;
```

- argument to a procedure
- return value from a procedure

```{c}
int square(int x) {
    int square_of_x = x * x;
	return square_of_x
}
```

- member of an aggregate

```{c}
int fib[5] = {0,1,1,2,3};
```
## First-class function

- value of a variable
- argument to a procedure
- return value from a procedure
- member of an aggregate

aka 'functions as data'

# Racket

- Scheme 是 Lisp 的方言。Racket 是 Scheme 的方言。
- 不要問我 Racket 的用途
- 本課程是教 Functional programming 不是「教 Racket」。

## Visualization of programming


