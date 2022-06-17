//
//  Array+Unique.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 16/06/2022.
//

import Foundation

extension Array where Element: Hashable {
     var unique: [Element] {
           var uniqueValues: [Element] = []
           forEach { item in
               if !uniqueValues.contains(item) {
                   uniqueValues += [item]
               }
           }
           return uniqueValues
       }
}
