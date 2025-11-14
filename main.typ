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
    config-common(
        show-notes-on-second-screen: right,
        handout: false
    ),
)

#speaker-note[
- 大家好！今天很高兴和大家分享Kotlin这门语言。

- 今天，我将向大家介绍 Kotlin 这门语言，以及它如何提升 Android 开发体验。
]

#title-slide()

#outline-slide()

= Why Kotlin?

#speaker-note[
- 首先，我们来看看第一部分：Why Kotlin?

- 也就是看看 Kotlin 为什么近年在 Android 开发中变得如此流行。
我们将从代码简洁性、空安全、与 Java 的互操作性等方面，讲解 Kotlin 的优势。
]

== Conciseness & Readability

#speaker-note[
#set text(size: 18pt)
- Kotlin 代码的简洁性和可读性是它最大的卖点之一。 相比 Java，Kotlin 可以用更少的样板代码完成同样的事情。这里有几个具体的方面：

- 首先，更少的样板代码。Kotlin 提供了类型推断、属性访问器、数据类（data class）、默认参数、具名参数等特性，让很多样板代码都不再需要手写。

- 例如，有了类型推断，我们定义变量时可以不写类型，代码更简洁；借助 data class 可以直接自动生成 toString、equals 等常用方法；默认参数值和具名参数减少了方法重载和调用时的歧义。这些特性都让代码量大大减少。

- 其次，Kotlin 支持顶层函数和扩展函数。顶层函数意味着我们不需要像 Java 那样一定把函数写在 class 里面，可以直接在文件中定义函数，使用起来更直接。而扩展函数允许我们在不修改原类代码的情况下，给现有的类加新功能（后面会详细讲）。这样我们可以为现有库或类添加方法，用起来就像原生的一样，代码变得更流畅。

- 最后一个例子，看看代码可读性的提升：在 Kotlin 中，如果我们有一个 TextView 控件，设置它的文字可以直接写 textView.text = "Hi" ，而在 Java 需要写 textView.setText("Hi")。Kotlin 把常用的getter/setter 转换成属性形式调用，看起来就像给属性赋值，更加直观。这只是一个简单例子，但足以体现Kotlin 让代码更贴近自然语言，更容易理解。
]

- 更少样板代码：类型推断、属性访问器、`data class`、默认参数、具名参数
- 顶层函数与拓展函数
- `textView.text = "Hi"` v.s. `textView.setText("Hi")`

== Null Safety

#speaker-note[
#set text(size: 16pt)
- 空安全是 Kotlin 的另一大优势。相信大家在 Java 开发中都遇到过空指针异常（NullPointerException）。

- Kotlin 通过类型系统来避免这类问题。具体来说，Kotlin 把类型分成可空和不可空两种。例如， String 类型默认不可为 null，而 String? 在类型后加问号，则表示这个变量可以为 null。这样一来，变量是否可能为空在类型层面就清晰标注出来了，编译器会在你未处理空值的情况下直接报错，提前杜绝了空指针异常。

- Kotlin 提供了若干运算符帮助我们安全地处理可空类型：

    - 安全调用运算符 ?. ：在对象可能为 null 时使用。例如 email?.length ，只有在 email 不为 null 时才会调用其 length 属性，如果 email 是 null，这个表达式直接返回 null，而不会抛异常。

    - Elvis 运算符 ?: ：为可能为 null 的情况提供默认值。比如 val len = email?.length ?: 0 ，意思是如果 email?.length 不为 null，就取其值，否则用 0 作为默认值。这避免了繁琐的空值判断，用一行表达式就处理了 null 情况。

    - 非空断言运算符 !! （叹号叹号）：如果你非常确定某个值不为 null，可以用 !! 将其转为非空类型。但如果判断失误，运行时仍会抛 NullPointerException。所以这个运算符应当谨慎使用，一般能不用就不用，尽量用前面的安全调用和 Elvis 运算符来代替。

- 通过这些机制，Kotlin 把空指针的问题大幅降低了。在编译期就提醒你处理可能的 null 情况，这对于大型项目可靠性的提升是非常明显的。
]

- 可空 v.s. 非空: `String` / `String?`
- 编译时检查
- `?.` / `?:` / `!!`

== Interop & Migration

#speaker-note[
#set text(size: 23pt)
- Kotlin 与 Java 具有100% 的 JVM 互操作性，这意味着什么呢？简单来说，你可以在 Kotlin 代码中直接使用现有的 Java 类和方法，反之亦然。

- Kotlin 编译后也是运行在 JVM 上的字节码，所以 Java 和 Kotlin 可以共存于同一个项目，互相调用没有障碍。这对于已经有大量 Java 代码的项目来说非常重要——可以渐进式地将项目从 Java 迁移到 Kotlin，而不用推倒重来。

- 更棒的是，IDE 支持一键转换 Java 代码为 Kotlin。在 Android Studio 或 IntelliJ 中，只要按一下快捷键/菜单，就能把粘贴进来的 Java 代码自动转换成 Kotlin 代码。这对初学者学习 Kotlin 很有帮助，你可以先写出Java 代码，再转成 Kotlin，看看差异。同时这也是迁移旧项目的利器——虽然自动转换可能不是最完美的Kotlin 风格，但已经是一个很好起点，剩下的可以再手动优化。
]

- 100% JVM 互通
- IDE 内一键转换：Java → Kotlin

== Functional Features

- Lambda / 高阶函数：简化监听器与集合操作
- 丰富集合API：`map()`, `filter()`, `flatMap()`, `fold()`...

#speaker-note[
#set text(size: 20pt)
- Kotlin 提供了很多函数式编程特性，使代码更加简洁、高层次。例如，Kotlin 支持 Lambda 表达式 和 高阶函数，这些对于简化事件监听器和集合操作非常有用。

- 可能有同学用过 Java 的匿名类来设置监听，会觉得很繁琐。Lambda 则提供了一种简洁的方式。比如在 Kotlin 中，我们可以用 lambda 来表示按钮点击之后要做的事情，而不用写一大坨 new View.OnClickListener()。代码短小而清晰，一眼就能看出逻辑。

- 另外，Kotlin 的集合 API 非常丰富，受函数式风格影响。比如有 map()、filter()、flatMap()、fold() 等等操作，可以方便地对集合进行转换、过滤和累积运算。

- 总之，Kotlin 的函数式特性让代码更简洁优雅，同时也减少了错误的可能（因为你少写了很多显式的循环和临时变量）。
]

== Toolchain & Ecosystem

- Kotlin-first on Android
- 大量 Jetpack API (coroutines, KTX)

#speaker-note[
- 在 Android 开发领域，Kotlin 现在有着一流的官方支持和繁荣的生态系统。2019 年 Google 宣布 Android 开发进入 “Kotlin-first” 时代，意思是 Kotlin 成为了 Android 官方首选的开发语言。很多新的 Android API 或 Jetpack 库都优先以 Kotlin 版本提供，对 Kotlin 做了特别优化。

- 比如 Jetpack 中大量组件都提供了 Kotlin 扩展（KTX）库。一些常用的 Android 类在 KTX 库里增加了 Kotlin 扩展函数或属性，让我们用 Kotlin 写代码时更加顺手。还有协程 (Coroutines) 等现代并发工具也是在 Kotlin 中才有的，用于替代过去的 AsyncTask 等方案，编写异步代码更简单直观。
]

= Basic Syntax

#speaker-note[
- 刚才我们讨论了 Kotlin 的诸多优势，总结来说：它代码简洁、空安全、与 Java 完全兼容，支持函数式编程，而且有强大的官方支持和生态。所以Why Kotlin这个问题，我们已经回答了一部分。

- 接下来进入第二部分：Basic Syntax，我们来了解 Kotlin 语言本身的基础语法和特性。这一部分可能信息量较大，但请大家放心，很多概念其实和你们熟悉的语言类似，只是 Kotlin 有自己的简洁表达方式。我会通过示例代码演示，让大家逐步熟悉 Kotlin 写代码的感觉。
]

== Variables & Types
#speaker-note[
#set text(size: 20pt)
- 首先是 Kotlin 的变量和类型。Kotlin 引入了两个关键字来声明变量：val 和 var。如果大家写过Swift或者Rust可能会比较熟悉。具体来说：
    - val 声明的是只读变量（相当于常量）。一旦赋值后就不能再改变，类似于 Java 里的 final 变量。
    - var 声明的是可变变量，可以被重新赋值。

- 示例代码中，我们声明了几个只读变量。Kotlin 有类型推断能力，这里我们没写类型，编译器会自动推断 x 是 Int 类型。如果需要，我们也可以显式标注类型，比如下面这样，这样更清楚地表明 lang 是字符串。同时我们看到，接下来 lang = "Kotlin" 是被允许的，因为 lang 是 var，可以修改。

- 相反，如果尝试修改一个 val 就会报错。例如代码里我们对pi二次赋值就会得到一个编译错误。这展示了 val 的特性：不可重新赋值，保证了数据的不变性。

- 另外，Kotlin 的类型转换不像 Java 那样自动。比如我们想把一个 Int 赋给 Long，需要调用转换函数，而不是像 Java 那样可以自动从小类型转换成大类型。
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

#speaker-note[
- Kotlin 对字符串拼接提供了非常方便的字符串模板功能，使用 \$ 符号即可将变量值嵌入字符串。

- 对于更复杂的表达式，比如我们想打印名字的长度，用 \${name.length} 包裹起来，Kotlin 会计算表达式 name.length（也就是 6），然后拼入字符串。

- 熟悉 Python 的同学可能觉得这类似于 f-string；没错，概念上是相同的。Kotlin 的字符串模板提高了可读性：看到字符串里 \$ 标识符，就知道有动态内容，字符串内容一目了然。

- 再补充一点，Kotlin 的字符串字面量可以用三引号 \"\"\" 来表示多行字符串，非常方便撰写长段文字或包含换行的内容。但一般情况下，模板字符串用起来已经覆盖大多数需求，让我们的打印和拼接逻辑简化了许多。
]

#codly(footer: [Hello, Martin! len=6])
#raw(lang: "kotlin", block: true,
`val name = "Martin"
println("Hello, $name! len=${name.length}")
`.text)

== Functions

#speaker-note[
#set text(size: 18pt)
Kotlin 用关键词 fun 来声明函数，与众不同之处在于它支持很多灵活的语法：
- 首先，Kotlin 函数可以用表达式的形式来定义。如果函数体非常简单，只是一个表达式的返回值，我们可以直接用 = 来定义而不写大括号和 return。例如代码里的 fun max(a: Int, b: Int)
- 其次，Kotlin 函数支持 默认参数。也就是说我们可以在定义函数时给参数一个默认值，这样调用函数时可以省略这个参数。默认参数避免了写很多重载函数，使用起来也很人性化。
- 另外，Kotlin 支持 具名参数调用。当函数参数很多或者想强调某个参数意义时，可以在调用时写出 paramName = value 的形式 （Line 9）
- 还有，Kotlin 的函数如果不返回有意义的值，返回类型是 Unit，相当于 Java 的 void。但我们一般可以省略不写，默认就是返回 Unit。像上面的 hello 函数，它没有返回值类型声明，但实际上编译器知道它返回 Unit，也就是什么都不返回。
- 最后一个很重要的：顶层函数。在 Kotlin 中，你可以在文件最外层直接定义函数（就像写脚本一样），不需要一定放在类里。这和 Java 强制函数必须属于某个类很不同。顶层函数使得某些工具函数、扩展函数的组织更方便。在 Android 开发中，我们经常会创建一些文件专门放工具函数，就是借助顶层函数这个特性。
总之，Kotlin 函数声明比起传统语言更灵活强大：可以轻松定义单行函数，参数管理更方便，也不用拘泥于类的范畴。

]

#slide(composer: (1fr, 2fr))[
- `fun`
- 表达式
- 默认参数
- 具名参数
- 空返回值：`Unit`
- 顶层函数
][
#codly(footer: [
    Hello, World! \
    Hello, Sekai!
])
#raw(lang: "kotlin", block: true,
`fun max(a: Int, b: Int) = 
    if (a > b) a else b

fun hello(name: String = "World") {
    println("Hello, $name!")
}

hello()
hello(name = "Sekai")
`.text)
]

== Control Flow

#speaker-note[
#set text(size: 19pt)
控制流方面，Kotlin 既有熟悉的结构，也增加了一些更强大的用法。这里举几个例子：
- 首先，if 在 Kotlin 中是可以作为表达式的。这意味着你可以直接把 if 的结果赋给一个变量，而不用像 Java 那样必须在 if 里面赋值或用三元运算符。Kotlin 没有单独的 ?: 三目运算符，因为 if 本身就能返回值。这样代码显得更统一，也避免了像 Java 那样为了一个简单的条件赋值还得写整段 if-else。
- 其次，Kotlin 提供了功能更强的 when 表达式，它可以替代 Java 的 switch/case，并且用法更加灵活。when 不仅可以匹配常量值，还能匹配条件（比如范围、类型等）。
- 再说一下 区间 和 步长。Kotlin 中，和 Swift 类似，1..n 表示从 1 到 n 的闭区间，这是个 Range 对象，可以用于循环或判断。until 则表示半开区间，例如 0 until 10 相当于 0 到 9，不包含10。代码里用 for (i in 0 until 10 step 2) 来循环，step 2 表示步长为2，所以 i 将依次取 0,2,4,6,8，然后打印出来，输出结果是 02468。Range 和 step 这些用法让 for 循环的意图非常清晰，同时避免了一些 off-by-one（差一）错误。
- 当然，传统的 while 和 do-while 循环 Kotlin 也都支持，用法和 Java 类似，这里就不展开了。整体而言，Kotlin 的控制流既保留了熟悉的结构，又通过 if 表达式、when 表达式和丰富的区间操作提供了更简洁优雅的用法。
]

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

#speaker-note[
#set text(size: 18pt)
现在聊聊 Kotlin 的 类和属性，还有特别有用的 数据类。Kotlin 定义类的时候，比 Java 要精简得多。
- 首先，Kotlin 支持主构造函数直接在类头部声明。在第1行中，我们就同时完成了构造函数和属性的定义：name 和 age 作为参数传入类的主构造器，前面加了 val 和 var，于是 Kotlin 自动为我们创建了对应的属性和默认的 getter/setter。所以不需要像 Java 那样在类里面再声明 String name; int age;，也不需要编写构造函数把参数赋给字段，这些 Kotlin 都帮我们做好了。类体里面我们可以像普通语言一样添加方法，比如这里的 birthday() 方法就是给 Person 增加年龄的。
- 然后是数据类 data class。在 Kotlin 里，如果一个类主要是用来容纳数据，我们可以直接在声明前加上 data 关键字，Kotlin 会自动为它生成很多常用方法。比如第4行的例子就是一个数据类。它自动拥有：toString()、equals()、hashCode()、copy() 方法。这些方法我们一行代码都不用写，Kotlin 自动根据属性生成。
- 后面代码展示了如何使用数据类提供的功能：创建一个 Point(10, 20)，然后调用它的 copy(y = 30) 来基于原对象复制出一个 y 改为 30 的新 Point，最后打印它。因为 data class 自带 toString，所以打印结果直接是 Point(x=10, y=30)，很直观。
- 想象一下，如果用 Java 来写一个等价的 Point 类，我们至少要写构造函数、getter、setter、toString、equals、hashCode，还不算 copy 功能，实现起来非常麻烦。而 Kotlin data class 几个字就搞定了。这对我们开发中定义模型类、实体类太有帮助了，可以把注意力更多放在业务逻辑上，而不是浪费时间编写模板式的代码。
]

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

#speaker-note[
#set text(size: 18pt)
接下来是 空安全 话题，再补充一些 Kotlin 在这方面的便利，以及智能类型转换。刚才我们提到过这些操作符，现在代码里有个例子更直观：
- 这里 email 被声明成 String? 可空类型，并赋值为 null。下面的第2行表示“如果 email 非空，就取 length，否则直接返回 null”。由于整个表达式可能是 null，我们紧接着用 ?: 0 给出默认值 0。这样一行代码就实现了：“如果有 email 字符串就计算长度，否则记为0”。len 最终得到一个非空的 Int 值。这个过程如果用 Java，就得先判空再计算，非常啰嗦；用 Kotlin 就很自然。
- 再看另一个函数。这里体现了 Kotlin 的智能类型转换（Smart Cast）。函数参数 x 是个 Any（相当于 Java Object），它可能是任何类型。如果我们想处理字符串的情况，写了 if (x is String) 这个检查。那么在 if 内部，Kotlin 编译器自动把 x 当作 String 类型对待，我们可以直接调用 x.length 而无需显式强制转换。因为 Kotlin 知道经过 is String 判断后，x 一定是 String 类型。所以我们看到 println(x.length) 直接可用。
- 顺带提一下 非空断言 !! 的作用场景：它其实就是把可空类型转换为非空类型，如果判断错了就抛异常。我们在 Kotlin 中一般避免用 !!，除非非常确定不会为 null（比如框架保证的回调参数）。通常还是建议利用可空类型体系本身，安全地处理 null 而不是强行断言。
总而言之，Kotlin 的空安全设计和智能类型转换让我们写健壮代码更轻松，避免了一大类常见错误，也减少了很多显式类型转换的麻烦。
]

- 可空：`?`
- 安全调用: `?.`
- Elvis：`?:`
- 非空断言：`!!`

#raw(lang: "kotlin", block: true,
`var email: String? = null
val len = email?.length ?: 0 // fallback when null
fun printLen(x: Any) {
  if (x is String) println(x.length) // smart cast, without explicit casting
}
`.text)


== Extension Functions & Operator-like APIs

#speaker-note[
#set text(size: 18pt)
现在来看 扩展函数 以及类似运算符的简洁调用。这个概念如果你以前没见过可能稍微抽象，但请看例子：
- 第1行代码定义了一个扩展函数 lastChar()，作用是在 不修改 String 类源代码 的情况下，给 String 类型新增一个函数。fun String.lastChar() 的写法表示我们扩展了 String，有了一个可以通过 String 实例调用的新函数。函数体很简单，就是返回该字符串的最后一个字符。
- 这样，当我们有 "Hello" 这样的字符串时，就可以直接调用 "Hello".lastChar()。Kotlin 会在编译时把它转化为我们定义的那个函数调用，得到返回值字符 o（"Hello" 的最后一个字母）。在代码和调用者看来，String 仿佛自带了一个 lastChar() 方法一样。这就是扩展函数的威力：不需要继承 String 类，也不用修改标准库，就能为它添新功能。
- 这种能力非常适合给现有类做“锦上添花”。尤其当我们使用某些库，希望简化调用时，可以写扩展函数。比如可以给 List 添加一个 second() 方法返回第二个元素等等，完全根据需要定制。
- 至于幻灯片上提到的 “Operator-like APIs”，指的是 Kotlin 还允许我们自定义一些运算符的行为，比如重载加号、索引操作符等等。配合扩展函数，我们甚至可以定义矩阵类的 plus 函数，实现用 matrix1 + matrix2 来做矩阵相加。这些细节属于更进阶的内容，我们暂且不深究。大家只要知道 Kotlin 能让我们以很优雅接近运算符的方式调用函数，写出 DSL 风格的代码。这都是建立在扩展函数等特性的基础上的。
]

为已有类型添加方法而不改源码

#codly(footer: [o])
#raw(lang: "kotlin", block: true,
`fun String.lastChar(): Char = this[lastIndex]
println("Hello".lastChar())
`.text)

== Collections & Lambdas (Quick Look)

#speaker-note[
#set text(size: 19pt)
这一页快速看看集合与 Lambda 的组合威力。Kotlin 的集合分成两种：不可变集合和可变集合。listOf<T>() 创建的是不可变列表，创建后不能增删元素；mutableListOf<T>() 创建可变列表，就像 Java 的 ArrayList 那样可以修改。Kotlin 通过这种区分，鼓励我们尽量使用不可变集合，只有确实需要改变时才用可变集合，增加代码安全性。
- 然后看例子代码：这段代码展现了 Kotlin 管道式处理集合的能力。(1..10) 先生成1到10的整数区间。接着我们对它调用 .filter()，这个 Lambda 表达式会筛选出偶数（it是集合元素的代称)。filter 运行后会返回一个新集合（包含 2,4,6,8,10）。然后 .map() 会把前一步的每个元素拿出来平方，形成新的集合。
- 整个链式调用非常直观：过滤然后映射。中间用到了 Lambda，使代码简洁明了，没有写任何显式的 for 循环，却完成了复杂的操作。这种风格在函数式编程里很常见，Kotlin 让我们很自然地使用它。
- 需要注意的是，这里我们直接用 Range 和集合操作，如果集合很大，这样可能会产生一些中间集合。Kotlin 也提供 Sequence 来做惰性评估（lazy evaluation），避免中间过程开销，不过那属于深入优化的内容了。就目前来说，这种写法在处理一般数量的数据时已经足够方便又易读了。
总的来说，Kotlin 对集合的支持和对 Lambda 的运用让我们能写出简洁优美的数据处理代码，这一点用过 Python 等语言的同学应该深有体会。
]

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

#speaker-note[
#set text(size: 19pt)
现在讲 Kotlin 的 对象声明和伴生对象。这两个概念听起来抽象，但其实很好用：
- 对象声明（object）：Kotlin 用 object 关键字可以直接声明一个单例对象。比如代码里的这一段就声明了一个名为 Logger 的单例对象。它类似于创建了一个只有一个实例的类，我们不需要初始化，Logger 就已经存在，可以直接用。里面定义了一个 log() 方法用来打印日志。所以在别的地方用 Logger.log("Hello") 就能调用。这种 object 特别适合用来存放一些全局的工具函数之类的，省去了自己写单例模式的麻烦。
- 伴生对象（companion object）：如果我们需要在类内部声明一个单例对象，可以用 companion object。它相当于这个类的静态成员持有者。
- User 类内部有一个 companion object。可以把它理解为 User 类自带了一个“伴随的”单例，这个单例没有名字，我们可以直接通过 User.createDefault() 调用其中的方法。这里定义的 createDefault() 是一个工厂方法，用于创建一个默认名字的用户实例。伴生对象最常见的用途就是替代静态方法和静态字段——因为 Kotlin 没有 static 关键字，所以我们用伴生对象来实现类似效果。比如我们可以在 companion object 里定义一些常量，或者是一些实用函数。调用时都通过类名来调用，就像在用静态成员。
]

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

#speaker-note[
Kotlin 的 枚举类（enum class）在概念上类似于 Java 枚举，但更加强大灵活。举个例子，代码里定义了一个方向的枚举：
- 可以看到，Kotlin 的枚举定义允许我们给每个枚举常量提供构造参数和属性。这里 Direction 枚举类有两个属性 dx 和 dy，每个方向枚举值（UP, DOWN, LEFT, RIGHT）后面都传入了一对 (dx, dy) 数值用来构造。[44]例如 UP 对应 (0, -1)，表示向上移动在 x 轴不变，y 轴-1。
- 我们还可以在枚举类中定义方法，比如这里写了一个 isVertical()来判断该方向是否垂直方向（也就是 UP 或 DOWN）。调用的时候，例如 Direction.UP.isVertical() 就会返回 true。
]

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

#speaker-note[
密封类（sealed class）是 Kotlin 特有的一个概念，用于表示受限的类继承结构。简单说，sealed class 可以有子类，但这些子类必须限定在同一个文件中定义。这样编译器在检查 when 等分支时，就知道所有可能的子类情况。
]

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

#speaker-note[
#set text(size: 22pt)
最后，简单总结一些 Kotlin 的风格和惯用法。这些算是官方和社区推荐的最佳实践，有些之前已经隐约提到过：
- 命名方面，Kotlin 和 Java 类似，采用驼峰命名法（CamelCase）
- 尽量使用不可变的值，也就是尽量用 val 而非 var。除非确实需要改变，否则默认把变量声明为 val。这种不变性可以避免很多潜在错误。另外，能不用 !! 非空断言就不用——通常如果你觉得需要写 !!，可能意味着代码可以改进。
- 对于简单的函数，优先使用表达式语法来定义。当然如果函数逻辑复杂，有多行也别硬挤一行。
- 充分利用 Kotlin 标准库提供的函数和语法糖。Kotlin 有许多内置的扩展函数和全局函数，可以减少你手动编写循环或判断的代码。
总的来说，遵循这些惯用风格，可以避免很多常见错误，让代码风格一致且优美。在座各位如果开始写 Kotlin，可以参考 Kotlin 官方的编码规范文档，其中有详细的指南。
]

- 驼峰式命名
- 多用不可变，避免`!!`
- 对于简单函数，优先使用表达式
- 充分利用标准库

= Android with Kotlin

#speaker-note[
好了，Kotlin 语言本身的介绍到这里告一段落。

Basic Syntax 部分信息量很大，相信大家也注意到了 Kotlin 丰富的特性。没关系，第一次接触不可能全记住，只要了解有这些功能存在就行，用的时候可以再查。

接下来我们进入第三部分。这一部分，我们将对比一些 Android 开发里常见的代码用法，在 Java 和 Kotlin 中有什么不同，看看 Kotlin 是如何让这些代码变得更简洁安全的。

很多同学可能还停留在 Java 阶段，那么这些对比应该能引起共鸣。
]

== `findViewById(@IdRes int id)`

#speaker-note[
#set text(size: 22pt)
首先来看一个 Android 开发中家喻户晓的场景：通过 findViewById 寻找并使用 UI 元素。
- 在 Java 中，我们一般这么写：可以看到，为了给一个按钮设置点击事件，我们要先用 findViewById 获取它的引用，然后实现一个匿名内部类并 onClick 方法。
- 然后再看看 Kotlin 的版本：是不是清爽很多？首先，findViewById 我们依然用了，但是类型推断可以省略一部分，我们这儿显式地把 button 定义为 Button 类型。如果需要，我们也可以显式标注类型，比如下面这样，这样更清楚地表明
- 关键是第二行，Kotlin允许我们直接传入一个匿名函数，运行时它会帮我们生成 Listener 对象。对于我们开发者来说，再也不用写匿名类和一堆override了，只要把逻辑写进去就好。
对比来看：Kotlin 版本减少了大量样板代码，没有分号，语法上也更贴近人话。大家在阅读 Kotlin 代码时，可以更专注在业务逻辑上，而不会被各种类型声明、接口实现的噪音干扰。
]

#raw(lang: "java", block: true,
`Button button = findViewById(R.id.button);
button.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View view) {
        // Do something
    }
}
`.text)

#pause

#raw(lang: "kotlin", block: true,
`val button: Button = findViewById(R.id.button)
button.setOnClickListener { 
    // Do something
}
`.text)

== View Binding

#speaker-note[
我们刚才还是用了 findViewById 来获取界面元素引用，但是近几年 Google 推出了一个 View Binding 功能，来替代繁琐和不安全的 findViewById。
- 要使用 View Binding，首先需要在 Gradle 配置中启用它。这样编译器就会为每个布局文件生成对应的绑定类。
- 开启后，在 Activity 或 Fragment 中，我们可以拿到这个绑定类的实例，然后通过它直接访问布局中的 Views。
- 完成初始化后，就可以像这样写。binding.button 就是布局里 id 为“button”的那个 Button 对象，而且类型已经是 Button。
在 Kotlin 中使用 View Binding 很自然，因为 Kotlin 本身对属性访问、空安全的支持，让我们可以充分发挥 View Binding 的优势。虽然在 Java 也能用 View Binding，但因为少了 Kotlin 这些语法糖，代码上还是不如 Kotlin 那么简洁。
]

#pause

#codly(
    header: [build.gradle.kts],
    header-cell-args: (align: center)
)
#raw(lang: "kts", block: true,
`android {
  buildFeatures { viewBinding = true }
}
`.text)

#pause

#codly(
    header: [MainActivity.kt],
    header-cell-args: (align: center)
)
#raw(lang: "kotlin", block: true,
`binding.button.setOnClickListener {
    // Do something
}
`.text)

== View Binding v.s. `findViewById()`

#speaker-note[
总之，View Binding 让我们专注于“如何使用控件”，而不是“如何找到控件”。Kotlin 则进一步简化了使用 Binding 的语法，所以两者结合能显著提升开发体验。

现在新项目普遍都使用 View Binding 或 Jetpack Compose 等新技术，手写 findViewById 几乎成为过去式了。
]

- 生成绑定类，类型安全、空安全
- 更少模版代码

== Getter/Setter

#speaker-note[
再来看另一个对比：传统 Java 的 Getter/Setter 方法 vs Kotlin 的属性语法。

在 Java 代码中，我们经常会看到这样的调用。没什么问题，但看着有点啰嗦，而且直观性稍差。
]

#raw(lang: "java", block: true,
`textView.setText("Ready");
view.setVisibility(View.VISIBLE);
`.text)

== Property Access

#speaker-note[
但是在 Kotlin 中，我们就可以这么写。

这两行等价于刚才 Java 的效果。

顺带一提，这种语法在 Kotlin 调用 Java 库时也适用——凡是符合 Java Bean 命名规范的 getter/setter，Kotlin 都允许用属性语法访问。所以不只是 Android 视图，任何 Java 对象的 getName()/setName() 在 Kotlin 中都能写成这个样子。
]

#raw(lang: "kotlin", block: true,
`textView.text = "Ready"
view.isVisible = true
`.text)

== Custom Getters & Setters

#speaker-note[
Kotlin 也允许我们自定义属性的 getter 和 setter，从而在访问属性时隐含一些逻辑。

看看这个例子：这里 Rectangle 有宽和高两个属性，它的 area 并没有在主构造里声明，而是在类体内声明为 val area: Int，紧接着定义了一个 getter。

表示每次有人访问 area 时，Kotlin 会调用这个 getter 计算 width*height 并返回。这样 area 看起来是个属性，用法和普通属性一样，但实际上每次取值都会动态计算最新的面积。

如果用 Java 的话，我们可能会写一个 getArea() 方法，或者把 area 存一份然后在 width/height 改变时更新。但 Kotlin 这种自定义 getter 的方式更优雅：对使用者来说，rectangle.area 就是取一个属性，没有感觉到这是在调用方法。而我们又避免了存储冗余数据，每次实时计算，也保证了值的正确性。

]

#codly(footer: [6])
#raw(lang: "kotlin", block: true,
`class Rectangle(val width: Int, val height: Int) {
    val area: Int
        get() = this.width * this.height
}

val rectangle = Rectangle(2, 3)
println(rectangle.area)
`.text)

== POJO (Plain Old Java Object)

#speaker-note[
这一页幻灯片展示的是 Java 里定义一个简单数据类（POJO）需要做的事情。例如我们要定义一个 User 类，包含用户名和年龄两个字段，在 Java 中通常写法是这样的：

也就是说，除了字段本身，我们往往还要为它写一堆getter/setter方法。如果要比较两个 User 对象是否内容相等，还需要覆写 equals() 和 hashCode()。为了调试打印方便，最好再写一个 toString()。这些全是样板代码，没有太多技术含量，却很繁琐。

有的同学可能会说，用 IDE 可以自动生成那些方法。但即使生成了，代码还是得摆在那里，又长又难读，而且以后字段一改又要更新这些方法。可以说，Java 写这个非常啰嗦。像幻灯片里就省略了实现，只是在类里用注释标明“这里本该有 getters/setters, equals/toString等等”。如果全写出来，恐怕要占满一屏甚至更多。
]

#raw(lang: "java", block: true,
`public class User {
    String name;
    int age;

    // getters

    // setters

    // equals / toString ...
}
`.text)

== `data class`

#speaker-note[
但是用 Kotlin 的话，就是这样，简简单单把想要的属性列出来就行。

然后，Kotlin 编译器会自动为 data class 生成：
- 所有字段的 getter 和 setter
- equals() 和 hashCode()
- toString()
- copy()

所以说，data class 极大地减少了样板代码，使代码量和逻辑量更加接近1:1。写更少的代码意味着更少的bug风险，对开发者来说也是更愉快的体验。

当然对于 Java 我们可以使用 Lombok 或者 record 类。但是 Lokbom 依赖外部注解，而 record 需要较新的 JDK, Android 环境不一定支持。
]

#raw(lang: "kotlin", block: true,
`data class User(val name: String, val age: Int)
`.text)

= Kotlin in Real Projects

#speaker-note[
最后，我想带大家看看实际项目里的 Kotlin 代码是什么样的，并进行一个简单的演示。这部分我们会将理论付诸实践，更直观地感受 Kotlin 的威力。
]

== Kotlin in Real Projects

#speaker-note[
这里我介绍一个用 Kotlin 编写的真实项目 —— Yuri（余日），这是一个倒数日的应用。

项目代码已经开源，上面给出了仓库链接。有兴趣的同学会后可以自行查看源码。
]

#slide(composer: (5fr, 3fr))[
    - *Yuri*: A Countdown Day app
    - https://github.com/martin-cao/Yuri
][
    #image("img/yuri.png", width: 70%)
]

== Demo

#speaker-note[
接下来我会现场打开 Android Studio，运行这个 Yuri 应用并简单演示其功能。同时，会带大家浏览部分代码，特别是 UI 层的代码，看看 Kotlin 的特性在真实项目中是如何发挥作用的。
]

#focus-slide[Demo]

== References

#speaker-note[
以上就是本次分享的全部内容。

希望这些对大家日后深入学习 Kotlin 有所帮助。Kotlin 这门语言上手并不难，但功能非常强大，值得投入时间钻研。

我的分享就到这里，谢谢大家的耐心听讲！如果各位还有任何问题，欢迎提问，我们可以进一步讨论。祝大家在学习 Kotlin 的旅程中收获满满！
]

- Kotlin Doc: https://kotlinlang.org/docs/home.html
- Android API reference: https://developer.android.com/reference
- JetBrains: https://www.jetbrains.com
- Android Studio: https://developer.android.com/studio
- JetBrains 技术交流开放日: https://mp.weixin.qq.com/s/VL6-HBqxfVVTWbvxsTWPgQ
- Typst: https://github.com/typst/typst
- touying: https://github.com/touying-typ/touying
- Fonts: Noto Sans CJK SC / JetBrains Mono