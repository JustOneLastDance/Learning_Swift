//
//  Demo_Property.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/7/25.
//

import Foundation

/**
 存储属性：
 用于存储类或者结构体实例中的变量或者常量，一般用 var 来标记
 */

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

/**
 延时加载存储属性
 当属性第一次被调用时才得到其初始值，一般用 lazy 来标记，且延时加载属性必须要用 var
 因为属性的初始值可能在实例化之后才能得到，而常量属性要在构造之前得到其初始值
 当属性的值要经过大量计算或者非常耗时才能得到时，延时加载会很有用
 */

class DataImporter {
    /*
     该类负责将外部文件数据导入
     */
    var fileName = "data.txt"
}

/// 提供数据管理功能
class DataManager {
    // 由于数据导入耗时，故使用 lazy
    lazy var importer = DataImporter()
    var data: [String] = []
}


/**
 计算属性
 类、结构体、枚举可以定义计算属性
 不直接存储值，而是提供一个 getter 和一个可选的 seeter 用于间接的获取和设置“其他”属性或者变量
 */

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            // 此处没有定义新值的参数名，可以使用默认参数名 newValue
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}


/**
 属性观察器
 监控和响应属性值的变化，每次属性修改都会调用属性观察期
 在这些位置可以设置观察器：自定义的存储属性｜继承的存储属性｜继承的计算属性
 */

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("将 totalSteps 的值设置为 \(newTotalSteps)")
        }
        didSet {
            // oldValue 表示旧值的默认参数名
            if totalSteps > oldValue  {
                print("增加了 \(totalSteps - oldValue) 步")
            }
        }
    }
}

/**
 属性包装器
 在管理属性如何存储和定义属性的代码之间添加一个分隔层
 若属性需要线程安全性检查或者要在数据库中存储基本数据，则必须为每个属性添加同样的代码逻辑。只要写一次管理代码，包装器就可以为多个属性进行复用
 */

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}


/// 包装器 TwevleOrLess 可以确保长宽不超过12
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

/**
 类型属性
 与某个类型关联的静态常量或者变量，作为全局静态量定义
 通常写在类型的最外层花括号内，用关键字 static 进行修饰
 */

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // 将当前音量限制在阈值之内
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // 存储当前音量作为新的最大输入音量
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

/// Practice

@propertyWrapper
struct ShowValueLog {
    var num: Int
    var wrappedValue: Int {
        get { num }
        set {
            num = newValue
            print("new value is \(newValue)")
        }
    }
    
    /// 通过定义projectedValue属性，属性包装器可以公开更多API。 对projectedValue的类型没有任何限制。
    /// 由此方可使用函数 foo()
    var projectedValue: ShowValueLog { return self }
    
    func foo() {
        print("The Int noob.")
    }
    
}

@propertyWrapper
struct CombineTheString {
    // 局部参数
    private var appendStr : String
    
    // 被包装的参数
    private var str: String
    var wrappedValue: String {
        get { str }
        set {
            str = newValue + appendStr
            print("New String is \(str)")
        }
    }
    
    func foo() {
        print("The String noob.")
    }
    
    init(wrappedValue: String, appendStr: String) {
        self.appendStr = appendStr
        str = wrappedValue + appendStr
    }
    
}

struct DemoWrappedValue {
    @ShowValueLog var num: Int
    @CombineTheString(wrappedValue: "", appendStr: "HAHAHA") var str: String
}

@propertyWrapper
struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

struct UserName {
    @Capitalized var fisrtName: String
    @Capitalized var lastName: String
}
