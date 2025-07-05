//
//  CaseIterable.swift
//  QuadraSwiftData
//
//  Created by Tatyana Balashenko on 20/05/2025.
//

import Foundation

extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.endIndex : next]
    }
}
