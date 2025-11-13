#import "@preview/touying:0.6.1": *
#import themes.stargazer: *

#import "@preview/numbly:0.1.0": numbly
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *

#set text(font: "Noto Sans CJK SC")
#show raw: set text(font: "JetBrains Mono")

#codly(languages: codly-languages)

#show: codly-init.with()

#show: stargazer-theme.with(
    lang: "zh",
    aspect-ratio: "4-3",
    config-info(
        title: [A Brief Introduction to Kotlin],
        subtitle: [Make Android Great Again],
        author: [martin-cao],
        date: datetime.today(),
        institution: [Tianjin University of Science and Technology],
    ),
    // config-common(show-notes-on-second-screen: right),
)

#title-slide()

#outline-slide()

= Why Kotlin?

== Conciseness & Readability

- 更少样板代码：类型推断、属性访问器、`data class`、默认参数、具名参数
- 顶层函数与拓展函数
- `textView.text = "Hi"` v.s. `.setText("Hi)`

#speaker-note[
  + This is a speaker note.
  + You won't see it unless you use `config-common(show-notes-on-second-screen: right)`
]

== Null Safety

- 可空 v.s. 非空: `String` / `String?`
- 编译时检查
- `?.` / `?:` / `!!`

== Interop & Migration

- 100% JVM 互通
- IDE 内一键转换：Java → Kotlin

== Functional Features

- Lambda / 高阶函数：简化监听器与集合操作
- 丰富集合API：`map()`, `filter()`, `flatMap()`, `fold()`...

== Toolchain & Ecosystem

- Kotlin-first on Android
- 大量 Jetpack API (coroutines, KTX)

= Basic Syntax

== Variables & Types
#speaker-note[
- `val` / `var`
- 类型推断 & 显式类型标注
- 类型转换

#raw(lang: "kotlin", block: true,
`val x = 114514
val longX = x.toLong()
val pi = 3.1415
var lang: String = "Java"
lang = "Kotlin"
// pi = 3.14 // ❌ Error
`.text)
]

#slide[
- `val` / `var`
- 类型推断 & 显式类型标注
- 类型转换
][
#raw(lang: "kotlin", block: true,
`val x = 114514
val longX = x.toLong()
val pi = 3.1415
var lang: String = "Java"
lang = "Kotlin"
// pi = 3.14 // ❌ Error
`.text)
]

== Strings & Templates

#codly(footer: [Hello, Martin! len=6])
#raw(lang: "kotlin", block: true,
`val name = "Martin"
println("Hello, $name! len=${name.length}")
`.text)

== Functions

#slide(composer: (1fr, 2fr))[
- `fun`
- 表达式
- 默认参数
- 具名参数
- 空返回值：`Unit`
- 顶层函数
][
#raw(lang: "kotlin", block: true,
`fun max(a: Int, b: Int) = 
    if (a > b) a else b

fun hello(name: String = "Sekai") {
    println("Hello, $name")
}

hello()
hello("World")
`.text)
]

== Control Flow

#slide(composer: (1fr, 2fr))[
- `if` 可作表达式
- `when` 覆盖多种匹配 (`switch` / `match`)
- 区间：`1..n`, `until`, `step`
- `while`
][
#codly(footer: [02468])
#raw(lang: "kotlin", block: true,
`val max = if (a > b) a else b
val grade = when (score) {
    in 90..100 -> "A"
    in 60..89  -> "B"
    else       -> "C"
}
for (i in 0 until 10 step 2) print(i)
`.text)
]

== Classes, Properties, Data Classes

- 主构造函数
- `val` / `var` 直接生成属性
- `data class` 自动生成常见方法

#codly(footer: [Point(x=10, y=30)])
#raw(lang: "kotlin", block: true,
`class Person(val name: String, var age: Int) {
  fun birthday() { age++ }
}
data class Point(val x: Int, val y: Int)
val p = Point(10, 20).copy(y = 30)
println(p.toString())
`.text)


== Null Safety & Smart Casts

- 可空：`?`
- 安全调用: `?.`
- Elvis：`?:`
- 强制解包：`!!`

#raw(lang: "kotlin", block: true,
`var email: String? = null
val len = email?.length ?: 0 // fallback when null
fun printLen(x: Any) {
  if (x is String) println(x.length) // smart cast, without explicit casting
}
`.text)


== Extension Functions & Operator-like APIs

为已有类型添加方法而不改源码

#codly(footer: [o])
#raw(lang: "kotlin", block: true,
`fun String.lastChar(): Char = this[lastIndex]
"Hello".lastChar()
`.text)

== Collections & Lambdas (Quick Look)

- 不可变 `listOf<T>()`，可变 `mutableListOf<T>()`
- 管道式处理

#raw(lang: "kotlin", block: true,
`val evensSquared = 
    (1..10).filter {
        it % 2 == 0
    }.map {
        it * it
    }
`.text)

== Object & Companions

- `object`：单例对象
- `companion object`：伴生单例对象（用于类的静态成员）

#raw(lang: "kotlin", block: true,
`object Logger {
    fun log(msg: String) = println("Log: $msg")
}

class User(val name: String) {
    companion object {
        fun createDefault() = User("Anonymous")
    }
}
val u = User.createDefault()
`.text)

== Enums

- 支持构造函数、属性和方法
- 自带 `values()` / `valueOf()`

#raw(lang: "kotlin", block: true,
`enum class Direction(val dx: Int, val dy: Int) {
    UP(0, -1),
    DOWN(0, 1),
    LEFT(-1, 0),
    RIGHT(1, 0);

    fun isVertical() = this == UP || this == DOWN
}
`.text)

== Sealed Classes

- 有限且可扩展的类型层次
- 于同一文件内定义
- 常用于：结果类型、UI状态、AST、网络响应封装……

#raw(lang: "kotlin", block: true,
`sealed class Result
data class Ok(val v: String): Result()
data class Err(val msg: String): Result()
fun handle(r: Result) = when (r) {
  is Ok  -> r.v
  is Err -> "Error: ${r.msg}"
}
`.text)

== Idioms & Style

- 驼峰式命名
- 多用不可变，避免`!!`
- 对于简单函数，优先使用表达式
- 充分利用标准库

= Android with Kotlin



