import SwiftUI

struct QuizView: View {
    @Environment(\.dismiss) private var dismiss
    
    let mainNumber: Int
    let numberOfQuestion: Int
    
    @State private var attampedQuestion: Int = 1
    @State private var selectedAnswer: Int? = nil
    @State private var continueDisabled: Bool = true
    @State private var answerDisabled: Bool = false
    @State private var multiplyNumber: Int = Int.random(in: 2...20)
    @State private var options = [Int]()
    
        // NEW: Track correct answers
    @State private var correctAnswers: Int = 0
    
        // NEW: Show result screen
    @State private var showResult: Bool = false
    
    var answer: Int { mainNumber * multiplyNumber }
    
    func generateNewQuestion() {
        withAnimation(.easeInOut(duration: 0.3)) {
            options = []
            options.append(answer)
            while options.count < 4 {
                let wrongAnswer = mainNumber * Int.random(in: 1...20)
                if !options.contains(wrongAnswer) {
                    options.append(wrongAnswer)
                }
            }
            options.shuffle()
        }
    }
    
    var body: some View {
        NavigationStack {
            if showResult {
                ResultView(
                    result: QuizResult(
                        totalQuestions: numberOfQuestion,
                        correctAnswers: correctAnswers
                    ),
                    onRestart: {
                        attampedQuestion = 1
                        correctAnswers = 0
                        selectedAnswer = nil
                        continueDisabled = true
                        answerDisabled = false
                        multiplyNumber = Int.random(in: 2...20)
                        generateNewQuestion()
                        showResult = false
                    },
                    onExit: { dismiss() }
                )
            } else {
                VStack(spacing: 32) {
                    Spacer().frame(height: 0)
                    ProgressView(value: Double(attampedQuestion), total: Double(numberOfQuestion))
                        .tint(.purple)
                    
                    Spacer()
                    
                    Text("\(mainNumber) x \(multiplyNumber) = ?")
                        .font(.largeTitle.bold())
                        .fontDesign(.rounded)
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {
                        ForEach(options, id: \.self) { index in
                            Button {
                                selectedAnswer = index
                                continueDisabled = false
                                answerDisabled = true
                                if index == answer {
                                    correctAnswers += 1
                                }
                            } label: {
                                Text("\(index)")
                                    .font(.title.bold())
                                    .fontDesign(.rounded)
                                    .frame(height: 80)
                                    .frame(maxWidth: .infinity)
                                    .background(backgroundColor(for: index))
                                    .clipShape(.rect(cornerRadius: 24))
                            }
                            .buttonStyle(.plain)
                            .buttonSizing(.flexible)
                            .disabled(answerDisabled)
                        }
                    }
                    Button {
                        if attampedQuestion == numberOfQuestion {
                            showResult = true
                        } else {
                            multiplyNumber = Int.random(in: 2...20)
                            generateNewQuestion()
                            selectedAnswer = nil
                            continueDisabled = true
                            answerDisabled = false
                            attampedQuestion += 1
                        }
                    } label: {
                        Text(attampedQuestion == numberOfQuestion ? "See Results" : "Continue")
                            .font(.headline)
                            .fontDesign(.rounded)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                    }
                    .tint(attampedQuestion == numberOfQuestion ? .green : .blue)
                    .buttonStyle(.glassProminent)
                    .buttonSizing(.flexible)
                    .disabled(continueDisabled)
                    
                    Spacer()
                }
                .padding(.horizontal, 32)
                .onAppear { if options.isEmpty { generateNewQuestion() } }
            }
        }
    }
    
    func backgroundColor(for index: Int) -> Color{
        guard let selected = selectedAnswer else {
            return .gray.opacity(0.3)
        }
        
        if index == answer {
            return .green.opacity(0.5)
        }
        
        if selected == index && index != answer {
            return .red.opacity(0.5)
        }
        
        return .gray.opacity(0.3)
    }
}

#Preview {
    QuizView(mainNumber: 5, numberOfQuestion: 3)
}
