//
//  ContentViewModel.swift
//  AppleGame
//
//  Created by snulife on 2023/07/10.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published private(set) var draggedCGsize = CGSize.zero
    @Published private(set) var movingPoint = CGPoint.zero
    @Published private(set) var endPoint = CGPoint.zero
    @Published private(set) var score = 0

    let columns = 18
    let rows = 9
    let maxNum = 9
    private(set) lazy var appleViewModels: [[HorseAppleViewModel]] = (0..<columns).map { i in
        (0..<rows).map { j in
            HorseAppleViewModel(num: .random(in: 1...maxNum), x: i, y: j)
        }
    }

    private lazy var applesLocation: [[CGPoint]] =
    Array(repeating: Array(repeating: .zero, count: rows), count: columns)

    var dragRectangleWidth: CGFloat { draggedCGsize.width.magnitude }
    var dragRectangleHeight: CGFloat { draggedCGsize.height.magnitude }

    var dragRectanglePositionX: CGFloat { movingPoint.x - draggedCGsize.width / 2 }
    var dragRectanglePositionY: CGFloat { movingPoint.y - draggedCGsize.height / 2 }

    init(draggedCGsize: CGSize = .zero, movingPoint: CGPoint = .zero, endPoint: CGPoint = .zero) {
        self.draggedCGsize = draggedCGsize
        self.movingPoint = movingPoint
        self.endPoint = endPoint
    }

    func whileDraging(gesture: DragGesture.Value) {
        movingPoint = gesture.location
        draggedCGsize = gesture.translation
        selectingApples()
    }

    func endDraging(gesture: DragGesture.Value) {
        unSelectingApples()
        endPoint = gesture.location
        draggedCGsize = .zero
    }

    func setAppleLocation(i: Int, j: Int, location: CGPoint) {
        applesLocation[i][j] = location
    }

    private func selectingApples() {
        // Avoid direct indexing
        // Be consistent with x vs i -> perhaps stick with i for index and x for CGPoint
        for (i, row) in appleViewModels.enumerated() {
            for (j, apple) in row.enumerated() {
                apple.isSelected = checkSelectedApples(
                    x: applesLocation[i][j].x,
                    y: applesLocation[i][j].y
                )
            }
        }
    }

    private func unSelectingApples() {
        for row in appleViewModels {
            for apple in row {
                apple.isSelected = false
            }
        }
    }

    func countedSelectedNumber() -> Int {
        appleViewModels.reduce(0) { partialResult, row in
            row.reduce(partialResult) { partialResult, apple in
                if !apple.isDeleted && apple.isSelected {
                    return partialResult + apple.num
                } else {
                    return partialResult
                }
            }
        }
    }

    func deletingApples() {
        for row in appleViewModels {
            for apple in row {
                if apple.isSelected && !apple.isDeleted {
                    apple.isDeleted = true
                    addingScore()
                }
            }
        }
    }

    private func addingScore() {
        score += 1
    }

    private func checkSelectedApples(x: CGFloat, y: CGFloat) -> Bool {
        let formalX = (
            movingPoint.x - draggedCGsize.width < movingPoint.x ?
            movingPoint.x - draggedCGsize.width : movingPoint.x
        )
        let laterX = (
            movingPoint.x - draggedCGsize.width > movingPoint.x ?
            movingPoint.x - draggedCGsize.width : movingPoint.x
        )
        let formalY = (
            movingPoint.y - draggedCGsize.height < movingPoint.y ?
            movingPoint.y - draggedCGsize.height : movingPoint.y
        )
        let laterY = (
            movingPoint.y - draggedCGsize.height > movingPoint.y ?
            movingPoint.y - draggedCGsize.height : movingPoint.y
        )
        return formalX <= x && x <= laterX && formalY <= y && y <= laterY
    }
}
