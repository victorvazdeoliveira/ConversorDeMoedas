//
//  ContentView.swift
//  ConversorDeMoedas
//
//  Created by Victor Vaz de Oliveira on 16/05/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
    let defaults = UserDefaults.standard
    
    @State
    var showExchangeInfo = false
    @State
    var showSelectedCurrency = false
    
    @State var leftAmount = UserDefaults.standard.string(forKey: "Left Amount") ?? ""
    @State var rightAmount = UserDefaults.standard.string(forKey: "Right Amount") ?? ""
    
    @FocusState var leftTyping: Bool
    @FocusState var rightTyping: Bool
    
    @State var leftCurrency: Currency = Currency(rawValue: UserDefaults.standard.getLeftCurrency()) ?? Currency.silverPenny
    @State var rightCurrency: Currency = Currency(rawValue: UserDefaults.standard.getRightCurrency()) ?? Currency.goldPiece
    
    var body: some View {
        ZStack {
            // Background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // Prancing pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                // Currency conversion section
                HStack {
                    // Left conversion section
                    CurrencySection(currency: $leftCurrency, showSelectedCurrency: $showSelectedCurrency, amount: $leftAmount, typing: $leftTyping)
                    
                    // Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // Right conversion section
                    CurrencySection(currency: $rightCurrency, showSelectedCurrency: $showSelectedCurrency, amount: $rightAmount, typing: $rightTyping
                    )
                        .multilineTextAlignment(.trailing)
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                
                Spacer()
                
                // Info button
                HStack {
                    Spacer()
                    
                    Button {
                        showExchangeInfo.toggle()
                        print("showExchangeInfo value: \(showExchangeInfo)")
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                    
                }
            }
        }
        .onTapGesture {
            if leftTyping {
                leftTyping.toggle()
            }
            if rightTyping {
                rightTyping.toggle()
            }
        }
        .task {
            try? Tips.configure()
        }
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                UserDefaults.standard.setValue(rightAmount, forKey: "Right Amount")
                UserDefaults.standard.setValue(leftAmount, forKey: "Left Amount")
            }
        }
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                UserDefaults.standard.setValue(rightAmount, forKey: "Right Amount")
                UserDefaults.standard.setValue(leftAmount, forKey: "Left Amount")
            }
        }
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            UserDefaults.standard.setLeftCurrency(leftCurrency: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            UserDefaults.standard.setRightCurrency(rightCurrency: rightCurrency)
        }
        .sheet(isPresented: $showExchangeInfo, content: {
            ExchangeInfo()
        })
        .sheet(isPresented: $showSelectedCurrency, content: {
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
        })
    }
}

#Preview {
    ContentView()
}
