//
//  ContentView.swift
//  ModalViewExample
//
//  Created by Natalia Sinitsyna on 12.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ShowReportViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
