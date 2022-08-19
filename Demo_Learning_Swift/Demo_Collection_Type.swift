//
//  Demo_Collection_Type.swift
//  Demo_Learning_Swift
//
//  Created by JustinChou on 2022/7/19.
//

import Foundation


/// 集合类型的应用，注意索引都是从0开始
class CollectionType {
    
    /// 数组使用“有序”列表存储同一类型的多个值
    var intsArray: [Double] = []
    var shoppingList: [String] = ["Eggs", "Milk", "Butter", "Chocolate Spread"]
    
    /// 集合用于存储相同类型并且“无序”的值，当集合元素顺序不重要或者希望每个元素只出现一次时用集合
    /// 类型想要存储在集合中，必须可以哈希化(在 Swift 中所有基本类型都可哈希化，若是自定义类型需要遵循协议 Hashable)
    /// Set 中的类型必须显式声明
    var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
    
    /// 字典是一种无序的集合，它存储的是键值对之间的关系，所有键和值的类型都要相统一，且 key 要遵守 Hashable
    var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
    
    init() {
        let threeDoubles = Array(repeating: 0.0, count: 3)
        let anotherThreeDoubles = Array(repeating: 1.0, count: 3)
        self.intsArray = threeDoubles + anotherThreeDoubles
    }
    
    func addSomeElementsIntoArray(elementOne: Double, elementTwo: Double) {
        intsArray.append(elementOne)
        intsArray += [elementTwo]
    }
    
    /// 用 for-in 对数组进行遍历
    func showShoppingList() {
        for (index, value) in shoppingList.enumerated() {
            print("Item\(String(index + 1)): \(value)")
        }
    }
    
    /// 由于set类型没有确定的顺序，为了按照特定顺序进行遍历，故在集合对象后使用 .sorted() ，使用该方法会返回一个有序数组
    func showFavoriteGenres() {
        for genre in favoriteGenres.sorted() {
            print("\(genre)")
        }
    }
    
}
