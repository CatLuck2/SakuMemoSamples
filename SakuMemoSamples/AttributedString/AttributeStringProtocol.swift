//
//  AttributeStringProtocol.swift
//  SakuMemoSamples
//
//  Created by 藤澤洋佑 on 2021/12/30.
//

import Foundation

protocol AttributeStringProtocol {
    func AttributeBold(string: String)
    func AttributeItalic(string: String)
    func AttributeUnderLine(string: String)
    func CreateList()
    func CreateItems()
    func CreateItemsWithNumber()
}
