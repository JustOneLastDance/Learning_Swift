//
//  ViewController.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/6/29.
//

import UIKit

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

class ViewController: UIViewController {
    
    let controllFlow_Value: Int = 88
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FIXME:  一个小小的问题
        // TODO: 1. 看到对象和类
        
        let myFloat: Float = 3.14159
        let sayHello = "\(myFloat), hello, Dicks"
        
        let text = UITextView()
        text.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        text.font = UIFont.systemFont(ofSize: 30)
        text.textColor = .black
        text.text = sayHello
        self.view.addSubview(text)
        
        // 控制流
        ControllFlow(controllFlow_Value)
        
        // switch 的使用
        let vegetable: String = "red pepper"
        use_Switch(vegetable: vegetable)
        
        // 利用for-in 对字典进行遍历
        for_in_loop()
        
        // 元组的使用
        let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
        print(statistics.min)
        print(statistics.0)
        
        //函数可以作为返回值
        //        var increment = makeIncrementor()
        //        var result = increment(7)
        
        //闭包的使用 || 函数作为参数
        let numbers = [20, 19, 7, 12]
        //        hasAnyMatches(list: numbers, condition: lessThanTen)
        
        
        let temp_Value_One = numbers.map({
            (number: Int) -> Int in
            var temp = number
            if (number % 2) != 0 {
                temp = 0
            }
            return temp
        })
        
        // 单个语句的闭包 会把语句的值当作结果返回
        let temp_Value_Two = numbers.map { number in
            4 * number
        }
        print(temp_Value_One)
        print(temp_Value_Two)
        
        let sortedNumbers = numbers.sorted {$0 > $1}
        print(sortedNumbers)
        
        let circle = Circle.init(radius: 2, name: "Circle")
        print(circle.simpleDescription())
        circle.area = 200
        print("radius: \(circle.radius)")
        
        let seven = Rank.seven
        let ten = Rank.ten
        seven.compareWith(anotherNum: ten)
        
        // 手动设置枚举类型的原始值
        if let covertedRank = Rank(rawValue: 3) {
            let threeDescription = covertedRank.simpleDescription()
            print(threeDescription)
        }
        
        let hearts = Suit.hearts
        print(hearts.color())
        
        
        // 关联值
        //        let success = SeverResponse.result("6:00 am", "8:00 pm")
        let powerOff = SeverResponse.powerOff("Server is shutdown")
        
        switch powerOff {
        case let .result(sunrise, sunset):
            print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
        case let .failure(message):
            print("Failure...\(message)")
        case let .powerOff(message):
            print("Poweroff...\(message)")
        }
        
        
        print("=========================")
        // 创建一副扑克牌
        print("The number of Deck is \(Card.numberOfCard)")
        //        let cards = Card.deck()
        //        for card in cards {
        //            print(card.simpleDescription())
        //        }
        
        let a = SimpleClass()
        a.adjust()
        print(a.simpleDescription)
        var b = SimpleStruct()
        b.adjust()
        print(b.simpleDescription)
        
        var num: Int = 20
        num.adjust()
        print(num.simpleDescription)
        
        
        print("=========================")
        let seq_a = [1, 3, 5, 7]
        let seq_b = [1, 2, 3, 4]
        let result = anyCommonElements(seq_a, seq_b)
        print(result)
        
        // 可选绑定
        //        optional_binding(firstNum: 10, secondNum: 35)
        
        
        // 错误处理
        print("==========Demo_Error_Handler============")
        let vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        
        do {
            // 无错误抛出
            try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
            print("Success Yum!")
        } catch VendingMachineError.invalidSelection {
            // 对自动贩卖机三种类型的错误分别进行处理
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.insufficientFunds( let coinsNeeded ) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch {
            print("Unexpected errpr: \(error).")
        }
        
        do {
            try nourish(with: "Beet-Flavored", vendingMachine: vendingMachine)
        } catch {
            // 非 VendingMachine 抛出的错误在此处被捕获
            print("Unexpected non-vending-machine-related error: \(error)")
        }
        
        
        print("================Demo_String==================")
        let linesWithIndentation = """
                                This is shit.
                                     That is asshole.
                                These are whores.
                                """
        print(linesWithIndentation)
        
        
        print("==================Demo_Collection_Type===========================")
        let collection = CollectionType.init()
        print(collection.intsArray)
        collection.showShoppingList()
        collection.showFavoriteGenres()
        print(collection.favoriteGenres.sorted())
        
        
        print("==================Demo_Function===================")
        let mathFunction: (Int, Int) -> Int = addTwoInts
        print("Result: \(mathFunction(2, 3))")
        
        
        print("==================Demo_Closure===================")
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let closureDemo = UseClosure.init(names: names)
        let reversedNames = closureDemo.sortNames_Two()
        print(reversedNames)
        
        
        print("==================Demo_属性包装器===================")
        var rectangle = SmallRectangle()
        rectangle.height = 20
        print("height: \(rectangle.height)")
        
        var demo = DemoWrappedValue(num: ShowValueLog(num: 0), str: CombineTheString(wrappedValue: "Peter", appendStr: "HaHaHa"))
        demo.num = 13
        demo.$num.foo()
        print("\(demo.str)")
        
        
        print("============英文名首字母大写============")
        let user = UserName(fisrtName: "jutin", lastName: "chou")
        print("\(user.fisrtName) \(user.lastName)")
        
        
        print("============继承============")
        let tandem = Tandem()
        tandem.hasBasket = true
        tandem.currentNumberOfPassengers = 2
        tandem.currentSpeed = 22.0
        print("Tandem: \(tandem.description)")
        
        let train = Train()
        train.makeNoise()
        train.makeLoudNoise()
        
        let car = Car()
        car.currentSpeed = 25.0
        car.gear = 3
        print("Car: \(car.description)")
        
        let automatic = AutomaticCar()
        automatic.currentSpeed = 35.0
        print("AutomaticCar: \(automatic.description)")
        
        
        print("==========函数或者闭包初始化属性==============")
        let foo_one = TestClass()
        print(foo_one.someProperty)
        
        
        print("==============嵌套类型====================")
        let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
        print("theAceOfSpades \(theAceOfSpades.description)")
        let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
        print(heartsSymbol.description)
        
        
        print("===================扩展======================")
        3.repetitions {
            print("Foo you")
        }
        
        
        print("===================协议======================")
        let john = Person(fullName: "John Appleseed")
        print(john.fullName)
        
        
        print("===================委托=======================")
        let tracker = DiceGameTracker()
        let game = SnakesAndLadders()
        game.delegate = tracker
        game.play()
        
        print("===================协议的继承=======================")
        print(game.prettyTextualDescription)
        
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        print(d12.textualDescription)
        
        let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
        let myDice = [d6, d12]
        print(myDice.textualDescription)
        
        print("===================协议集合=========================")
        
        let things: [TextRepresentable] = [game, d6, d12]
        for thing in things {
            print(thing.textualDescription)
        }
        
        
        print("=====================泛型==========================")
        var stackOfString = Stack<String>() // 由于 stack 是泛型类型，此时可以声明栈中的类型
        stackOfString.push("uno")
        stackOfString.push("dos")
        stackOfString.push("tres")
        stackOfString.push("cuatro")
        
        let fromTheTop = stackOfString.pop()
        print(fromTheTop)
        
        
        print("==============ARC 相关================")
        var kevin: Tenant?
        var unit4A: Apartment?
        
        kevin = Tenant(name: "Kevin")
        unit4A = Apartment(unit: "4A")
        
        kevin!.apartment = unit4A
        unit4A!.tenant = kevin
        
        kevin = nil
        unit4A = nil
        
        var justin: Customer?
        justin = Customer(name: "Justin")
        justin!.card = CreditCard(number: 1234_5678_9012_3456, customer: justin!)
        
        justin = nil
        
        print("===========闭包的循环引用====================")
        var paragraphy: HTMLElement? = HTMLElement(name: "p", text: "hello,world!")
        print(paragraphy!.asHTML())
        paragraphy = nil
        while true {}
        
    }
    
    // MARK: - 在此处定义函数或者类
    
    
    /// 函数作为一种参数类型
    /// - Parameters:
    ///   - mathFunction: 运算规则
    ///   - a: 一个数
    ///   - b: 另一个数
    func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFunction(a, b))")
    }
    
    /// 函数也可以作为一个类型，一个变量进行使用
    /// - Parameters:
    ///   - a: 一个 int
    ///   - b: 另一个 int
    /// - Returns: a + b 的结果
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        a + b
    }
    
    func nourish(with item: String, vendingMachine: VendingMachine) throws {
        do {
            try vendingMachine.vend(itemNamed: item)
        } catch is VendingMachineError {
            // 判断是否为 VendingMachine 所抛出的错误
            print("Couldn't buy that from the vending machine.")
        }
    }
    
    /// 错误处理 vend中抛出的错误会被传递到 buyFavoriteSnack 被调用的地方
    /// - Parameters:
    ///   - person: 谁买零食
    ///   - vendingMachine: 自动贩卖机
    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }
    
    /// optional binding 可选绑定，用于判断可选类型中是否包含值
    /// - Parameters:
    ///   - firstNum: 第一个元素
    ///   - secondNum: 第二个元素
    func optional_binding(firstNum: Int?, secondNum: Int?) {
        if let first = firstNum, let second = secondNum, first < second && second < 100 {
            print("\(first) < \(second) < 100")
        }
    }
    
    
    /// 利用泛型找出2个数组中相同的数字
    /// T U 表示泛型序列 T.Element表示序列中的元素泛型
    /// 在使用序列时需要注意，有时要和迭代器(Iterator)搭配使用
    /// Iterator 能够在不暴露复杂数据结构细节的情况下遍历其中所有的元素
    /// - Parameters:
    ///   - lhs: 第一数组
    ///   - rhs: 第二数组
    /// - Returns: 两个数组中相同的数组
    func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> [T.Element] where T.Element: Equatable, T.Element == U.Element {
        var result = [T.Element]()
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    result.append(rhsItem)
                }
            }
        }
        return result
    }
    
    
    
    class Circle: NamedShape {
        var radius: Double
        
        var area: Double {
            get {
                return radius * radius * 3.14
            }
            // 由于本属性为计算型故无法直接对其赋值
            set(newValue) {
                self.radius = sqrt(newValue / 3.14)
            }
            
        }
        
        init(radius: Double, name: String) {
            self.radius = radius // 子类特有的属性必须在父类之前先初始化
            super.init(name: name) // 父类的属性实例化需要 super.init
            numbersOfSides = 1
        }
        
        
        
        override func simpleDescription() -> String {
            return "A \(name)'s area is \(area)"
        }
        
    }
    
    class NamedShape {
        var numbersOfSides = 0
        var name: String
        
        init(name: String) {
            self.name = name
        }
        
        deinit {
            // 此处在释放对象之前，可做一些清理工作
        }
        
        func simpleDescription() -> String {
            return "A shape with \(numbersOfSides) sides."
        }
    }
    
    /// 函数作为参数进行传递
    /// 闭包是在之后可被调用的函数，闭包中的代码可以访问闭包作用域中的变量和函数
    /// - Parameters:
    ///   - list: 数组
    ///   - condition: 函数样式需要和传入的函数样式保持一致
    /// - Returns: bool 类型返回值
    func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
        for item in list {
            if condition(item) {
                return true
            }
        }
        return false
    }
    
    /// 该函数作为参数传入 hasAnyMatches 中
    /// - Parameter number: 数字
    /// - Returns: 布尔值
    func lessThanTen(_ number: Int) -> Bool {
        return number < 10
    }
    
    /// 函数可以作为返回值，函数也可以进行嵌套
    /// - Returns: 返回一个函数
    func makeIncrementor() -> ((Int) -> Int) {
        func addOne(number: Int) -> Int {
            return 1 + number
        }
        return addOne
    }
    
    /// 元组的使用 元组.0 表示元组内第一个元素
    /// - Parameter scores: 传入一个数组
    /// - Returns: 返回值是一个三元组
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score
            } else if score < min {
                min = score
            }
            sum += score
        }
        
        return (min, max, sum)
    }
    
    /// 使用 for-in 对字典进行遍历
    func for_in_loop() {
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25]
        ]
        
        var largest = 0
        var numberType: String = ""
        for (type, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    numberType = type
                    largest = number
                }
            }
        }
        print("\(numberType): \(largest)")
    }
    
    /// Switch 的使用
    func use_Switch(vegetable name: String) {
        switch name {
        case "celery":
            print("Celery")
        case "cucumber", "watercress":
            print("cucumber / watercress")
        case let x where x.hasSuffix("pepper"): // 蔬菜名字中含有 pepper
            print("It's spicy!!!")
        default:
            print("Other things")
        }
    }
    
    
    
    /// 控制流
    /// - Parameter score: _ 代表形参用下划线表示该形式参数可忽略 score为形式参数 作用域只在该函数内
    func ControllFlow(_ score: Int) {
        // 括号内的必须是一个布尔表达式，编译器不会隐式地去和 0 进行对比
        if (score > 80) {
            print("Well Done")
        } else {
            print("Bad boy!")
        }
        
        let optionalName: String? = nil
        let fullName: String = "John Appleseed"
        var greeting = "Hello!"
        
        // if let 组合使用可以用来处理值缺失的问题
        // 当 optionalName 为 nil 时，说明值缺失，因此并不会输出任何东西
        if let name = optionalName {
            greeting = "Hello \(name)"
        }
        
        // 当出现值缺失时，可用 ?? 表示用后面的默认值进行代替
        greeting = "Hi, \(optionalName ?? fullName)"
        print(greeting)
        
        
    }
    
}

/// 简单值
struct ShoppingList {
    var shoppingList = ["catfish", "water", "tulips", "blue paint"]
    
    func showDetail() {
        for (item, index) in shoppingList.enumerated() {
            print("\(item) + \(index)")
        }
    }
}

