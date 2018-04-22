// Telegrammer - Telegram Bot Swift SDK.
// This file is autogenerated by API/generate_wrappers.rb script.


import HTTP

public extension Bot {

    /// Use this method to delete a group sticker set from a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method. Returns True on success.
    /// - Parameters:
    ///     - chat_id: Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)
    /// - Returns: Future<Bool>. Throws on errors.
    /// - Note: Asynchronous method.
    ///
    /// [- SeeAlso: ]<https://core.telegram.org/bots/api#deletechatstickerset>

    public struct DeleteChatStickerSetParams: JSONEncodable {
        var chatId: ChatId

        enum CodingKeys: String, CodingKey {
            case chatId = "chat_id"
        }

        public init(chatId: ChatId) {
            self.chatId = chatId
        }
    }

    public func deleteChatStickerSet(params: DeleteChatStickerSetParams) throws -> Future<Bool> {
        let body = try httpBody(for: params)
        let headers = try httpHeaders(for: params)
        let response: Future<TelegramContainer<Bool>>
        response = try client.respond(endpoint: "deleteChatStickerSet", body: body, headers: headers)
        return response.flatMap(to: Bool.self) { try self.wrap($0) }
    }
}