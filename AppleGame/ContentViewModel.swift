//
//  ContentViewModel.swift
//  AppleGame
//
//  Created by snulife on 2023/07/10.
//

import SwiftUI

class ContentViewModel: ObservableObject{
    
    @Published var draggedCGsize = CGSize.zero
    @Published var movingPoint = CGPoint.zero
    @Published var endPoint = CGPoint.zero
    @Published var applesNumbers: [[Int]]
    @Published var score: Int = 0

    var applesLocation: [[CGPoint]] = Array(repeating: Array(repeating: CGPoint(x: 0, y: 0), count: 9), count: 18)
    var applesSelectedOrNot: [[Bool]] =  Array(repeating: Array(repeating: false, count: 9), count: 18)
    var applesClearedOrNot: [[Bool]] =  Array(repeating: Array(repeating: false, count: 9), count: 18)
   

    var dragRectangleWidth: CGFloat { draggedCGsize.width.magnitude }
    var dragRectangleHeight: CGFloat { draggedCGsize.height.magnitude }
    
    var dragRectanglePositionX: CGFloat { movingPoint.x - draggedCGsize.width/2 }
    var dragRectanglePositionY: CGFloat { movingPoint.y - draggedCGsize.height/2 }

    
    init(draggedCGsize: CoreFoundation.CGSize = CGSize.zero, movingPoint: CoreFoundation.CGPoint = CGPoint.zero, endPoint: CoreFoundation.CGPoint = CGPoint.zero) {
        self.draggedCGsize = draggedCGsize
        self.movingPoint = movingPoint
        self.endPoint = endPoint
        
        var initialArray: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 18)
        for i in 0..<18{
            for j in 0..<9{
                initialArray[i][j] = Int.random(in: 1 ... 9)
            }
        }
        self.applesNumbers = initialArray
    }
    
    func whileDraging(gesture: DragGesture.Value, myapples: [[HorseApple]]) {
        movingPoint = gesture.location
        draggedCGsize.width = gesture.translation.width
        draggedCGsize.height = gesture.translation.height

        selectingApples()
    }
    
    func endDraging(gesture: DragGesture.Value, myapples: [[HorseApple]]){
        unSelectingApples()
        endPoint = gesture.location
        draggedCGsize = CGSize(width: CGFloat(0), height: CGFloat(0))
    
    }
    
    
    func setAppleLocation(x: Int, y: Int, location: CGPoint) {
        applesLocation[x][y] = location
        }
    
    
    func selectingApples(){
        for x in 0..<18{
            for y in 0..<9{
                if checkSelectedApples(apple_x: applesLocation[x][y].x, apple_y: applesLocation[x][y].y){
                    if(applesSelectedOrNot[x][y] == false){
                        applesSelectedOrNot[x][y] = true
                    }
                }else{
                    applesSelectedOrNot[x][y] = false
                }
            }
        }
    }
    
    func unSelectingApples(){
        for x in 0..<18{
            for y in 0..<9{
                applesSelectedOrNot[x][y] = false
            }
        }
    }
    
    func countedSelectedNumber(apples: [[HorseApple]]) -> Int{
        var myNumber = 0
        for i in 0..<18{
            for j in 0..<9{
                if !apples[i][j].viewModel.isDeleted && apples[i][j].viewModel.isSelected {
                    myNumber += apples[i][j].num
                }
            }
        }
        return myNumber
    }
    
   
    func deletingApples(apples: [[HorseApple]]){
        for i in 0..<18{
            for j in 0..<9{
                if apples[i][j].viewModel.isSelected && !apples[i][j].viewModel.isDeleted {
                    applesClearedOrNot[i][j] = true
                    addingScore()
                }
            }
        }
    }
    
    func addingScore(){
        score += 1
    }
    
    
    func checkSelectedApples(apple_x: CGFloat , apple_y: CGFloat) -> Bool{
        var formal_x: CGFloat {
            movingPoint.x - draggedCGsize.width < movingPoint.x ?
            movingPoint.x - draggedCGsize.width:
            movingPoint.x
        }
        var later_x: CGFloat {
            movingPoint.x - draggedCGsize.width > movingPoint.x ?
            movingPoint.x - draggedCGsize.width:
            movingPoint.x
        }
        var formal_y: CGFloat {
            movingPoint.y - draggedCGsize.height < movingPoint.y ?
            movingPoint.y - draggedCGsize.height:
            movingPoint.y
        }
        var later_y: CGFloat {
            movingPoint.y - draggedCGsize.height > movingPoint.y ?
            movingPoint.y - draggedCGsize.height:
            movingPoint.y
        }

        if formal_x <= apple_x && apple_x <= later_x
            && formal_y <= apple_y && apple_y <= later_y{
            return true
        }
        return false
    }
    
    
}
