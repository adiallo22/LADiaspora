//
//  AuthService.swift
//  LADiaspora
//
//  Created by Abdul Diallo on 6/25/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import SDWebImage
import Firebase
import UIKit

struct AuthService {
    
    static let shared = AuthService()
    
//    func signInUser(email: String, password: String, completion: @escaping([Result<DatabaseReference, Error>]) -> Void) {
//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            if error != nil {
//                completion()
//            } else {
//                //self.changeRoot()
//                self.dismissCurrentControllerAndShowTab()
//            }
//        }
//    }
    
    func registerUserWith(authCredential: AuthCredential, completion : @escaping(Error?, DatabaseReference) -> Void) {
        let username = authCredential.username
        let email = authCredential.email
        let fullname = authCredential.fullname
        let pwd = authCredential.password
        //
        let imageReference = Constants.References.imageDB.child("profile_images").child(NSUUID().uuidString)
        guard let imageData = authCredential.profileIMG.jpegData(compressionQuality: 0.5) else { return }
        imageReference.putData(imageData, metadata: nil) { (meta, error) in
            imageReference.downloadURL { (url, error) in
                //hold the url of the profile image saved in Storage
                guard let profileURL = url?.absoluteString else { return }
                //upload textfields and image url to database
                Auth.auth().createUser(withEmail: email, password: pwd, completion: { (result, error) in
                    if error != nil {
                        //self.setTheError(withError: error!.localizedDescription)
                        print(error?.localizedDescription)
                    } else {
                        let uid = result?.user.uid
                        let values = ["full name":fullname,
                                      "email":email,
                                      "username":username.lowercased(),
                                      "profileURL":profileURL]
                        //reference to database and upload values
                        let reference = Constants.References.db.child("users").child("\(uid!)")
                        reference.updateChildValues(values, withCompletionBlock: completion)
                    }
                })
            }
        }
    }
    
}
