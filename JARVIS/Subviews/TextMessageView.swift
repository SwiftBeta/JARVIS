//
//  TextMessageView.swift
//  JARVIS
//
//  Created by Home on 19/4/23.
//

import SwiftUI
import SwiftOpenAI

struct TextMessageView: View {
    var message: MessageChatGPT
    
    var body: some View {
        HStack {
            if message.role == .user {
            Spacer()
            Text(message.text)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.white)
                .padding(.all, 10)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.blue)
                )
                .frame(maxWidth: 240, alignment: .trailing)
                
            } else {
                Text(message.text)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray)
                    )
                    .frame(maxWidth: 240, alignment: .leading)
                Spacer()
            }
        }
    }
}

struct TextMessageView_Previews: PreviewProvider {
    static let chatGPTMessage: MessageChatGPT = .init(text: "Hola SwiftBeta, estoy aquí para ayudarte y contestar todas tus preguntas", role: .system)
    static let myMessage: MessageChatGPT = .init(text: "¿Cuándo se lanzó el primer iPhone?", role: .user)
    static var previews: some View {
        Group {
            TextMessageView(message: Self.chatGPTMessage)
                .previewDisplayName("ChatGPT Message")
            TextMessageView(message: Self.myMessage)
                .previewDisplayName("My Message")
        }.previewLayout(.sizeThatFits)
    }
}
