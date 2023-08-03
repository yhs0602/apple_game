//
//  HorseAppleViewModel.swift
//  AppleGame
//
//  Created by snulife on 2023/07/11.
//

import SwiftUI

final class HorseAppleViewModel: ObservableObject {
    @Published var isSelected: Bool
    @Published var isDeleted: Bool

    let num: Int
    let x: Int
    let y: Int

    init(num: Int, x: Int, y: Int, isSelected: Bool = false, isDeleted: Bool = false) {
        self.num = num
        self.x = x
        self.y = y
        self.isSelected = isSelected
        self.isDeleted = isDeleted
    }
}
