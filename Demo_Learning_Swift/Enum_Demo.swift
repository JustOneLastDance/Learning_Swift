//
//  Enum_Demo.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/7/7.
//

import Foundation


/// 结构体 创建一副扑克牌
struct Card {
    var rank: Rank
    var suit: Suit
    static let numberOfCard: Int = 54
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) is \(suit.simpleDescription())"
    }
    
    
    /// 类型方法：使用类型本身而不是类型的实例去调用的方法
    /// 创建一副扑克牌 在方法之前需要声明 static
    /// - Returns: 一副扑克牌
    static func deck() -> [Card] {
        var cards = [Card]()
        
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                let card = Card(rank: rank, suit: suit)
                cards.append(card)
            }
        }
        
        return cards
    }
}

/// 枚举类型的关联值
enum SeverResponse {
    case result(String, String)
    case failure(String)
    case powerOff(String)
}


/// 枚举类型 Suit
/// 为了让枚举能够支持遍历，需遵守 CaseIterable
enum Suit: CaseIterable {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        case .diamonds, .hearts:
            return "red"
        }
    }
}

/// 枚举类型的学习，给枚举赋予原始值且在内部可定义函数
enum Rank: Int, CaseIterable {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    // 枚举类型内可以定义函数
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
    
    func compareWith(anotherNum: Rank) {
        if self.rawValue > anotherNum.rawValue {
            print("\(self.simpleDescription()) is much larger")
        } else {
            print("\(anotherNum.simpleDescription()) is much larger")
        }
    }
}
