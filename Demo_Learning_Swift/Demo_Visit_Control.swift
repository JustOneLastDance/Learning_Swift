//
//  Demo_Visit_Control.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/8/19.
//

import Foundation

/**
 访问控制
 限定其他模块或者源文件对代码的访问，用于隐藏代码实现的细节，并且可以对外提供接口进行访问
 
 以下属性、基本类型、函数等统称为实体，以便简单叙述
 */

/**
 模块和源文件
 模块：指独立的代码单元，框架或者应用程序会作为一个独立的模块来构建或者发布
 源文件：指模块中的源代码文件，一般同一个源文件包含多个类型和函数的定义
 */

/**
 访问级别：（5种，排列根据限制由少至多描述）
 1. open 和 pubic
    可以让同一个模块的源文件中的所有实体访问，在该模块外也可以通过导入(import)该模块来访问该模块源文件的所有实体。
    通常情况下，使用 open/public 来指定框架的外部接口。
 
 2. internal
    让实体被同一模块原文件种的任何实体访问，但不能被模块外的实体访问。
    通常情况下，若某个街口只在应用程序或框架内部使用，则设置为 internal
 
 3. fileprivate
    限制实体只能在其被定义的文件内部被访问。
    若功能的部分实现细节只在文件内，则使用 fileprivate
 
 4. private
    限制实体只能在其定义的作用域，以及同一个文件内的 extension 访问。
    若功能的部分实现细节只在当前作用域内使用，就可以用 private 来将其隐藏。
 */

/**
 open 和 public 的区别
 open：只能作用于类和类的成员，可以被其他模块继承和重写
 public：不能被其他模块继承和重写。当类型为 public 时，该类型的成员、方法默认是 internal
 */

/**
 访问级别的基本原则
 实体不能定义在比它访问等级更低的实体中，错误范例例如：
 private class Demo {
    public num: Int
 }
 因为无法保证变量的类型在使用变量的地方也具有访问权限
 */

class ControlledClass {
    private var num: Int
    public var name: String
    fileprivate var cellphone: String
    
    init(num: Int, name: String, cellphone: String) {
        self.num = num
        self.name = name
        self.cellphone = cellphone
    }
    
    fileprivate class func sayhello() {
        print("Hello!!")
    }
}

class ControlledClass_Junior {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    class func sayHello() {
        ControlledClass.sayhello()
    }
}

/**
 自定义类型的访问级别
 1. 如果类型指定为 private/fileprivate，则在该类型下的所有成员的访问级别默认为  private/fileprivate
 2. 如果类型指定为 internal/public (或者不显式地指明)，则在该类型下的所有成员的访问级别默认为 internal
 */

/**
 元组类型的访问级别
 元组的访问将由元组中访问级别最严格的类型所决定
 */

/**
 函数的访问级别
 类似元组，函数的访问级别由参数的类型或者返回值的类型中最严格的类型所决定
 */

struct TrackedString {
    // private(set) 的作用是只能在结构体的定义中进行赋值，即只能在该结构体内部进行修改，外界无法对其进行修改
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}
