//
//  Demo_Inheritance.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/8/4.
//

import Foundation

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        print("make some noise.")
    }
}


class Bicycle: Vehicle {
    var hasBasket = false
}


class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

/**
 重写
 子类重写继承下来的实例方法，定制化需要的功能
 在要重写的方法之前添加关键字 override
 
 若要访问父类的方法，则要使用 super.someMethod()
 */

class Train: Vehicle {
    override func makeNoise() {
        print("choo choo.")
    }
    
    func makeLoudNoise() {
        super.makeNoise()
    }
}

/**
 重写属性
 重写继承下来的实例或者类型属性，为自己定制化 getter 和 setter，或者添加属性观察器，不论是存储或者计算属性，不论是只读还是读写属性
 要确保重写的属性的名字和类型与父类中要进行重写的属性保持一致
 */
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

/**
 重写属性观察器
 通过重写一个继承下来的属性，为其添加属性观察器，观察值发生的任何变化
 不可以给常量存储属性和只读计算属性添加属性观察器，因为这些属性值不可以进行设置
 */
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

/**
 防止重写
 若不让子类对继承下来的属性或是方法进行重写，则要在关键字前 添加 final 防止重写
 */
