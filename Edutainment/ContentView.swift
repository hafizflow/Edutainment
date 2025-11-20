//
//  ContentView.swift
//  Edutainment
//
//  Created by Hafizur Rahman on 20/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTable: Int = Int.random(in: 2...12)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Which multiplication table you want to practice?")
                    .font(.title.bold())
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 60)
                Stepper(value: $selectedTable, in: 2...12, step: 1) {
                    Text("Selecte Table: \(selectedTable)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                }
                Spacer().frame(height: 60)
                
                NavigationLink {
                    SelectNumberOfQuestionView()
                } label: {
                    Text("Proceed")
                        .font(.headline)
                        .fontDesign(.rounded)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                }
                .tint(.purple)
                .buttonStyle(.glassProminent)
                .buttonSizing(.flexible)
            }
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    ContentView()
}
