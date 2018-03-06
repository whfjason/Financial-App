//
//  ArtistModel.swift
//  Mobile-Financial-App
//
//  Created by Jason Wong on 2018-03-06.
//  Copyright © 2018 Jason Wong. All rights reserved.
//

class TransactionModel {
    
    var userId: String?
    var transactionId: String?
    var timestamp: String?
    var payableTo: String?
    var fromAccount: String?
    var amount: String?
    
    
//    init(userId: String?, transactionId: String?, timestamp: String?, payableTo: String?, fromAccount: String?, amount: String?) {
//        self.userId = userId
//        self.transactionId = transactionId
//        self.timestamp = timestamp
//        self.payableTo = payableTo
//        self.fromAccount = fromAccount
//        self.amount = amount
//    }
    
    init(payableTo: String?, amount: String?) {
        self.payableTo = payableTo
        self.amount = amount
    }
}
