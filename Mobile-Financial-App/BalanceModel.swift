//
//  BalanceModel.swift
//  Mobile-Financial-App
//
//  Created by Eric Xiao on 2018/3/8.
//  Copyright © 2018年 Eric Xiao. All rights reserved.
//

class BalanceModel {
    var userId: String?
    var transactionId: String?
    var timestamp: String?
    var payableTo: String?
    var fromAccount: String?
    var amount: String?
    
    
    init(fromAccount: String?, amount: String?) {
        self.fromAccount = fromAccount
        self.amount = amount
        
    }
}
