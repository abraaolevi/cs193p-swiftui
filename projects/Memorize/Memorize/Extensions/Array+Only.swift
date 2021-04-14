//
//  Array+Only.swift
//  Memorize
//
//  Created by Abraao Levi on 03/04/21.
//

import Foundation

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
    
}
