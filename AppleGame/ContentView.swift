//
//  ContentView.swift
//  AppleGame
//
//  Created by snulife on 2023/07/03.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var applePie: some View {
        HStack {
            ForEach(0..<18) { i in
                VStack {
                    ForEach(0..<9) { j in
                        // reification
                        GeometryReader { geometry in
                            let globalFrame = geometry.frame(in: .named("game"))
                            HorseApple(viewModel: viewModel.appleViewModels[i][j])
                                .onAppear {
                                viewModel.setAppleLocation(
                                    i: i,
                                    j: j,
                                    location: CGPoint(x: globalFrame.midX, y: globalFrame.midY)
                                )
                                }
                        }
                    }
                }
                    .frame(height: 340)
            }
        }
            .frame(width: 560)
    }

    var body: some View {
        ZStack {
            applePie
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .gesture(drag)

            Rectangle()
                .stroke(Color.cyan, lineWidth: 3)
                .frame(width: viewModel.dragRectangleWidth, height: viewModel.dragRectangleHeight)
                .opacity(0.7)
                .position(x: viewModel.dragRectanglePositionX, y: viewModel.dragRectanglePositionY)

            HStack {
                Spacer()
                    .frame(width: 700)
                Rectangle()
                    .frame(width: 20, height: 300)
                VStack {
                    Text("score: \(viewModel.score)")
                    Image(systemName: "house")
                    Image(systemName: "arrowshape.turn.up.backward")
                }
                Spacer()
                    .frame(width: 30)
            }
        }
            .coordinateSpace(name: "game")
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
    }

    @State private var selectedNums = 0

    var drag: some Gesture {
        DragGesture(coordinateSpace: .named("game"))
            .onChanged {
            viewModel.whileDraging(gesture: $0)
            selectedNums = viewModel.countedSelectedNumber()
            }
            .onEnded {
            if selectedNums == 10 {
                viewModel.deletingApples()
            }
            viewModel.endDraging(gesture: $0)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
