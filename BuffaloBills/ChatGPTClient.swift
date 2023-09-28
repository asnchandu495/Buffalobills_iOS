//
//  ChatGPTClient.swift
//  BuffaloBills
//
//  Created by venkata baisani on 25/09/23.
//

import Foundation
import Alamofire


class ChatGPTClient {
    
    let baseURL = "https://api.openai.com/v1/chat/completions"
    let headers: HTTPHeaders = ["Authorization": "Bearer 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","Authorization": "Bearer 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"]
    
    
    func request(text:String) -> DataRequest {
        
        let body = OpenAICompletionBody(model: Setting.shared.model, messages: [Message(role: .user, content: text)], temperature: 0.7, stream: false)
        
        return AF.request(baseURL, method: .post, parameters: body, encoder: .json, headers: headers)
    }
    
    func requestStream(text:String) -> DataStreamRequest {
        let body = OpenAICompletionBody(model: Setting.shared.model, messages: [Message(role: .user, content: text)], temperature: 0.7, stream: true)
        
        return AF.streamRequest(baseURL, method: .post, parameters: body, encoder: .json, headers: headers)
    }
    
    
    func parse(data:String) -> [StreamChat] {
        //        if #available(iOS 16.0, *) {
        //            let response = data.split(separator: "data:").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)}).filter({!$0.isEmpty})
        let response = data.components(separatedBy: "data:").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)}).filter({!$0.isEmpty})
        return response.compactMap { json in
            guard let data = json.data(using: .utf8),
                  let stream = try? JSONDecoder().decode(StreamChat.self, from: data) else {
                return nil
            }
            return stream
        }
        //        } else {
        //            // Fallback on earlier versions
        //        }
        
        
    }
    
    func generateText(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        //        let parameters:[String: Any] = [:]
        
        let body = OpenAICompletionBody(model: Setting.shared.model, messages: [Message(role: .user, content: prompt)], temperature: 0.7, stream: false)
        
        let messagesValue1:[String: Any] = [
            "role": "system",
            "content": "You are a helpful assistant."
        ]
        
        let messagesValue2:[String: Any] = [
            "role": "user",
            "content": prompt
        ]
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages":[messagesValue1,messagesValue2]
        ]
        
        AF.request(baseURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: StreamChat.self) { response in
                switch response.result {
                case .success(let chatGPTResponse):
                    completion(.success(chatGPTResponse.choices[0].delta.content ?? ""))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func getChatResponse(prompt: String, completion: @escaping (Result<String, Error>) -> Void){
        
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\n    \"model\": \"gpt-3.5-turbo\",\n    \"messages\": [\n      {\n        \"role\": \"system\",\n        \"content\": \"You are a helpful assistant.\"\n      },\n      {\n        \"role\": \"user\",\n        \"content\": \"\(prompt)\"\n      }\n    ]\n}"
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        
        //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
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                print(String(describing: error))
                completion(.failure(error!))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            do {
                let responseDecoder = try JSONDecoder().decode(StreamChat.self, from: data)
                // print("getAppointmentData Dashboard Response \(String(describing: responseDecoder.data?.count))")
                completion(.success(responseDecoder.choices[0].delta.content ?? ""))
            }
            catch let e {
                print("decoder error \(e)")
                completion(.failure(e))
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
    

}

struct ChatGPTResponse: Decodable {
    let choices: [Choice]
    
    struct Choice: Decodable {
        let text: String
    }
}

struct MYError : Error {
    let description : String
    let domain : String
    
    var localizedDescription: String {
        return NSLocalizedString(description, comment: "Unknown Error")
    }
}
