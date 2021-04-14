//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Abraao Levi on 03/04/21.
//

import Foundation

extension Array where Element: Identifiable {

    func index(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }

        return nil
    }

}
