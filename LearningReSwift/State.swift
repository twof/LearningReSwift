import ReSwift

struct AppState: StateType {
    var message: Message
    var turn: Turn
    var player1Play: Play
    var player2Play: Play
    var result: Result?

    init() {
        self.message = .player1choose
        self.turn = Turn(player: .one)
        self.player1Play = Play(chosen: false, weapon: nil)
        self.player2Play = Play(chosen: false, weapon: nil)
    }
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
    var weapon: Weapon?
}

enum Weapon: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

enum Result {
    case draw
    case player1Wins
    case player2Wins
}

// MARK:- Actions

struct ChooseWeaponAction: Action {
    var weapon: Weapon
}

// MARK:- Reducers

func appReducer(action: Action, state: AppState?) -> AppState {
    var appState = state ?? AppState()

    switch action {
    case let chooseWeaponAction as ChooseWeaponAction:
        let turn = appState.turn
        switch turn.player {
        case .one:
            let play = Play(chosen: true, weapon: chooseWeaponAction.weapon)

            appState.player1Play = play

            appState.turn = Turn(player: .two)

            appState.message = .player2choose
        case .two:
            let play = Play(chosen: true, weapon: chooseWeaponAction.weapon)

            appState.player2Play = play

            let playerOneWeapon = appState.player1Play.weapon ?? .rock
            let playerTwoWeapon = appState.player2Play.weapon ?? .rock

            switch playerOneWeapon {
            case .paper:
                switch playerTwoWeapon {
                case .rock:
                    appState.result = .player1Wins
                    appState.message = .player1wins
                case .paper:
                    appState.result = .draw
                    appState.message = .draw
                case .scissors:
                    appState.result = .player2Wins
                    appState.message = .player2wins
                }
            case .scissors:
                switch playerTwoWeapon {
                case .rock:
                    appState.result = .player2Wins
                    appState.message = .player2wins
                case .paper:
                    appState.result = .player1Wins
                    appState.message = .player1wins
                case .scissors:
                    appState.result = .draw
                    appState.message = .draw
                }
            case .rock:
                switch playerTwoWeapon {
                case .rock:
                    appState.result = .draw
                    appState.message = .draw
                case .paper:
                    appState.result = .player2Wins
                    appState.message = .player2wins
                case .scissors:
                    appState.result = .player1Wins
                    appState.message = .player1wins
                }
            }
        }
    default:
        break
    }

    return appState
}

