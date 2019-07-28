//
//  Suggestion.swift
//  HintPod
//
//  Created by Marawan Alwaraki on 23/03/2019.
//

import Foundation

class Suggestion {
    
    var id: String!
    var title: String!
    var content: String!
    var status: String!
    var voteCount: Int!
    var votes: Dictionary<String, Bool> = [:]
    
    init(json: AnyObject) {
        
        var dict:Dictionary<String, AnyObject>!
        
        dict = json as? Dictionary<String, AnyObject>
        
        self.id = dict["key"] as? String
        self.title = dict["title"] as? String ?? "Error suggestion"
        self.content = dict["content"] as? String ?? "Error suggestion"
        self.status = dict["status"] as? String ?? "Pending"
        self.voteCount = dict["voteCount"] as? Int ?? 0
        self.votes = dict["votes"] as! Dictionary<String, Bool>
    }
    
}