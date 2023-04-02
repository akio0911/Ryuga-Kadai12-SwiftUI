//
//  ContentView.swift
//  Kadai12-SwiftUI
//
//  Created by Ryuga on 2023/03/31.
//

import SwiftUI

struct ContentView: View {
    @State private var price: Double = 0
    @AppStorage ("rate") var rate: Double = 0
    @State private var result: Int = 0

    private var priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("税抜金額")
                TextField("", value: $price, formatter: priceFormatter)
                    .modifier(CustomTextFieldStyle())
                Text("円")
            }
            HStack {
                Text("消費税率")
                TextField("", value: $rate, formatter: priceFormatter)
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

    private func includingTaxPrice(_ price: Double, _ rate: Double) -> Int {
        return Int(price * (1 + rate * 0.01))
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
