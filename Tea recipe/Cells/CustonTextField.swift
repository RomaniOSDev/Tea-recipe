//
//  CustonTextField.swift
//  BlazeTea
//
//  Created by Роман Главацкий on 24.07.2025.
//

import SwiftUI

struct CustonTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            Text(title)
                .foregroundStyle(.white)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            TextField( placeholder, text: $text)
                .foregroundStyle(.white)
        }
        .padding()
        .background {
            Color.white.opacity(0.1)
                .cornerRadius(20)
        }
    }
}

#Preview {
    CustonTextField(title: "Tea name", placeholder: "e.g. Jasmine Green, Earl Grey, Matcha", text: .constant(""))
}
