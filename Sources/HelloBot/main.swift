
import Foundation
import Telegrammer
import HTTP

///Getting token from enviroment variable (most safe, recommended)
guard let token = Enviroment.get("TELEGRAM_BOT_TOKEN") else { exit(1) }

/// Initializind Bot settings (token, debugmode)
var settings = Bot.Settings(token: token, debugMode: true)

///Webhooks settings
//settings.webhooksIp = Enviroment.get("TELEGRAM_BOT_IP")!
//settings.webhooksUrl = Enviroment.get("TELEGRAM_BOT_WEBHOOK_URL")!
//settings.webhooksPort = Int(Enviroment.get("TELEGRAM_BOT_PORT")!)!
//settings.webhooksPublicCert = Enviroment.get("TELEGRAM_BOT_PUBLIC_KEY")!
//settings.webhooksPrivateKey = Enviroment.get("TELEGRAM_BOT_PRIVATE_KEY")!

let bot = try! Bot(settings: settings)

///Callback for handler, that sends Hello message for new chat member
func greetNewMember(_ update: Update) throws {
    guard let message = update.message,
        let newUsers = message.newChatMembers else { return }
    
    for user in newUsers {
        guard !user.isBot else { continue }
        
        var name = user.firstName
        if let username = user.username {
            name = "@\(username)"
        }
        
        let params = Bot.SendMessageParams(chatId: .chat(message.chat.id), text: """
            Hey \(name)!\nI'm HelloBot, written in Swift with Telegrammer framework, please feel free to ask questions in this group chat!
            """)
        try bot.sendMessage(params: params)
    }
}

///Callback for handler, that sends Hello message
func greeting(_ update: Update, _ updateQueue: Worker?, _ jobQueue: Worker?) throws {
    guard let message = update.message,
        let user = message.from else { return }
    
    let params = Bot.SendMessageParams(chatId: .chat(message.chat.id), text: "Hello, \(user.firstName)!")
    try bot.sendMessage(params: params)
}

do {
    let dispatcher = Dispatcher(bot: bot)
    
    ///Creating and adding New chat member handler
    dispatcher.add(handler: NewMemberHandler(callback: greetNewMember))
    
    ///Creating and adding Command handler for '/greet'
    dispatcher.add(handler: CommandHandler(commands: ["/greet"], callback: greeting))
    
    ///Longpolling updates
    _ = try Updater(bot: bot, dispatcher: dispatcher).startLongpolling().wait()
    
} catch {
    print(error.localizedDescription)
}
