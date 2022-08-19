//
//  Demo_Generics.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/8/11.
//

import Foundation
import UIKit

/**
 泛型
 根据自定义的需求，编写出适用于任何类型的、可灵活复用的函数和类型。如此可以避免编写重复的代码，通过抽象的方式表达代码的功能
 例如：数组，字典都是泛型集合
 */

class Generics<Element> {
    var a: Element
    var b: Element
    
    init(a: Element, b: Element) {
        self.a = a
        self.b = b
    }
    
    // 交换两个 Int 的值
    func swapTwoInt(_ one: inout Int, _ two: inout Int) {
        let temp = one
        one = two
        two = temp
    }
    
    /// 利用泛型抽象成两个元素进行对调，不用在意元素的类型
    /// T 是占位符类型名，并不是实际的类型名 只要求 one 和 two 类型是相同的即可，注意 <T> 是紧跟在函数名之后的
    /// 当函数被调用时，T就为直接被替换成 one 的类型，例如 one 是 int，那么调用后 T 就变成了 int
    /// - Parameters:
    ///   - one: 第一个元素
    ///   - two: 第二个元素
    func swapTwoElement<T>(_ one: inout T, _ two: inout T) {
        let temp = one
        one = two
        two = temp
    }
}

/**
 泛型类型
 */


/// 利用泛型类型创建一个栈，实现后进先出
struct Stack<Element> {
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

/**
 类型约束
 即指定类型参数必须继承自指定的类、协议或者协议组合
 */

/// 若没有添加协议 Equatable 则无法使用 ==，故此处类型应该要遵循 Equatable
extension Stack {
    func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
}

/**
 关联类型
 定义一个协议时，声明关联类型作为协议定义的一部分会很有用
 关联类型为协议中的某个类型提供了一个占位符名称，所代表的实际类型在协议被遵循时才会被确定，利用关键字 associatedtype
 */

protocol Container {
    associatedtype Item: Equatable // Item 为抽象的类型，方便下方的功能使用。同时也可以给关联类型添加约束
    
    mutating func append(_ item: Item)
    
    var count: Int { get }
    
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // 此处类型才被指定，所有 Item 类型被 Int 替换
    typealias Item = Int // 此句可有可无，系统会根据下方函数参数的类型自动推断出指定类型
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

/**
 关联类型和泛型之间的操作
 */
protocol ContainerGenerics {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// 此处 Item 由 泛型 Element 取代
struct StackTwo<Element>: ContainerGenerics {
    // Stack<Element> 的原始实现部分
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

/**
 包含上下文关系的 where 分局
 使用泛型时，可以为没有独立类型约束的声明添加 where 分句
 */

// 当关联类型 Item 是 Int 调用 average()
// 当关联类型 Item 遵循 Equatable 调用 endsWith()
extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count - 1] == item
    }
}
