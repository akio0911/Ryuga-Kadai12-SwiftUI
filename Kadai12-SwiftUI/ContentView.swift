//
//  ContentView.swift
//  Kadai12-SwiftUI
//
//  Created by Ryuga on 2023/03/31.
//

import SwiftUI

struct ContentView: View {
    @State private var price = ""
    @AppStorage ("rate") var rate = ""
    @State private var result: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("税抜金額")
                TextField("", text: $price)
                    .modifier(CustomTextFieldStyle())
                Text("円")
            }
            HStack {
                Text("消費税率")
                TextField("", text: $rate)
                    .modifier(CustomTextFieldStyle())
                Text("％")
            }
            Button("結果"){
                result = includingTaxPrice(price, rate)
            }
            HStack {

                Text("税込金額")
                Text("\(result)")
                    .frame(width: 150, alignment: .trailing)
                Text("円")
            }
            Spacer()
        }
    }
    private func includingTaxPrice(_ price: String, _ rate: String) -> Int {
        let priceNum = Double(price) ?? 0
        let rateNum = Double(rate) ?? 0
        return Int(priceNum * (1 + rateNum * 0.01))
    }
}


struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 150, alignment: .trailing)
            .multilineTextAlignment(TextAlignment.trailing)
            .keyboardType(.numberPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
