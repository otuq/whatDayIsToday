//
//  APIRequest.swift
//  informationGatherringApp
//
//  Created by USER on 2021/05/24.
//

import Foundation
import Alamofire

class APIRequest {
    
    let baseUrl = "https://ja.wikipedia.org/w/api.php"
    static let shared = APIRequest()
    
    func apiRequest (parms: [String: Any], complition: @escaping(Result) -> Void) {
        
//        var parms = parms
//        parms["format"] = "json"
//        parms["action"] = "parse"
//        parms["prop"] = "wikitext"
//        parms["section"] = "1"
        
        var parms = parms
        parms["format"] = "json"
        parms["action"] = "query"
        parms["prop"] = "extracts"
        parms["explaintext"] = ""
        
        let request = AF.request(baseUrl, method: .get, parameters: parms)
        request.responseJSON { (response) in
            guard let statuscode = response.response?.statusCode else { return }
            if statuscode <= 300 {
                do {
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    
                    
                    let value = try decoder.decode(Result.self, from: data)
                    
                    complition(value)
                }catch{
                    print("変換に失敗しました。",error)
                }
            }
        }
    }
}
