//
//  Demo_Closure.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/7/25.
//

/**
 闭包是自包含的函数代码块，可在代码中传递和使用，有点类似 OC 中的 block
 闭包可以捕获和存储它所在上下文中的任意常量和变量的引用
 闭包是引用类型，即使捕获的变量或者常量的原作用域不在了，闭包依然可以在自身的函数体内引用或者修改这些值 （类似深拷贝）
 swift 负责被捕获变量的所有内存管理工作
 */

import Foundation
import UIKit

class UseClosure {
    var nameArray: [String] = []
    
    init(names array: [String]) {
        self.nameArray = array
    }
    
    /// 排序闭包
    /// - Parameters:
    ///   - s1: 第一个参数
    ///   - s2: 第二个参数
    /// - Returns: bool值
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    /// backward 作为排序规则 对名字数组进行排序
    /// - Returns: 名字的有序数组
    func sortNames_One() -> [String]{
        return nameArray.sorted(by: backward)
    }
    
    
    /// 闭包表达式语法
    /// - Returns: 有序名字数组
    func sortNames_Two() -> [String] {
        // by: 之后为闭包的表达式语法
        return nameArray.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })
    }
    
    /// 由于 sorted 中明确了需要一个 bool的返回值 故省略 return
    /// swift 可推断出参数和返回值类型 类型可省略
    /// swift 会自动给内联闭包提供参数名称缩写功能， 故可以用 $0 $1... 来顺序调用闭包的参数 $0 表示第一个参数 $1 表示第二个参数， 以此类推
    /// - Returns: 名字的有序数组
    func sortNames_Simplest() -> [String] {
        return nameArray.sorted(by: { $0 > $1 })
    }
    
    /**
     逃逸闭包
     当一个闭包作为参数传入一个函数中，但该闭包只能在函数返回之后才被执行，则称其为逃逸闭包
     @escaping 表示闭包可以逃逸出该函数，且在闭包必须显式地引用 self
     多用在异步操作
     */
    var completionHandlers: [() -> Void] = []
    func someFunctionWithEscapingClosure(completionHandler: @escaping ()-> Void ) {
        completionHandlers.append(completionHandler)
    }
    
    /**
     自动闭包
     一种自动创建的闭包，用于包装传递给函数作为参数的表达式，且该闭包不接受任何参数
     可实现延时求值的功能
     */
    
}
