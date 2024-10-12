//
//  GradientButtonView.swift
//  AppForReelSwiftUI
//
//  Created by Natalia Sinitsyna on 12.10.2024.
//

import SwiftUI

struct GradientButtonView: View {
    var title: String
    var action: () -> Void
    var gradientColors: [Color]
    
    // Определяет, показывать ли счетчик или изображение с текстом
    var showCounter: Bool
    var counterText: String?  // Для передачи текста счетчика
    var iconText: String?  // Текст рядом с иконкой

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                
                // Условие: если showCounter == true, показываем счетчик, иначе иконку с текстом
                if showCounter, let counterText = counterText {
                    Text(counterText)
                        .frame(height: 24)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(UIColor(hex: "#FFFFFF").withAlphaComponent(0.7)))
                        .padding(.horizontal, 8)
                        .background(Color(UIColor(hex: "#0D29A7")))
                        .cornerRadius(6)
                } else if let iconText = iconText {
                    HStack(spacing: 4) {
                        Image("numcy28")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text(iconText)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                } else {
                    
                }
            }
            .padding(.horizontal, 16)
            .foregroundColor(.white)
            .frame(height: 32)
            .frame(maxWidth: nil)
            .background(
                LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(8)
        }
    }
}
