//
//  ContentView.swift
//  WeSplit
//
//  Created by Pavan Kumar N on 01/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFieldActive: Bool

    private let tipPercentages = [10, 15, 20, 25, 0]

    private var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }

    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmount / peopleCount
        return amountPerPerson
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFieldActive)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section {
                    HStack {
                        Text("Grand Total:")
                        Spacer()
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                            .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                    }
                    HStack {
                        Text("Split per person:")
                        Spacer()
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                    }
                }
            }
            .navigationTitle("We Split")
            .toolbar{
                if isAmountFieldActive {
                    Button("Done") {
                        isAmountFieldActive = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
