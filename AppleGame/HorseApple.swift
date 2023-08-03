//
//  HorseApple.swift
//  AppleGame
//
//  Created by snulife on 2023/07/03.
//

import SwiftUI

struct HorseApple: View {
//    @StateObject var viewModel = HorseAppleViewModel()

    @ObservedObject var viewModel: HorseAppleViewModel

    init(viewModel: HorseAppleViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Image(systemName: "apple.logo")
                .foregroundColor(
                    viewModel.isDeleted ?
                        .clear
                    :
                        .red
                )
                .opacity(0.9)
                .font(.system(size: 30))
            Text("\(viewModel.num)")
                .foregroundColor(
                    viewModel.isDeleted ?
                        .clear
                    :
                        .white
                )
                .font(.system(size: 15))
                .padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
        }
        .background(
            viewModel.isSelected && !viewModel.isDeleted ?
                    (Circle()
                        .fill(.cyan)
                        .frame(width: 50)
                        .opacity(0.7))
                    : (Circle()
                        .fill(.clear)
                        .frame(width: 50)
                        .opacity(0.7))
            )
    }
}
    struct HorseApple_Previews: PreviewProvider {
        static var previews: some View {
            HorseApple(viewModel: HorseAppleViewModel(num: 3, x: 0, y: 0))
        }
}
