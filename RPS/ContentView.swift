import SwiftUI

struct ContentView: View {
    @State private var game = ["Rock", "Paper", "Scissors"]
    @State private var playerScore = 0
    @State private var appChoice = "Rock"
    @State private var prompt = "Win"
    @State private var questionCount = 0
    @State private var gameOver = false

    
    func playGame(_ playerChoice: String) {
       
        var correctAnswer: String
        switch (appChoice, prompt) {
        case ("Rock", "Win"): correctAnswer = "Paper"
        case ("Rock", "Lose"): correctAnswer = "Scissors"
        case ("Paper", "Win"): correctAnswer = "Scissors"
        case ("Paper", "Lose"): correctAnswer = "Rock"
        case ("Scissors", "Win"): correctAnswer = "Rock"
        case ("Scissors", "Lose"): correctAnswer = "Paper"
        default: correctAnswer = ""
        }

        
        if playerChoice == correctAnswer {
            playerScore += 1
        } else {
            playerScore -= 1
        }

        
        questionCount += 1
        if questionCount == 10 {
            gameOver = true
        } else {
            
            appChoice = game.randomElement()!
            prompt = Bool.random() ? "Win" : "Lose"
        }
    }

    
    func resetGame() {
        playerScore = 0
        questionCount = 0
        appChoice = game.randomElement()!
        prompt = Bool.random() ? "Win" : "Lose"
        gameOver = false
    }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("App chose \(appChoice)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.pink)

            Text("You must \(prompt)")
                .font(.title2)
                .foregroundStyle(.red)

            
            HStack {
                ForEach(game, id: \.self) { item in
                    Button {
                        playGame(item)
                    } label:{
                        Text(item)
                            .font(.system(size: 20))
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
            }

            
            Text("Your score: \(playerScore)")
                .font(.title)
                .fontWeight(.bold)

            Spacer()
            Spacer()
        }
        .padding()
        .alert("Game Over", isPresented: $gameOver) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("Your final score is \(playerScore)")
        }
    }
}

#Preview {
    ContentView()
}
