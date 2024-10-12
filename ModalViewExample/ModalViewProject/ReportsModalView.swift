//
//  ReportsModalView.swift
//  AppForReelSwiftUI
//
//  Created by Natalia Sinitsyna on 12.10.2024.
//

import SwiftUI

struct ReportsModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var limitAction: (() -> Void)?
    var deleteAction: (() -> Void)?
    var questionAction: (() -> Void)?
    var likeAction: (() -> Void)?
    var dislikeAction: (() -> Void)?
    var sharedAction: (() -> Void)?
    var reviewAction: (() -> Void)?
    var onDismiss: (() -> Void)?
    
    @State var currentItem: Int
    @ObservedObject var report: ReportsObjectModel
    
    @State private var isPositive: Bool? = nil
    
    init(
        limitAction: (() -> Void)?,
        deleteAction: (() -> Void)?,
        questionAction: (() -> Void)?,
        likeAction: (() -> Void)?,
        dislikeAction: (() -> Void)?,
        sharedAction: (() -> Void)?,
        reviewAction: (() -> Void)?,
        currentItem: Int,
        report: ReportsObjectModel,
        onDismiss: (() -> Void)? = nil
    ) {
        self.limitAction = limitAction
        self.deleteAction = deleteAction
        self.questionAction = questionAction
        self.likeAction = likeAction
        self.dislikeAction = dislikeAction
        self.sharedAction = sharedAction
        self.reviewAction = reviewAction
        _currentItem = State(initialValue: currentItem)
        self.report = report
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                // Top section
                setUpTopView()
                
                // Description
                if let data = report.data, !data.isEmpty, currentItem < data.count {
                    Text(data[currentItem].answer ?? "Ошибка получения отчета")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(UIColor(hex: "#40455E")))
                } else {
                    EmptyView() // Скрываем контент
                        .onAppear {
                            // Закрываем модальное окно
                            presentationMode.wrappedValue.dismiss()
                        }
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
        .onDisappear {
            onDismiss?()
        }
        .onChange(of: report.data ?? []) { _, newValue in
            if report.data?.isEmpty == true {
                self.presentationMode.wrappedValue.dismiss()
                onDismiss?()
            }
        }
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
                deleteAction?()
            }) {
                Image("trashTemplate")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(UIColor(hex: "#1027F2")))
                    .frame(width: 16, height: 16)
            }
            .frame(width: 24, height: 24)
            .background(Color(UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
            .cornerRadius(30)
            
            Button(action: {
                // Action for info
                questionAction?()
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("pictoIconQuestionMark")
                    .resizable()
                    .foregroundColor(Color(UIColor(hex: "#1027F2")))
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
                    likeAction?()
                    isPositive = true
                }) {
                    HStack {
                        Image("heartIcon")
                            .foregroundColor(Color(isPositive == true ? UIColor.red : UIColor(hex: "#1027F2")))
                        Text("Полезный")
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(1)
                            .foregroundColor(Color(isPositive == true ? UIColor.red : UIColor(hex: "#1027F2")))
                    }
                    .frame(height: 16)
                    .padding(8)
                    .background(
                        Color(isPositive == true ? UIColor(hex: "#FFE4E7") : UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
                }
                .frame(height: 24)
                .cornerRadius(30)
                
                Button(action: {
                    dislikeAction?()
                    isPositive = false
                }) {
                    HStack {
                        Image("heartBrokenIcon")
                            .foregroundColor(Color(isPositive == false ? UIColor(hex: "#7F1BFF") : UIColor(hex: "#1027F2")))
                        Text("Бесполезный ")
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(1)
                            .foregroundColor(Color(isPositive == false ? UIColor(hex: "#7F1BFF") : UIColor(hex: "#1027F2")))
                    }
                    .frame(height: 16)
                    .padding(8)
                    .background(Color(isPositive == false ? UIColor(hex: "#7F1BFF").withAlphaComponent(0.1) : UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
                }
                .frame(height: 24)
                .cornerRadius(30)
                
                Button(action: {
                    reviewAction?()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image("warningTriangle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(UIColor(hex: "#1027F2")))
                        Text("Жалоба")
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(1)
                            .foregroundColor(Color(UIColor(hex: "#1027F2")))
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
                sharedAction?()
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("pictoIconShareDots")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color(UIColor(hex: "#1027F2")))
            }
            .frame(width: 24, height: 24)
            .background(Color(UIColor(hex: "#0038FF").withAlphaComponent(0.1)))
            .cornerRadius(30)
        }
        .padding(.vertical, 16)
    }
    
    private func setupNextPreviousButtonsView() -> some View {
        // Вычислить нужно ли показывать дополнительный блок кнопок вперед/назад
        let needShowArrowButtons: Bool = report.data?.count ?? 0 > 1
        
        if needShowArrowButtons {
            return AnyView(HStack {
                
                // Получаем информацию о том, активны ли кнопки вперед/назад
                let buttonVisibility = determineButtonVisibility(currentItem: currentItem + 1, totalItems: report.data?.count ?? 0)
                
                Button(action: {
                    if (currentItem - 1) < (report.data?.count ?? 0) && (currentItem - 1) >= 0 {
                        currentItem -= 1
                        print("actionPrevious tapped")
                    }
                    
                }) {
                    Image("pictoIconArrowRight")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .padding(.horizontal, 8)
                        .foregroundColor(buttonVisibility.leadingButtonView ? Color(UIColor(hex: "#1027F2")) : Color(UIColor(hex: "#59748C").withAlphaComponent(0.5)))
                }
                .frame(width: 32, height: 32)
                .background(buttonVisibility.leadingButtonView ? Color(UIColor(hex: "#1027F2").withAlphaComponent(0.1)) : Color(UIColor(hex: "#0038FF").withAlphaComponent(0.05)))
                .cornerRadius(16)
                .disabled(!buttonVisibility.leadingButtonView)
                
                Text("\(currentItem + 1) / \(report.data?.count ?? 0)")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.horizontal, 2)
                
                Button(action: {
                    if currentItem + 1 < report.data?.count ?? 0 {
                        currentItem += 1
                        print("actionNext tapped")
                    }
                }) {
                    Image("pictoIconArrowLeft")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .padding(.horizontal, 8)
                        .foregroundColor(buttonVisibility.trailingButtonView ? Color(UIColor(hex: "#1027F2")) : Color(UIColor(hex: "#59748C").withAlphaComponent(0.5)))
                }
                .frame(width: 32, height: 32)
                .background(buttonVisibility.trailingButtonView ? Color(UIColor(hex: "#1027F2").withAlphaComponent(0.1)) : Color(UIColor(hex: "#0038FF").withAlphaComponent(0.05)))
                .cornerRadius(16)
                .disabled(!buttonVisibility.trailingButtonView)
            }
                .frame(alignment: .trailing))
        }
        else {
            return AnyView(EmptyView())
        }
    }
    
    private func determineButtonVisibility(currentItem: Int, totalItems: Int) -> (leadingButtonView: Bool, trailingButtonView: Bool) {
        let leadingButtonView = currentItem > 1
        let trailingButtonView = currentItem < totalItems
        return (leadingButtonView, trailingButtonView)
    }
    
    private func setupLimitButtonsView() -> some View {
        return AnyView(GradientButtonView(
            title: "Сохранить",
            action: {
                limitAction?()
                presentationMode.wrappedValue.dismiss()
            },
            gradientColors: [
                Color(UIColor(hex: "#4B7EFF")),
                Color(UIColor(hex: "#5D4FF3"))
            ], showCounter: false
        ))
    }
}
