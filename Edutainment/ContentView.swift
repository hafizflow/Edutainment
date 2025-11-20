import SwiftUI

struct ContentView: View {
    @State private var selectedTable = Int.random(in: 2...12)
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                VStack(spacing: 16) {
                    Text("🎯")
                        .font(.system(size: 72))
                    
                    Text("Multiplication Practice")
                        .font(.largeTitle.bold())
                        .fontDesign(.rounded)
                        .multilineTextAlignment(.center)
                    
                    Text("Which table do you want to practice?")
                        .font(.title3)
                        .fontDesign(.rounded)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 24) {
                    Text("\(selectedTable)")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundStyle(.purple)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTable)
                    
                    Stepper(value: $selectedTable, in: 2...12) {
                        Text("Times Table")
                            .font(.title3)
                            .fontDesign(.rounded)
                    }
                }
                .padding(24)
                .background(.purple.opacity(0.1))
                .cornerRadius(20)
                
                NavigationLink {
                    SelectNumberOfQuestionView(mainNumber: selectedTable)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.purple)
                        .cornerRadius(16)
                }
            }
            .padding(32)
        }
    }
}

#Preview {
    ContentView()
}
