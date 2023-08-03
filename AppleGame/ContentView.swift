//
//  ContentView.swift
//  AppleGame
//
//  Created by snulife on 2023/07/03.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    
    var myapples: [[HorseApple]] {
        var thisisuselessarray: [[HorseApple]] = []
        for i in 0..<18 {
            var imuselessarray: [HorseApple] = []
            for j in 0..<9 {
                imuselessarray.append(HorseApple(num: viewModel.applesNumbers[i][j], x: i, y: j, viewModel: HorseAppleViewModel(
                    isSelected: viewModel.applesSelectedOrNot[i][j],
                    isDeleted: viewModel.applesClearedOrNot[i][j]
                              )))
            }
            thisisuselessarray.append(imuselessarray)
        }
        return thisisuselessarray
    }
       
    
    var applePie: some View {
        HStack{
            ForEach(0..<18) { x in
                VStack{
                    ForEach(0..<9) { y in
                        GeometryReader{ geometry in
                            let globalFrame = geometry.frame(in: .global)
                            myapples[x][y]
                                .onAppear{
                                    viewModel.setAppleLocation(x: x, y: y, location: CGPoint(x: globalFrame.midX, y: globalFrame.midY))
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
        HStack{
            ZStack {
                applePie
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .gesture(drag)
                
                Rectangle()
                    .stroke(Color.cyan, lineWidth: 3)
                    .frame(width: viewModel.dragRectangleWidth, height: viewModel.dragRectangleHeight)
                    .opacity(0.7)
                    .position(x: viewModel.dragRectanglePositionX, y: viewModel.dragRectanglePositionY)
                
                HStack{
                    Spacer()
                        .frame(width: 700)
                    Rectangle()
                        .frame(width: 20, height: 300)
                    VStack{
                        Text("score: \(viewModel.score)")
                        Image(systemName: "house")
                        Image(systemName: "arrowshape.turn.up.backward")
                        
                    }
                    Spacer()
                        .frame(width: 30)
                      
                }
            }
            
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
    
    var drag: some Gesture {
        var selectedNums = 0
        
        return DragGesture()
            .onChanged { [self] gesture in
                viewModel.whileDraging(gesture: gesture, myapples: myapples)
                
                selectedNums = viewModel.countedSelectedNumber(apples: myapples)  
            }
            .onEnded { [self] gesture in
                if selectedNums == 10 {
                    viewModel.deletingApples(apples: myapples)
                }
                
                viewModel.endDraging(gesture: gesture, myapples: myapples)
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
