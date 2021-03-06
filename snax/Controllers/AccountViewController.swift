//
//  AccountViewController.swift
//  snax
//
//  Created by Jessica Yuan on 4/20/19.
//  Copyright © 2019 Jessica Yuan. All rights reserved.
//

import UIKit
import GoogleSignIn


class AccountViewController: UIViewController, GIDSignInUIDelegate {

    
    var image: UIImageView!
    var accountImage: UIImage!
    var nameLabel: UILabel!
    
    var email: String
    var firstName: String
    var lastName: String
    
    init(email: String, firstName: String, lastName: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "My Account"
        
//        NetworkManager.loginGet(email: email, completion: { user in
//            email = user?.email
//            firstName = user?.firstName
//            lastName = user.lastName
//        })
        
        //GIDSignIn.sharedInstance().uiDelegate = self
        
//        let signInButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        signInButton.center = view.center
//        view.addSubview(signInButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        
        image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "prof") //get image
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
        image.layer.cornerRadius = 75
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        view.addSubview(image)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .black
        nameLabel.text = firstName + " " + lastName
        nameLabel.font =  UIFont(name: "Helvetica Neue", size: 1)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 35)
        view.addSubview(nameLabel)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150)
            
            ])
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 25)
            
            ])
        
    }
    
    func changeTextLabel(newstring:String) {
        nameLabel.text = newstring
    }
    
    @objc func signOut(){
        GIDSignIn.sharedInstance().signOut()
        let signInVC = SignInViewController()
        present(signInVC, animated: true, completion: nil)
    }
    
    
}


