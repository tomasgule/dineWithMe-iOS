//
//  Array+Identifiable.swift
//  dineWithMe
//
//  Created by Tomas Gule on 21/03/2021.
//

import Foundation

extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count{
            if self[index].id == matching.id{
                return index
            }
        }
        return nil
    }
}
