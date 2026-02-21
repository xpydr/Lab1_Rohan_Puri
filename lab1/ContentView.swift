import SwiftUI

struct ContentView: View {
    @State private var currentNumber: Int = 0
    @State private var feedback: String? = nil
    @State private var correctCount: Int = 0
    @State private var wrongCount: Int = 0
    @State private var attemptCount: Int = 0
    @State private var showSummary: Bool = false
    @State private var needsNewAfterAlert: Bool = false
    @State private var countdownTimer: Timer? = nil
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Is \(currentNumber) prime?")
                
                if let feedback = feedback {
                    Image(systemName: feedback == "correct" ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.largeTitle)
                }

                HStack(spacing: 40) {
                    Button {
                        handleAnswer(isPrimeGuess: true)
                    } label: {
                        Text("Prime")
                    }
                    .disabled(feedback != nil || showSummary)

                    Button {
                        handleAnswer(isPrimeGuess: false)
                    } label: {
                        Text("Not Prime")
                    }
                    .disabled(feedback != nil || showSummary)
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Text("Attempt: \(attemptCount % 10)")
                        .padding()
                        .font(.footnote)
                    Spacer()
                }
            }
        }
        .onAppear {
            generateNewNumber()
            startCountdown()
        }
        .alert("Performance Summary", isPresented: $showSummary) {
            Button("OK") {
                showSummary = false
                attemptCount = 0 // Reset attempt counter
                if needsNewAfterAlert {
                    generateNewNumber()
                    startCountdown()
                    needsNewAfterAlert = false
                }
            }
        } message: {
            Text("Correct: \(correctCount)\nWrong: \(wrongCount)")
        }
    }
    
    private func isPrime(_ n: Int) -> Bool {
        if n < 2 { return false }
        if n == 2 { return true }
        if n % 2 == 0 { return false }
        
        let limit = Int(Double(n).squareRoot())
        var i = 3
        
        while i <= limit {
            if n % i == 0 { return false }
            i += 2
        }
        
        return true
    }
    
    private func generateNewNumber() {
        currentNumber = Int.random(in: 1...1000)
    }
    
    private func startCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            handleTimeout()
        }
    }
    
    private func handleTimeout() {
        wrongCount += 1
        attemptCount += 1
        if attemptCount % 10 == 0 {
            showSummary = true
            needsNewAfterAlert = true
        } else {
            generateNewNumber()
            startCountdown()
        }
    }
    
    private func handleAnswer(isPrimeGuess: Bool) {
        countdownTimer?.invalidate()
        let actualIsPrime = isPrime(currentNumber)
        let correct = (actualIsPrime == isPrimeGuess)
        if correct {
            correctCount += 1
            feedback = "correct"
        } else {
            wrongCount += 1
            feedback = "wrong"
        }
        attemptCount += 1
        if attemptCount % 10 == 0 {
            showSummary = true
            needsNewAfterAlert = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.feedback = nil
            if !self.showSummary {
                generateNewNumber()
                startCountdown()
            }
        }
    }
}

#Preview {
    ContentView()
}
