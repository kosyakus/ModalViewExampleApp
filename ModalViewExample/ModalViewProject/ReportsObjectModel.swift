//
//  ReportsObjectModel.swift
//  AppForReelSwiftUI
//
//  Created by Natalia Sinitsyna on 12.10.2024.
//

import SwiftUI

class ReportsObjectModel: ObservableObject {
    
    @Published var report: СommonReport?
    @Published var data: [GeneratedReport]?
}

class СommonReport {
    
    var show: Bool?
    // canGenerateNewReport: указывает, может ли пользователь генерировать новый
    var canGenerateNewReport: Bool?
    // canBuyOldReport: указывает, может ли пользователь приобрести старый отчет
    var canBuyOldReport: Bool?
    // leftFreeRequests: количество оставшихся бесплатных запросов для генерации отчетов
    var leftFreeRequests: Int?
    // priceNewReport: стоимость генерации нового отчета
    var priceNewReport: Int?
    // priceOldReport: стоимость покупки старого отчета
    var priceOldReport: Int?
    var allLimit: Int?
}

class GeneratedReport: Equatable {
    static func == (lhs: GeneratedReport, rhs: GeneratedReport) -> Bool {
        return (lhs.answer) == (rhs.answer) && (lhs.id) == (rhs.id)
    }
    
    
    var id: String?
    var answer: String?
    var purchased: Bool?
    var like: Bool?
}
