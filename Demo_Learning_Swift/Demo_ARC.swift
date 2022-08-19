//
//  Demo_ARC.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/8/13.
//

import Foundation

/**
 ARC
 用于管理和跟踪应用程序的内存
 *仅适用于类的实例*
 结构体和枚举类型是值类型，不是应用类型，不由 ARC 管理
 值类型的存放在 栈区，引用类型存放在 堆区
 值类型的赋值是通过 拷贝，而引用类型是靠指针（引用）
 */

/**
 ARC 的工作机制
 每当创建一个新的类实例，ARC 会分配一块内存在存储该实例的信息
 为了确保使用中的实例不会被销毁，ARC 要跟踪和计算每一个实例正在被多少属性、常量、变量所引用，当 ARC = 0 时 实例才会被销毁
 */

class Person_ARC {
    let name: String
        init(name: String) {
            self.name = name
            print("\(name) is being initialized")
        }
        deinit {
            print("\(name) is being deinitialized")
        }
}

/**
 循环引用
 当 A和 B 互相强引用时，两者都无法释放。因为 A 和 B 的 ARC 都不为0
 */

/**
 解决实例之间的循环引用的两种方法
 1. 弱引用 weak reference
 2. 无主引用 unowned reference
 二者都是允许循环引用中的一个实例引用而另一个实例不保持强引用
 
 当其他实例拥有较短的生命周期时，使用弱引用
 当其他实例拥有较长的生命周期时，使用无主引用
 */

/**
 弱引用
 ARC 在实例被销毁后自动将弱引用赋值为 nil，且弱引用的对象应该时可选变量
 */

class Tenant {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
//    var tenant: Tenant?
    weak var tenant: Tenant? // 弱引用: 关键字 weak 对象必须为可选变量
    deinit { print("Apartment \(unit) is being deinitialized") }
}


/**
 无主引用
 与弱引用不同的是，无主引用的对象都应该是有值，标记为无主引用的对象不用变成可选变量，arc 也不会将其置为 nil
 使用无主引用，必须确保引用指向的是一个未销毁的实例，如下例子：客户可能没有银行卡，但银行卡会关联一个客户
 */

/**
 可选值的底层是 Optional，是标准库的枚举类型，也就是说是值类型而不是引用类型，可选值是值类型不能被标记为 unowned
 可选值封装的类不使用引用计数，所以不用维持对可选值的强引用
 */

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer // 无主引用
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit { print("Card #\(number) is being deinitialized") }
}


/**
 闭包的循环强引用
 当在闭包体内要访问一个实例的方法或者属性，会导致闭包捕获 self，导致循环引用
 */
class HTMLElement {
    let name: String
    let text: String?
    
    // lazy：只有当被调用的时候，才会使用
//    lazy var asHTML: () -> String = { // 该闭包内部是默认值
//        // 在闭包体内捕获 self，从而导致了循环引用
//        if let text = self.text {
//            return "<\(self.name)>\(text)<\(self.name)>"
//        } else {
//            return "<\(self.name)>"
//        }
//    }
    
    /**
     解决闭包的循环强引用 —— 定义捕获列表
     通过声明被捕获的引用类型为弱引用或者无主引用来处理循环引用
     
     闭包由参数列表和返回类型，捕获列表形式如下
     lazy var someClosure = {
        [unowned self, weak delegate = self.delegate] in
        // 闭包函数体
     }
     
     无主引用：
     在闭包和捕获的实例总是互相引用且又同时销毁，则应该使用无主引用
     
     弱引用：
     被捕获的实例可能变为 nil 时，应该使用弱引用
     
     <*> 如果被捕获的引用绝对不会变为 nil，则应该使用无主引用 <*>
     */
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}
