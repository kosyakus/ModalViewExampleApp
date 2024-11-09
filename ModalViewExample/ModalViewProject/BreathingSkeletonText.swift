//
//  BreathingSkeletonText.swift
//  ModalViewExample
//
//  Created by Natalia Sinitsyna on 09.11.2024.
//

import SwiftUI

struct BreathingSkeletonText: View {
    @State private var isAnimating = false
    var width: CGFloat = 100
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(UIColor(hex: "#0059C1").withAlphaComponent(0.2)),
                        Color(UIColor(hex: "#6100FF").withAlphaComponent(0.2))
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: width, height: 14)
            .opacity(isAnimating ? 0.6 : 1.0) // Изменение прозрачности для эффекта дыхания
            .onAppear {
                withAnimation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true)
                ) {
                    isAnimating.toggle()
                }
            }
    }
}

#Preview {
    BreathingSkeletonText()
}

// How to use
//                VStack(alignment: .leading, spacing: 8) {
//                    BreathingSkeletonText(width: 354)
//                    BreathingSkeletonText(width: 384)
//                    BreathingSkeletonText(width: 354)
//                    BreathingSkeletonText(width: 180)
//                }
