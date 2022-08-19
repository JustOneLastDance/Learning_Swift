//
//  Demo_Class.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/7/7.
//

import Foundation

/**
 结构体和枚举都是值类型，即当被赋值给一个变量或者常量，或传递给一个函数时，它的值会被拷贝。
 引用类型，即被赋值给一个变量或者常量，或传递给一个函数时，使用的是原本存在实例的引用，非拷贝。
 */

/// 类，枚举和结构体都可以遵循协议
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number is \(self)"
    }
    
    mutating func adjust() {
        self += 40
    }
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    
    func adjust() {
        simpleDescription += " Now is 100% adjusted"
    }
}

struct SimpleStruct: ExampleProtocol {
    var simpleDescription: String = "A very simple structure."
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
