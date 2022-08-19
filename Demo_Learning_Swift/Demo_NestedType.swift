//
//  Demo_NestedType.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/8/9.
//

import Foundation

/**
 嵌套类型
 在允许的类型中定义嵌套的枚举、类和结构体，且在 {} 中定义
 */

struct BlackjackCard {
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        
        /// 牌面可表示的两种形式 例：A 可表示1 也可表示为11
        struct Values {
            let first: Int, second: Int?
        }
        
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}
