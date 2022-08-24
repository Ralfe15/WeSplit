//
//  ContentView.swift
//  WeSplit
//
//  Created by Rafael Schmidt on 24/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State var checkAmmount = 0.0
    @State var numberOfPeople = 2
    @State var tipPercentage = 20
    @FocusState private var ammountIsFocused: Bool
    
    let tipsPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let percentage = Double(tipPercentage)
        
        let tipValue = checkAmmount / 100 * percentage
        let total = (checkAmmount + tipValue)/peopleCount
        return total
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Ammount", value: $checkAmmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($ammountIsFocused)
                    Picker("Ammount of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                        
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipsPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip percentages")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total ammount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done") {
                        ammountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
