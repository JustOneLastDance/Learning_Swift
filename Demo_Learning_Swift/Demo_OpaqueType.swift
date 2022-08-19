//
//  Demo_OpaqueType.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/8/13.
//

import Foundation

/**
 不透明类型
 具有不透明返回类型的函数或方法会隐藏返回值具体的类型信息。
 函数不提供具体的类型作为返回类型，而是根据遵循的协议来描述返回值
 在处理模块和调用代码之间的关系时，隐藏类型信息很有用，可以让返回的底层数据类型仍然可以保持私有
 不透明类型可以保证类型的一致性
 */

// 绘制想要的图形
protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}

// 利用泛型实现垂直翻转
struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}
