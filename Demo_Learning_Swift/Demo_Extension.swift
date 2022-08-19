//
//  Demo_Extension.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/8/9.
//

import Foundation

/**
 扩展
 可以给现有的类、结构体、枚举和协议添加新的功能
 不用访问被扩展类型的源代码就能完成新功能的添加
 扩展与 oc 中分类有点类似 oc中需要命名名字，但在 swift 中不需要
 
 在要进行扩展的类、结构体、枚举类型之前添加 extension 即可
 */

extension Int {
    func showMe() {
        print("I'm \(self)")
    }
}

/**
 扩展可以给现有的类型添加计算型实例属性和计算型属性
 */

extension Double {
    var km: Double { return self * 1_000.0 }
        var m: Double { return self }
        var cm: Double { return self / 100.0 }
        var mm: Double { return self / 1_000.0 }
        var ft: Double { return self / 3.28084 }
}

/**
 在扩展中可以给现有的类型添加新的构造器。可以添加便利构造器，但是不能添加指定构造器或者析构器，这两个只能由父类提供。
 */

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 1...self {
            task()
        }
    }
}
