//
//  ContentView.swift
//  tempConverter
//
//  Created by Adailton Lucas on 05/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var conversionUnityFrom = "Celsius"
    @State private var conversionUnityTo = "Celsius"
    
    @State private var conversionValue = 0.0
    
    @FocusState private var isConversionValueFromFocused: Bool
    @FocusState private var isConversionValueToFocused: Bool
    
    var results: Double{
        var res = conversionValue
        
        if conversionUnityFrom == conversionUnityTo {
            return res
        }
        
        if conversionUnityFrom == "Celsius" && conversionUnityTo == "Kelvin"{
            res = conversionValue + 273.15
        }
        if conversionUnityFrom == "Kelvin" && conversionUnityTo == "Celsius"{
            res = conversionValue - 273.15
        }
        
        if conversionUnityFrom == "Celsius" && conversionUnityTo == "Fahrenheit"{
            res = (conversionValue * 9/5) + 32
        }
        if conversionUnityFrom == "Fahrenheit" && conversionUnityTo == "Celsius"{
            res = (conversionValue - 32) * 5/9
        }
        
        if conversionUnityFrom == "Kelvin" && conversionUnityTo == "Fahrenheit"{
            res = (conversionValue - 273.15) * 9/5 + 32
        }
        if conversionUnityFrom == "Fahrenheit" && conversionUnityTo == "Kelvin"{
            res = (conversionValue - 32) * 5/9 + 273.15
        }
        
        return res
    }
    
    let conversionUnitys = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Converter de:", selection: $conversionUnityFrom){
                        ForEach(conversionUnitys, id: \.self){
                            Text($0)
                        }
                    }
                    Picker("Para:", selection: $conversionUnityTo){
                        ForEach(conversionUnitys, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section("Informe o valor a ser convertido"){
                    TextField("Digite um valor a ser convertido", value: $conversionValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isConversionValueFromFocused)
                }
                
                Section("Resultados:"){
                    Text(results, format: .number)
                }
            }
            .navigationTitle("TempConverter")
            .toolbar{
                if isConversionValueFromFocused || isConversionValueToFocused{
                    Button("Done"){
                        isConversionValueToFocused = false
                        isConversionValueFromFocused  = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
