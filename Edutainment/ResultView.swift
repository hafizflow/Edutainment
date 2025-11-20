import SwiftUI

struct QuizResult {
    let totalQuestions: Int
    let correctAnswers: Int
    
    var percentage: Double {
        Double(correctAnswers) / Double(totalQuestions) * 100
    }
}

struct ResultView: View {
    let result: QuizResult
    let onRestart: () -> Void
    let onExit: () -> Void
    
    var emoji: String {
        switch result.percentage {
            case 90...100: return "🌟"
            case 70..<90: return "🎉"
            case 50..<70: return "👍"
            default: return "💪"
        }
    }
    
    var message: String {
        switch result.percentage {
            case 90...100: return "Outstanding!"
            case 70..<90: return "Great job!"
            case 50..<70: return "Good effort!"
            default: return "Keep practicing!"
        }
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            Text(emoji)
                .font(.system(size: 100))
            
            VStack(spacing: 16) {
                Text(message)
                    .font(.largeTitle.bold())
                    .fontDesign(.rounded)
                
                Text("You got \(result.correctAnswers) out of \(result.totalQuestions) correct")
                    .font(.title3)
                    .fontDesign(.rounded)
                    .foregroundStyle(.secondary)
            }
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .trim(from: 0, to: result.percentage / 100)
                    .stroke(
                        result.percentage >= 70 ? Color.green : Color.orange,
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(result.percentage))%")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button {
                    withAnimation {
                        onRestart()
                    }
                } label: {
                    Text("Try Again")
                        .font(.headline)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.purple)
                        .cornerRadius(16)
                }
                
                Button {
                    onExit()
                } label: {
                    Text("Exit Quiz")
                        .font(.headline)
                        .fontDesign(.rounded)
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(16)
                }
            }
        }
        .padding(32)
    }
}

#Preview {
    ResultView(result: QuizResult(totalQuestions: 10, correctAnswers: 9), onRestart: {}, onExit: {})
}
