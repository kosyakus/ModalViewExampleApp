//
//  GenerateReportView.swift
//  AppForReelSwiftUI
//
//  Created by Natalia Sinitsyna on 04.10.2024.
//

import SwiftUI

#Preview {
    GenerateReportView()
}

import UIKit

struct GenerateReportView: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var progress: Float = 0.0
    @State private var progressIncrement: Float = 0.05
    @State private var displayLink: Timer? = nil
    @State private var text = "Получаем данные с сервера..."
    
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                // Image at the top
                Image("reviewIcon")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                        .fill(Color.white)
                        .frame(height: 64)
                        .frame(width: UIScreen.main.bounds.width)
                        .padding([.top], -75)
                    )
                    .padding()
                
                ZStack(alignment: .leading) {
                    // Background gradient
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.2)) // Background color of the progress bar
                        .frame(width: UIScreen.main.bounds.width - 64, height: 8)
                    
                    // Foreground gradient for progress
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(gradient:
                                                Gradient(colors: [Color(UIColor(hex: "#5C4EF2")),
                                                                  Color(UIColor(hex: "#1A96FF"))]),
                                             startPoint: .leading,
                                             endPoint: .trailing))
                        .frame(width: (UIScreen.main.bounds.width - 64) * CGFloat(progress), height: 8) // Adjust width based on progress value
                }
                .frame(width: UIScreen.main.bounds.width - 64, height: 8)
                .animation(.linear(duration: 0.5))
                .padding()
                
                // Label
                Text(text)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
            .background(Color.white)
        }
        .onAppear {
            startFakeProgress()
        }
        .background(Color(white: 0, opacity: 0.4))
    }
    
    
    
    // Function to start fake progress
    private func startFakeProgress() {
        displayLink = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.progress < 0.99 {
                self.progress = min(self.progress + self.progressIncrement, 0.99)
                self.updateText()
                self.adjustProgressIncrement()
            } else {
                self.completeProgress()
            }
        }
    }
    
    // Function to update text based on progress
    private func updateText() {
        switch progress {
        case 0.0...0.19:
            text = "Получаем данные с сервера..."
        case 0.2...0.498:
            text = "Обновляем данные с сервера..."
        case 0.5...0.598:
            text = "Нужно ещё немного времени..."
        case 0.599...0.698:
            text = "Скоро загрузится..."
        case 0.699...0.89:
            text = "Ещё чуть-чуть..."
        case 0.899...0.999:
            text = "Уже почти..."
        default:
            text = "Получаем данные с сервера..."
        }
    }
    
    // Function to adjust progress increment as it gets closer to completion
    private func adjustProgressIncrement() {
        switch progress {
        case 0.0...0.19:
            progressIncrement /= 1.0
        case 0.2...0.89:
            progressIncrement /= 1.1
        case 0.9...0.99:
            progressIncrement /= 1.12
        default:
            break
        }
    }
    
    // Function to complete progress quickly once the server responds
    private func completeProgress() {
        displayLink?.invalidate()
        displayLink = nil
        
        // Complete the progress in 1 second
        withAnimation(.linear(duration: 1.0)) {
            progress = 1.0
        }
        
        // Call the delegate function if needed
        // delegate?.progressDone()
    }
    
    // Call this function when you receive the server response
    func serverResponseReceived() {
        completeProgress()
    }
}
