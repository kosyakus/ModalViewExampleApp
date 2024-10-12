//
//  ShowReportViewController.swift
//  AppForReelSwiftUI
//
//  Created by Natalia Sinitsyna on 12.10.2024.
//

import UIKit
import SwiftUI

class ShowReportViewController: UIViewController {
    
    var report = ReportsObjectModel()
    var currentItem = 0
    
    let text1 = "Алан Тьюринг — первооткрыватель искусственного интеллекта, предложивший концепцию универсальной вычислительной машины (машины Тьюринга).   В 1950 году он разработал тест Тьюринга, чтобы определить, может ли машина мыслить, имитируя человеческий интеллект. Его идеи заложили фундамент для современных вычислительных систем и ИИ.   Тьюринг сыграл ключевую роль в расшифровке немецких кодов во Второй мировой войне, что также повлияло на развитие компьютерных технологий."
    
    let text2 = "Эрвин Шрёдингер — австрийский физик-теоретик, один из создателей квантовой механики. Лауреат Нобелевской премии по физике (1933). Член Австрийской академии наук (1956)[5], а также ряда академий наук мира, в том числе иностранный член Академии наук СССР.   Шрёдингеру принадлежит ряд фундаментальных результатов в области квантовой теории, которые легли в основу волновой механики: он сформулировал волновые уравнения (стационарное и зависящее от времени уравнения Шрёдингера), показал тождественность развитого им формализма и матричной механики, разработал волновомеханическую теорию возмущений, получил решения ряда конкретных задач.   Шрёдингер предложил оригинальную трактовку физического смысла волновой функции; в последующие годы неоднократно подвергал критике общепринятую копенгагенскую интерпретацию квантовой механики (парадокс «кота Шрёдингера» и прочее)."
    
    let text3 = "Николай Владимирович Тимофеев-Ресовский —  советский биолог, генетик. Основные направления исследований: радиационная генетика, популяционная генетика, проблемы микроэволюции.   Научно-исследовательская деятельность Тимофеева-Ресовского в предвоенной Германии внесла фундаментальный вклад в создание радиобиологии и радиоэкологии[11][17]. Здесь он открыл и обосновал фундаментальные положения современной генетики развития и популяционной генетики. Он также принял участие в создании основ современной радиационной генетики."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addReports()
//        view.backgroundColor = UIColor(hex: "#1027F2").withAlphaComponent(0.2)
        addButton()
    }
    
    private func addReports() {
        let reports = [text1, text2, text3]
        if report.data == nil {
            report.data = []
        }
        
        // Create a new instance of GeneratedReport
        for item in reports {
            let newReport = GeneratedReport()
            newReport.id = UUID().uuidString
            newReport.answer = item
            newReport.purchased = false
            newReport.like = false
            
            // Append the new report to the data array
            report.data?.append(newReport)
        }
    }
    
    private func addButton() {
        // Создание кнопки
        let button = UIButton(type: .system)
        button.setTitle("Получить описание", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal) // Цвет текста
        button.backgroundColor = .systemBlue // Цвет фона кнопки
        button.layer.cornerRadius = 10 // Скругленные углы
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            button.heightAnchor.constraint(equalToConstant: 56),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func buttonTapped() {
        print("Кнопка нажата")
        let swiftUIView = ReportsModalView(limitAction: limitButtonTapped(),
                                           deleteAction: deleteReportButtonTapped(),
                                           questionAction: showQuestionView(),
                                           likeAction: positiveButtonTapped(),
                                           dislikeAction: negativeButtonTapped(),
                                           sharedAction: shareReportButtonTapped(),
                                           reviewAction: reviewReportButtonTapped(),
                                           currentItem: currentItem,
                                           report: report)
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.backgroundColor = .clear
        hostingController.modalPresentationStyle = .overFullScreen
        hostingController.hidesBottomBarWhenPushed = true
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.present(hostingController, animated: true, completion: nil)
        }
    }
    
    func limitButtonTapped() -> (() -> Void)? {
        
        let complition: (() -> Void) = {
            DispatchQueue.main.async {
                print("limitButtonTapped")
            }
        }
        return complition
    }
    
    func positiveButtonTapped() -> (() -> Void)? {
        
        let complition: (() -> Void) = { [weak self] in
            self?.report.data?[self?.currentItem ?? 0].like = true
        }
        return complition
    }
    
    func negativeButtonTapped() -> (() -> Void)? {
        
        let complition: (() -> Void) = { [weak self] in
            self?.report.data?[self?.currentItem ?? 0].like = false
        }
        return complition
    }
    
    func deleteReportButtonTapped() -> (() -> Void)? {
        
        // Добавить системное окно
        let complition: (() -> Void) = { [weak self] in
            let count = self?.report.data?.count ?? 0
            let item = (self?.currentItem ?? 0) - 1
            if item < count && item >= 0 {
                self?.currentItem = item
            }
        }
        return complition
    }
    
    func shareReportButtonTapped() -> (() -> Void)? {
        
        let complition: (() -> Void) = { [weak self] in
            
            self?.shareToSystem(text: "Share the report")
        }
        return complition
    }
    
    private func shareToSystem(text: String) {
        let objectsToShare = [text] as [String]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        //Excluded Activities
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList,
                                            UIActivity.ActivityType.openInIBooks]
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            activityVC.popoverPresentationController?.sourceView = weakSelf.view
            if let popoverController = activityVC.popoverPresentationController {
                let view = UIView(frame: UIScreen.main.bounds)
                popoverController.sourceView = view
                popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            weakSelf.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func reviewReportButtonTapped() -> (() -> Void)? {
        
        let complition: (() -> Void) = { [weak self] in
            
            let alertController = UIAlertController(title: "Жалоба", message: "Текст сообщения", preferredStyle: .alert)
            
            // Добавление кнопки OK
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            DispatchQueue.main.async { [weak self] in
                self?.present(alertController, animated: true, completion: nil)
            }
        }
        return complition
    }
    
    func showQuestionView() -> (() -> Void)? {
        
        let complition: (() -> Void) = {
            DispatchQueue.main.async {
                print("questionTapped")
            }
        }
        return complition
    }
    
}

struct ShowReportViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ShowReportViewController {
        return ShowReportViewController()
    }
    
    func updateUIViewController(_ uiViewController: ShowReportViewController, context: Context) {
        // Обновление
    }
}
