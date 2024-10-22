//
//  AddReviewView.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 10/22/24.
//

import SwiftUI

struct AddReviewView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var address = ""
    @State private var openingTime = Date()
    @State private var closingTime = Date()
    @State private var decafAvailable = true
    @State private var local = true
    
    var body: some View {
        NavigationStack {
            Form {
                // Coffee shop inputs
                Section("Coffee Shop Info") {
                    // Set name of coffee shop
                    TextField("Name of coffee shop", text: $name)
                    // Set address of coffee shop
                    TextField("Address of coffee shop", text: $address)
                    
                    // DatePicker for opening time
                    DatePicker("Opening Time", selection: $openingTime, displayedComponents: .hourAndMinute)
                        .onAppear {
                            // Set default opening time
                            var components = Calendar.current.dateComponents([.hour, .minute], from: Date())
                            components.hour = 8
                            components.minute = 0
                            if let defaultOpeningTime = Calendar.current.date(from: components) {
                                openingTime = defaultOpeningTime
                            }
                        }
                    
                    // DatePicker for closing time
                    DatePicker("Closing Time", selection: $closingTime, displayedComponents: .hourAndMinute)
                        .onAppear {
                            // Set default closing time
                            var components = Calendar.current.dateComponents([.hour, .minute], from: Date())
                            components.hour = 17
                            components.minute = 0
                            if let defaultClosingTime = Calendar.current.date(from: components) {
                                closingTime = defaultClosingTime
                            }
                        }
                    
                    // Toggle for decaf available
                    Toggle("Is decaf available?", isOn: $decafAvailable)
                    
                    // Toggle for local
                    Toggle("Is the coffee shop local?", isOn: $local)
                }
                
                // Shop review inputs
                Section("Write a review") {
                    // More to come
                }
                
                Section {
                    Button("Save") {
                        if validCoffeeShop() {
                            let newCoffeeShop = CoffeeShop(name: name, address: address, openingTime: openingTime, closingTime: closingTime, decafAvailable: decafAvailable, local: local)
                            modelContext.insert(newCoffeeShop)
                            dismiss()
                        } else {
                            ()
                        }
                    }
                }
                
            }
            .navigationTitle("Add Review")
        }
    }
    
    func validCoffeeShop() -> Bool {
        if (name.isEmpty || address.isEmpty) {
            return false
        }
        
        return true
    }
}

#Preview {
    AddReviewView()
}

