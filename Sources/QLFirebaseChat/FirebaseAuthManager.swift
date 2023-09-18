//
//  File.swift
//  
//
//  Created by Abhishek Pandey on 15/09/23.
//

import Foundation
import Firebase

public class FirebaseAuthManager {
    // MARK: - Properties

    public static let shared = FirebaseAuthManager()

    // MARK: - Initialization

     init() {
        //FirebaseApp.configure()
    }

    // MARK: - User Registration

    public func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            } else {
                // Handle unexpected case
            }
        }
    }

    // MARK: - User Login

    public func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            } else {
                // Handle unexpected case
            }
        }
    }

    // MARK: - User Logout

    public func logoutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}

