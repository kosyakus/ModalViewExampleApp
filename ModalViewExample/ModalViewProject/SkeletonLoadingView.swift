//
//  SkeletonLoadingView.swift
//  ModalViewExample
//
//  Created by Natalia Sinitsyna on 09.11.2024.
//

import SwiftUI

struct SkeletonLoadingView<ShapeType: Shape>: View {
    
    @State private var animationPosition: CGFloat = -1
    var width: CGFloat = 100
    var height: CGFloat = 14
    
    let shape: ShapeType
    let animation: Animation
    let gradient: Gradient
    
    var body: some View {
        shape
            .fill(self.gradientFill())
            .frame(width: width, height: height)
            .onAppear {
                withAnimation(animation) {
                    animationPosition = 2
                }
            }
    }
    
    private func gradientFill() -> LinearGradient {
        return LinearGradient(gradient: gradient,
                              startPoint: .init(x: animationPosition - 1, y: animationPosition - 1),
                              endPoint: .init(x: animationPosition + 1, y: animationPosition + 1))
    }
}

#Preview {
    SkeletonLoadingView(shape: Rectangle(), animation: .easeIn(duration: 3).repeatForever(), gradient: Gradient(colors: [
Color(UIColor(hex: "#0059C1").withAlphaComponent(0.2)),
Color(UIColor(hex: "#6100FF").withAlphaComponent(0.2))
]))
}
