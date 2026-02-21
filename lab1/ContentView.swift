
import SwiftUI

struct ContentView: View {
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
}

#Preview {
    ContentView()
}
