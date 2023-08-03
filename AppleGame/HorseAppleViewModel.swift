//
//  HorseAppleViewModel.swift
//  AppleGame
//
//  Created by snulife on 2023/07/11.
//

import SwiftUI

class HorseAppleViewModel: ObservableObject{
    
    @Published var isSelected = false
    @Published var isDeleted = false
   
    init(isSelected: Bool = false, isDeleted: Bool = false){
        self.isSelected = isSelected
        self.isDeleted = isDeleted
    }
}

