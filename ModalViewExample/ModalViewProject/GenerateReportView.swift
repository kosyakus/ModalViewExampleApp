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
        VStack(spacing: 16) {
            
            // Image at the top
            Image("neuroOwlCircledPurpleLogo")
                .resizable()
                .frame(width: 150, height: 150)
            
            
            ZStack(alignment: .leading) {
                // Background gradient
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2)) // Background color of the progress bar
                    .frame(width: UIScreen.main.bounds.width - 64, height: 8)
                
                // Foreground gradient for progress
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red,
                                                                     Color.orange]),
                                         startPoint: .leading,
                                         endPoint: .trailing))
                    .frame(width: (UIScreen.main.bounds.width - 64) * CGFloat(progress), height: 8) // Adjust width based on progress value
            }
            .frame(width: UIScreen.main.bounds.width - 64, height: 8)
            .animation(.linear(duration: 0.5))
            
            // Label
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .onAppear {
            startFakeProgress()
        }
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
            text = "Получаем данные с сервера..."
        case 0.5...0.598:
            text = "Получаем данные с сервера..."
        case 0.599...0.698:
            text = "Получаем данные с сервера..."
        case 0.699...0.89:
            text = "Получаем данные с сервера..."
        case 0.899...0.999:
            text = "Получаем данные с сервера..."
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


//struct GenerateReportView: View {
//    @Environment(\.presentationMode) var presentationMode
//
//    @State private var progress: Double = 0.7 // For example, a 70% progress.
//
//        var body: some View {
//            VStack(spacing: 24) {
//
//                // Image on top
//                Image("neuroOwlCircledPurpleLogo")
//                    .resizable()
//                    .frame(width: 150, height: 150)
//                    .cornerRadius(75)
//                    .padding(.top, 32)
//
//                // Progress bar
//                ProgressView(value: progress)
//                    .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
//                    .frame(height: 8)
//                    .padding(.horizontal, 24)
//                    .background(Color(UIColor.systemGray5)) // For background behind progress
//                    .cornerRadius(4)
//
//                // Label below progress bar
//                Text("В вашу подписку входит 10 бесплатных отчетов в месяц")
//                    .font(.system(size: 14, weight: .medium))
//                    .foregroundColor(Color.blue)
//                    .multilineTextAlignment(.center)
//
//                Spacer()
//            }
//            .background(
//                RoundedRectangle(cornerRadius: 24)
//                    .fill(Color.white)
//                    .shadow(radius: 10)
//            )
//            .padding()
//            .frame(maxWidth: .infinity)
//        }
//}
