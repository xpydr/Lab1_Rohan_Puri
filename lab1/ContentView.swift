
import SwiftUI

struct ContentView: View {
    @State private var currentNumber: Int = 0
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
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
}

#Preview {
    ContentView()
}
