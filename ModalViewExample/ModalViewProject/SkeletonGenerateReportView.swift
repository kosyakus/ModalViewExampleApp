//
//  SkeletonGenerateReportView.swift
//  ModalViewExample
//
//  Created by Natalia Sinitsyna on 09.11.2024.
//

import SwiftUI

struct SkeletonGenerateReportView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                // Top section
                setUpTopView()
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    SkeletonLoadingView(width: 350,
                                        shape: RoundedRectangle(cornerRadius: 8),
                                        animation: .easeIn(duration: 1).repeatForever(autoreverses: true),
                                        gradient: Gradient(colors: [Color(UIColor(hex: "#0059C1").withAlphaComponent(0.2)), Color(UIColor(hex: "#6100FF").withAlphaComponent(0.2))]))
                    SkeletonLoadingView(width: 380,
                                        shape: RoundedRectangle(cornerRadius: 8),
                                        animation: .easeIn(duration: 1).repeatForever(autoreverses: true),
                                        gradient: Gradient(colors: [Color(UIColor(hex: "#0059C1").withAlphaComponent(0.2)), Color(UIColor(hex: "#6100FF").withAlphaComponent(0.2))]))
                    SkeletonLoadingView(width: 350,
                                        shape: RoundedRectangle(cornerRadius: 8),
                                        animation: .easeIn(duration: 1).repeatForever(autoreverses: true),
                                        gradient: Gradient(colors: [Color(UIColor(hex: "#0059C1").withAlphaComponent(0.2)), Color(UIColor(hex: "#6100FF").withAlphaComponent(0.2))]))
                    SkeletonLoadingView(width: 180,
                                        shape: RoundedRectangle(cornerRadius: 8),
                                        animation: .easeIn(duration: 1).repeatForever(autoreverses: true),
                                        gradient: Gradient(colors: [Color(UIColor(hex: "#0059C1").withAlphaComponent(0.2)), Color(UIColor(hex: "#6100FF").withAlphaComponent(0.2))]))
                }
                
                // Button section
                setUpLikeShareButtons()
                
                // Separator
                Divider()
                
                // Bottom section
                HStack {
                    setupLimitButtonsView()
                    Spacer()
                    // Two buttons with counter
                    setupNextPreviousButtonsView()
                }
                .padding(.top, 16)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .bottom)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "#ECEBFF")),
                                                           Color(UIColor(hex: "#EBF5FF"))]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
        }
        .background(Color(white: 0, opacity: 0.4))
        
        .onTapGesture {
            // Dismiss the view when tapped anywhere on the content
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func setUpTopView() -> some View {
        return HStack {
            Image("reviewIcon")
                .resizable()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text("Название функции")
                    .font(.headline)
                    .foregroundColor(Color(UIColor(hex: "#1027F2")))
                    .font(.system(size: 14, weight: .bold))
                
                Text("Короткое описание функции")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 12, weight: .regular))
            }
            .padding(.leading, 8)
            
            Spacer()
            
            setUpDeleteAndQuestionView()
        }
        .padding(.bottom, 16)
        .background(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
            .fill(Color(UIColor(hex: "#ECEBFF")))
            .frame(height: 64)
            .frame(width: UIScreen.main.bounds.width)
            .padding([.top], -64)
        )
    }
    
    private func setUpDeleteAndQuestionView() -> some View {
        return HStack(spacing: 16) {
            Button(action: {
                // Action for trash
            }) {
                Image("trashTemplate")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(UIColor(hex: "#1027F2").withAlphaComponent(0.3)))
                    .frame(width: 16, height: 16)
            }
            .frame(width: 24, height: 24)
            .background(Color(UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
            .cornerRadius(30)
            
            Button(action: {
                // Action for info
            }) {
                Image("pictoIconQuestionMark")
                    .resizable()
                    .foregroundColor(Color(UIColor(hex: "#1027F2").withAlphaComponent(0.3)))
                    .frame(width: 16, height: 16)
            }
            
            .frame(width: 24, height: 24)
            .background(Color(UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
            .cornerRadius(16)
        }
    }
    
    private func setUpLikeShareButtons() -> some View {
        return HStack(spacing: 16) {
            // Three buttons on the left
            HStack {
                Button(action: {
                   
                }) {
                    HStack {
                        Image("heartIcon")
                            .foregroundColor(Color(UIColor(hex: "#1027F2").withAlphaComponent(0.3)))
                        Text("Полезный")
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(1)
                            .foregroundColor(Color(UIColor(hex: "#1027F2").withAlphaComponent(0.3)))
                    }
                    .frame(height: 16)
                    .padding(8)
                    .background(
                        Color(UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
                }
                .frame(height: 24)
                .cornerRadius(30)
                
                Button(action: {
                    
                }) {
                    HStack {
                        Image("heartBrokenIcon")
                            .foregroundColor(Color(UIColor(hex: "#1027F2").withAlphaComponent(0.3)))
                        Text("Бесполезный ")
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(1)
                            .foregroundColor(Color(UIColor(hex: "#1027F2").withAlphaComponent(0.3)))
                    }
                    .frame(height: 16)
                    .padding(8)
                    .background(Color(UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
                }
                .frame(height: 24)
                .cornerRadius(30)
                
                Button(action: {
                    
                }) {
                    HStack {
                        Image("warningTriangle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(UIColor(hex: "#1027F2").withAlphaComponent(0.3)))
                        Text("Жалоба")
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(1)
                            .foregroundColor(Color(UIColor(hex: "#1027F2").withAlphaComponent(0.3)))
                    }
                    .frame(height: 16)
                    .padding(8)
                    .background(Color(UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
                }
                .frame(height: 24)
                .cornerRadius(30)
            }
            
            Spacer()
            
            // Share button on the right
            Button(action: {
                
            }) {
                Image("pictoIconShareDots")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color(UIColor(hex: "#1027F2").withAlphaComponent(0.3)))
            }
            .frame(width: 24, height: 24)
            .background(Color(UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
            .cornerRadius(30)
        }
        .padding(.vertical, 16)
    }
    
    private func setupNextPreviousButtonsView() -> some View {
        // Вычислить нужно ли показывать дополнительный блок кнопок вперед/назад
        
            return AnyView(HStack {
                                
                Button(action: {
                    
                }) {
                    Image("pictoIconArrowRight")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color(UIColor(hex: "#59748C").withAlphaComponent(0.5)))
                }
                .frame(width: 32, height: 32)
                .background(Color(UIColor(hex: "#0038FF").withAlphaComponent(0.05)))
                .cornerRadius(16)
                .disabled(true)
                
                Text("---")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.horizontal, 2)
                    .foregroundStyle(Color(UIColor.black.withAlphaComponent(0.3)))
                
                Button(action: {
                    
                }) {
                    Image("pictoIconArrowLeft")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color(UIColor(hex: "#59748C").withAlphaComponent(0.5)))
                }
                .frame(width: 32, height: 32)
                .background(Color(UIColor(hex: "#0038FF").withAlphaComponent(0.05)))
                .cornerRadius(16)
                .disabled(true)
            }
                .frame(alignment: .trailing))
    }
    
    private func setupLimitButtonsView() -> some View {
        return AnyView(GradientButtonView(
            title: "Получить описание",
            action: {
            },
            gradientColors: [
                Color(UIColor(hex: "#4B7EFF").withAlphaComponent(0.3)),
                Color(UIColor(hex: "#5D4FF3").withAlphaComponent(0.3))
            ], showCounter: false
        ))
    }
}

#Preview {
    SkeletonGenerateReportView()
}
