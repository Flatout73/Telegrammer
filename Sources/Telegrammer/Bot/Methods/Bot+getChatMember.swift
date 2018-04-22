// Telegrammer - Telegram Bot Swift SDK.
// This file is autogenerated by API/generate_wrappers.rb script.


import HTTP

public extension Bot {

    /// Use this method to get information about a member of a chat. Returns a ChatMember object on success.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)
    ///     - user_id: Unique identifier of the target user
    /// - Returns: Future<ChatMember>. Throws on errors.
    /// - Note: Asynchronous method.
    ///
    /// [- SeeAlso: ]<https://core.telegram.org/bots/api#getchatmember>

    public struct GetChatMemberParams: JSONEncodable {
        var chatId: ChatId
        var userId: Int64

        enum CodingKeys: String, CodingKey {
            case chatId = "chat_id"
            case userId = "user_id"
        }

        public init(chatId: ChatId, userId: Int64) {
            self.chatId = chatId
            self.userId = userId
        }
    }

    public func getChatMember(params: GetChatMemberParams) throws -> Future<ChatMember> {
        let body = try httpBody(for: params)
        let headers = try httpHeaders(for: params)
        let response: Future<TelegramContainer<ChatMember>>
        response = try client.respond(endpoint: "getChatMember", body: body, headers: headers)
        return response.flatMap(to: ChatMember.self) { try self.wrap($0) }
    }
}