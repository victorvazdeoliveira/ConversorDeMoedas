//
//  CurrencySection.swift
//  ConversorDeMoedas
//
//  Created by Victor Vaz de Oliveira on 08/06/24.
//

import SwiftUI

struct CurrencySection: View {
    @Binding var currency: Currency
    @Binding var showSelectedCurrency: Bool
    @Binding var amount: String
    @FocusState.Binding var typing: Bool
    
    var body: some View {
        VStack {
            // Currency
            HStack {
                // Currency image
                Image(currency.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 33)
                
                // Currency text
                Text(currency.name)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding(.bottom, -5)
            .onTapGesture {
                showSelectedCurrency.toggle()
            }
            .popoverTip(CurrencyTip(), arrowEdge: .bottom)
            
            // Textfield
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
                .focused($typing)
                .keyboardType(.decimalPad)
        }
    }
}

//#Preview {
//    CurrencySection(currency: .constant(.silverPiece), showSelectedCurrency: .constant(false), amount: .constant(""), typing: .constant(false))
//}
