//
//  Demo_Protocol.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/8/10.
//

import Foundation

/**
 协议
 规定实现某一特定任务或者功能的方法、属性或者其他东西，但具体实现需要在类型中实现
 */

/**
 协议属性
 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性
 协议不指定属性是存储属性还是计算属性，仅指定属性的名称和类型，还可以指定是可读，还是可读可写
 */
protocol SomeProtocl {
    var mustBeSettable: Int { get set } // 可读可写
    var doesNotNeedToBeSettable: Int { get } // 可读
}

protocol AnotherProtocol {
    // 定义类型属性，使用关键字 static，还可以使用 class
    static var someTypeProperty: Int { get set }
}

/**
 举个🌰
 */
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

/**
 协议作为类型
 1. 作为函数、方法或者构造器中的参数类型或返回值类型
 2. 作为常量、变量或属性的类型
 3. 作为数组、字典或者其他容器中的元素类型
 */
protocol RandomNumberGenerator {
    func random() -> Double
}

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

/**
 委托
 委托是一种设计模式
 将需要实现的功能委托给其他类型的实例来实现
 定义协议来封装要被委托的功能，这样能够确保遵循协议的类型提供实现的功能，委托可以来响应特定的动作，或者接受外部数据源提供的数据，且不用关心外部数据源的类型
 */

/// 所有涉及骰子游戏的都可遵循
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

/// 骰子游戏的委托，用于追踪游戏的过程，为了防止循环引用，可以把协议声明为弱引用
protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

/**
 委托例子
 */

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
    gameLoop: while square != finalSquare {
        let diceRoll = dice.roll()
        delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
        switch square + diceRoll {
        case finalSquare:
            break gameLoop
        case let newSquare where newSquare > finalSquare:
            continue gameLoop
        default:
            square += diceRoll
            square += board[square]
        }
    }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}


/**
 在扩展里添加协议遵循
 即使无法修改源代码，可通过扩展让已有的类型遵循并符合协议
 通过扩展让已有类型遵循并符合协议时，该类型的所有实例也会随之获得协议中定义的功能
 */

/// 描述自身协议
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides) - sided dice"
    }
}

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}


/**
 有条件地遵循协议（泛型）
 泛型类型可能只在某些情况下满足一个协议的要求，例如当类型的泛型形式参数遵循对应协议时，可在扩展类型列出限制让泛型类型有条件的遵循某个协议
 在协议名称之后添加 where 后面再跟条件
 */

// 条件为数组中的元素也遵循 TextRepresentable
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

/**
 Equatable 协议 - 通过 == 或 != 进行比较是否相同或者不同
 1. 遵循 Equatable 协议且只有存储属性的结构体
 2. 遵循 Equatable 协议且只有关联类型的枚举
 3. 没有任何关联类型的枚举
 
 Hashable 协议 - 实现 hash(into: ) 功能
 
 Comparable 协议 - 实现 <、 >、 <=、 >= 功能的实现
 */

/**
 协议类型的集合
 可把遵循相同协议的实例放在同一个数组或者字典中
 */

/**
 协议的继承 类似类的继承
 */
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

/**
 类的专属协议
 若要保证协议只能由类类型遵循，则要将 AnyObject 添加在协议列表之中
 当协议的要求遵循协议的类型时引用类型而不是值类型，则要用专属协议
 */
protocol SomeClassOnlyProtocol: AnyObject, SomeProtocl {
    // todo
}
