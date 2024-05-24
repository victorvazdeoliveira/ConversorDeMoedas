//
//  ExchangeRate.swift
//  ConversorDeMoedas
//
//  Created by Victor Vaz de Oliveira on 16/05/24.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource
    let rightImage: ImageResource
    let exchangeText: String
    
    var body: some View {
        HStack{
            // Left currency image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            // Exchange rate text
            Text(exchangeText)
            
            // Right currency image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpiece, rightImage: .goldpenny, exchangeText: "1 Gold Piece = 4 Gold Pennies")
}
