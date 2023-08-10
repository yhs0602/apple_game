//
//  TimerView.swift
//  AppleGame
//
//  Created by 양현서 on 2023/08/10.
//

import SwiftUI

struct TimerView: View {
    let totalTime: Duration
    let remainingTime: Duration

    let backgroundColor = Color(uiColor: .secondarySystemBackground)
    let foregroundColors: [Color] = [.red, .orange, .yellow, .green]

    private var ratio: Double {
        remainingTime / totalTime
    }

    private var currentForegroundColor: Color {
        let numberOfColors = foregroundColors.count
        // fatalError : 이걸 만나면 무조건 죽음. 진짜 중요한 에러
        // preconditionError / precondition : bool pred을 받아서 체크함 prod에서도 남아있음. 별도로 빼지 않는 한
        // assertionFailure / assert : precondtion과 같지만 느낌이 다름:
        // assertionFailue: product/archive할 때 없는셈쳐진다
        // exception: do-try-catch
        // result type
//        assert (numberOfColors > 0)
//        if numberOfColors == 0 {
//            return .green
//        }
        guard numberOfColors > 0 else {
            assertionFailure("There should be more than one colors in foregroundColor") // production에서는 없는셈 치고 green 리턴
            return .green
        }
        let index = min(Int(Double(numberOfColors) * ratio), numberOfColors - 1)
        assert((0...numberOfColors).contains(index))
        return foregroundColors[index]
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                Capsule()
                    .foregroundColor(
                    backgroundColor
                )
                Capsule()
                    .frame(height: geo.size.height * ratio)
                    .foregroundColor(currentForegroundColor)
                    .animation(.easeIn, value: ratio)
                    .animation(.default, value: currentForegroundColor)
                    .padding(geo.size.width * 0.08)
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
//    static private var timer = Timer.publish(every: 1, on: .main, in: .main)

    static var previews: some View {
        TimerView(
            totalTime: .seconds(120), remainingTime: .seconds(100)
        ).frame(width: 50)
        TimerView(
            totalTime: .seconds(120), remainingTime: .seconds(90)
        ).frame(width: 50)
        TimerView(
            totalTime: .seconds(120), remainingTime: .seconds(70)
        ).frame(width: 50)
        TimerView(
            totalTime: .seconds(120), remainingTime: .seconds(30)
        ).frame(width: 50)
        TimerView(
            totalTime: .seconds(120), remainingTime: .seconds(10)
        ).frame(width: 50)
    }
}
