//
//  Demo_Error_Handler.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/7/14.
//

import Foundation

/// 贩卖机错误类型
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

/// 售货机商品
struct Item {
    var price: Int
    var count: Int
}


/// 自动售货机
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        // 如下3个 guard let 表明可能抛出的错误类型
        // 判断是否存在商品名称
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        // 判断是否有存货
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        // 判断金额是否充足
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}


/// 售卖零食
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
