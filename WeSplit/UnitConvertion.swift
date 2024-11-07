//
//  UnitConvertion.swift
//  WeSplit
//
//  Created by Pavan Kumar N on 02/11/24.
//

import SwiftUI

enum Units: String, CaseIterable {
    case meter
    case kilometer
    case feet
    case yards
    case miles
}

struct UnitConvertion: View {
    @State var inputLength: Double = 0.0
    @State var inputUnit = Units.kilometer
    @State var outputUnit = Units.meter
    private let units = Units.allCases

    private var outputLength: Double {
        let lengthInMeters: Double
        // Convert the input length to meters
        switch inputUnit {
        case .meter:
            lengthInMeters = inputLength
        case .kilometer:
            lengthInMeters = inputLength * 1000
        case .feet:
            lengthInMeters = inputLength * 0.3048
        case .yards:
            lengthInMeters = inputLength * 0.9144
        case .miles:
            lengthInMeters = inputLength * 1609.34
        }

        // Convert the length from meters to the output unit
        switch outputUnit {
        case .meter:
            return lengthInMeters
        case .kilometer:
            return lengthInMeters / 1000
        case .feet:
            return lengthInMeters / 0.3048
        case .yards:
            return lengthInMeters / 0.9144
        case .miles:
            return lengthInMeters / 1609.34
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Enter the length", value: $inputLength, format: .number)
                    Picker("select the input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("output") {
                    Text(outputLength.formatted(.number))
                    Picker("select the input unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }

            }
            .navigationTitle("Length converter")
        }
    }
}

#Preview {
    UnitConvertion()
}
