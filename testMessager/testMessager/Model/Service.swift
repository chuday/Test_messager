//
//  Service.swift
//  testMessager
//
//  Created by Mikhail Chudaev on 23.05.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Service {
    static let shared = Service()
    
    init() { }
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponceCode) -> () ) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, error in
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email": email]
                    
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    
                    completion(ResponceCode(code: 1))
                }
            } else {
                completion(ResponceCode(code: 0))
            }
        }
    }
    
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if error != nil {
                print(error!.localizedDescription)
            }
        })
    }
    
    func authInApp(_ data: LoginField, completion: @escaping (AuthResponce) -> ()) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, error in
            if error != nil {
                completion(.error)
            } else {
                if let result = result {
                    completion(.success)
                    //                    if result.user.isEmailVerified {
                    //                        completion(.success)
                    //                    } else {
                    //                        self.confirmEmail()
                    //                        completion(.noVerify)
                    //                    }
                }
            }
        }
    }
    
    func getAllUsers(completion: @escaping ([CurrentUsers]) -> ()) {
        guard let email = Auth.auth().currentUser?.email else { return }
        
        var currentUsers = [CurrentUsers]()
        
        Firestore.firestore().collection("users").whereField("email", isNotEqualTo: email).getDocuments { snap, error in
            if error == nil {
                if let docs = snap?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let userId = doc.documentID
                        let email = data["email"] as! String
                        
                        currentUsers.append(CurrentUsers(id: userId, email: email))
                    }
                }
                completion(currentUsers)
            }
        }
    }
    
    func sendMessage(otherId: String?, converId: String?, text: String, completion: @escaping (String)-> ()) {
        
        let ref = Firestore.firestore()
        if let uid = Auth.auth().currentUser?.uid {
            
            if  converId == nil {
                let converId = UUID().uuidString
                
                let selfData: [String: Any] = [
                    "date": Date(),
                    "other": otherId!
                ]
                
                ref.collection("users").document(uid).collection("conversation").document(converId).setData(selfData)
                
                let otherData: [String: Any] = [
                    "date": Date(),
                    "other": otherId!
                ]
                
                ref.collection("users")
                    .document(otherId!)
                    .collection("conversation")
                    .document(converId)
                    .setData(otherData)
                
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                
                let converInfo: [String: Any] = [
                    "date": Date(),
                    "selfSender": uid,
                    "otherSender": otherId!
                ]
                
                ref.collection("conversation").document(converId).setData(converInfo) { err in
                    if let err = err {
                        print(err.localizedDescription)
                        return
                    }
                    
                    ref.collection("conversation")
                        .document(converId)
                        .collection("messages")
                        .addDocument(data: msg) { err in
                            if err == nil {
                                completion(converId)
                            }
                        }
                }
            } else {
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                
                ref.collection("conversation").document(converId!).collection("messages").addDocument(data: msg) { err in
                    if err == nil {
                        completion(converId!)
                    }
                }
            }
        }
    }
    
    func updateConversation() {
        
    }
    
    func getConversationId(otherId: String, completion: @escaping (String) -> ()) {
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Firestore.firestore()
            
            ref.collection("users")
                .document(uid)
                .collection("conversation")
                .whereField("otherId", isEqualTo: otherId)
                .getDocuments { snap, err in
                    if err != nil {
                        return
                    }
                    if let snap = snap, !snap.documents.isEmpty {
                        let doc = snap.documents.first
                        if let converId = doc?.documentID {
                            completion(converId)
                            
                        }
                    }
                }
        }
    }
    
    func getAllMessages(chatId: String, completion: @escaping ([Message]) -> ()) {
        if let uid = Auth.auth().currentUser?.uid {
            
            let ref = Firestore.firestore()
            
            ref.collection("conversation")
                .document(chatId)
                .collection("messages")
                .limit(to: 50)
                .order(by: "date", descending: false)
                .addSnapshotListener { snap, err in
                    if err != nil {
                        return
                    }
                    
                    if let snap = snap, !snap.documents.isEmpty {
                        var msgs = [Message]()
                        
                        var sender = Sender(senderId: uid, displayName: "Me")
                        
                        for doc in snap.documents {
                            let data = doc.data()
                            let userId = data["sender"] as! String
                            
                            let messageId = doc.documentID
                            let date = data["date"] as! Timestamp
                            let sendDate = date.dateValue()
                            let text = data["text"] as! String
                            
                            if userId == uid {
                                sender = Sender(senderId: "1", displayName: "")
                                
                            } else {
                                sender = Sender(senderId: "2", displayName: "")
                            }
                            
                            msgs.append(Message(sender: sender, messageId: messageId, sentDate: sendDate, kind: .text(text)))
                        }
                        completion(msgs)
                    }
                }
        }
    }
    
}
