//
//  ContentView.swift
//  ConversorDeMoedas
//
//  Created by Victor Vaz de Oliveira on 16/05/24.
//

import SwiftUI

struct ContentView: View {
    @State
    var showExchangeInfo = false
    @State
    var showSelectedCurrency = false
    
    @State
    var leftAmount = ""
    @State
    var rightAmount = ""
    
    @FocusState
    var leftTyping
    @FocusState
    var rightTyping
    
    @State
    var leftCurrency: Currency = .silverPiece
    @State
    var rightCurrency: Currency = .goldPiece
    
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
                    VStack {
                        // Currency
                        HStack {
                            // Currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            // Currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectedCurrency.toggle()
                        }
                        .onChange(of: leftCurrency) {
                            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                        }
                        
                        // Textfield
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .onChange(of: leftAmount) {
                                if leftTyping {
                                    rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                                }
                            }
                    }
                    
                    // Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // Right conversion section
                    VStack {
                        // Currency
                        HStack {
                            // Currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            // Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectedCurrency.toggle()
                        }
                        .onChange(of: rightCurrency) {
                            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                        }
                        
                        // Textfiled
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .onChange(of: rightAmount) {
                                if rightTyping {
                                    leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                                }
                                
                            }
                    }
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
