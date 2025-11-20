//
//  SelectNumberOfQuestionView.swift
//  Edutainment
//
//  Created by Hafizur Rahman on 20/11/25.
//

import SwiftUI

struct SelectNumberOfQuestionView: View {
    enum NoOfQuestion: Int, CaseIterable {
        case five = 5
        case ten = 10
        case fifteen = 15
    }
    
    @State private var selectedQuestion: NoOfQuestion = .five
    
    var body: some View {
        VStack {
            Text("How many questions do you want to practice?")
                .font(.title.bold())
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
            
            Spacer().frame(height: 40)
            
            HStack {
                ForEach(NoOfQuestion.allCases, id: \.self) { question in
                    Button {
                        withAnimation {
                            selectedQuestion = question
                        }
                    } label: {
                        Text("\(question.rawValue)")
                            .font(.largeTitle.bold())
                            .fontDesign(.rounded)
                            .padding(.vertical, 30)
                            .frame(maxWidth: .infinity)
                            .background(
                                selectedQuestion == question ? .purple.opacity(0.7) : .gray.opacity(0.3)
                            )
                            .cornerRadius(12)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            Spacer().frame(height: 50)
            
            Button {
                    // Start quiz with selectedQuestion.rawValue
            } label: {
                Text("Start Quiz")
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

#Preview {
    SelectNumberOfQuestionView()
}
