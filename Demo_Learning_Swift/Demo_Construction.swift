//
//  Demo_Construction.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/8/4.
//

import Foundation

/**
 构造过程
 在使用结构体、类、枚举类型的实例之前的准备过程
 要对每个存储属性赋予一个初始值以及一些必要的设置或者构造过程
 用于创建新的实例
 和 oc 的不同一点在于 swift 的构造器没有返回值
 */

/**
 两段式构造过程
 第一阶段：为类中的每一个存储属性赋予一个初始值
 第二阶段：当实例准备使用之前，看存储属性是否需要自定义
 */

/**
 4种安全检查保证两段式构造过程不会出错
 1. 指定构造器要保证类中的所有属性先初始化完成，之后才将其他构造任务交付给父类的构造器
 2. 指定构造器在给继承的属性设置新值之前要调用父类的构造器。否则构造器赋予的新值会被父类的构造器所覆盖
 3. 便利构造器首先要调用父类的构造器，否则便利构造器赋予的新值会被父类构造器所覆盖
 4. 构造器在完成第一阶段构造之前，不能调用任何实例方法，不能读取任何实例中属性的值，不能使用self作为一个值MID
 */

struct Fahrenheit {
    var temperature: Double
    // 不带行参的构造器
    init(temp: Double) {
        // 此处要为存储属性进行初始化
        temperature = 32.0
    }
}

struct Celsius {
    var temperature: Double
    // 带行参的构造器，可有多个构造器 fromFahrenheit - 行参 fahrenheit - 实参
    init(fromFahrenheit fahrenheit: Double) {
        temperature = (fahrenheit  - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperature = kelvin - 273.15
    }
}

/**
 必要构造器
 在构造器前添加关键字 required 表示所有继承自该类的子类都必须实现这个构造器
 */
class BaseClass {
    required init() {
        
    }
}

class SubClass: BaseClass {
    // 重写父类构造器时，当该父类构造器是必要构造器时，也要添加关键字 required，且不用添加 override
    required init() {
        
    }
}

/**
 利用闭包或者函数为存储属性设置初始值
 */
class TestClass {
    let someProperty: Int = {
        // 注意在该闭包中，其他属性并没有初始化，故其他属性无法访问，且无法隐式使用 self
        var temp = 0
        for index in 1...5 {
            temp += index
        }
        return temp
    }() // 后面紧跟 () 不可省略，表示该闭包立刻执行
}

// 闭包初始化属性例子 —— 8X8 黑白相间的棋盘
struct ChessBoard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !false
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
