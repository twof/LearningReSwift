import ReSwift

struct AppState: StateType {
    var message: Message
    var turn: Turn
    var player1: Play
    var player2: Play
}

enum Message: String {
    case player1choose = "PLAYER 1 - Choose your weapon:"
    case player2choose = "PLAYER 2 - Choose your weapon:"
    case player1wins = "PLAYER 1 WINS!"
    case player2wins = "PLAYER 2 WINS!"
    case draw = "DRAW!"
}

struct Turn {
    var player: Player
}

enum Player {
    case one
    case two
}

struct Play {
    var chosen: Bool
    var weapon: Weapon
}

enum Weapon: String {
    case rock
    case paper
    case scissors
}

