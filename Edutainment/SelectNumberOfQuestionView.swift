import SwiftUI

struct SelectNumberOfQuestionView: View {
    let mainNumber: Int
    
    @State private var selectedCount = 5
    let questionCounts = [5, 10, 15, 20]
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 16) {
                Text("How many questions?")
                    .font(.largeTitle.bold())
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                
                Text("Choose your challenge level")
                    .font(.title3)
                    .fontDesign(.rounded)
                    .foregroundStyle(.secondary)
            }
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ],
                spacing: 16
            ) {
                ForEach(questionCounts, id: \.self) { count in
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            selectedCount = count
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Text("\(count)")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                            Text("Questions")
                                .font(.caption)
                                .fontDesign(.rounded)
                        }
                        .foregroundColor(selectedCount == count ? .white : .primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .background(
                            selectedCount == count
                            ? Color.purple
                            : Color.gray.opacity(0.2)
                        )
                        .cornerRadius(20)
                        .scaleEffect(selectedCount == count ? 1.05 : 1.0)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            Spacer()
            
            NavigationLink {
                QuizView(mainNumber: mainNumber, numberOfQuestion: selectedCount)
            } label: {
                Text("Start Quiz")
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
        .navigationTitle("\(mainNumber) Times Table")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SelectNumberOfQuestionView(mainNumber: 5)
}
