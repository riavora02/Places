//
//  UserViewController.swift
//  Places
//
//  Created by Ria Vora on 12/5/20.
//

import UIKit

protocol SignUpViewDelegate: class {
}

class UserViewController: UIViewController {
    
    var userName: UITextField!
    var password: UITextField!
    var login: UIButton!
    var signUp: UIButton!
    var logo: UIImageView!
    var passwordClicked = false
    var badEntry: UILabel!
    
    var user: User!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        userName = UITextField()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Username"
        userName.borderStyle = .roundedRect
        userName.backgroundColor = .white
        userName.textAlignment = .left
        userName.clearsOnBeginEditing = true
        view.addSubview(userName)
        
        password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.text = "Password"
        password.borderStyle = .roundedRect
        password.backgroundColor = .white
        password.textAlignment = .left
        password.clearsOnBeginEditing = true
        password.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingDidBegin)
        view.addSubview(password)
        
        login = UIButton()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.setTitle("Login", for: .normal)
        login.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1.0)
        login.setTitleColor(.white, for: .normal)
        login.addTarget(self, action: #selector(pushLogin), for: .touchUpInside)
        login.layer.cornerRadius = 10
        view.addSubview(login)
        
        signUp = UIButton()
        signUp.translatesAutoresizingMaskIntoConstraints = false
        signUp.setTitle("Don't have an account? Click here to sign up!", for: .normal)
        signUp.backgroundColor = .white
        signUp.setTitleColor(.blue, for: .normal)
        signUp.addTarget(self, action: #selector(pushSignUp), for: .touchUpInside)
        view.addSubview(signUp)
        
        logo = UIImageView(image: UIImage(named: "cornellLogo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)
        
        badEntry = UILabel()
        badEntry.translatesAutoresizingMaskIntoConstraints = false
        badEntry.text = "Must enter a valid username and password!"
        badEntry.isHidden = true
        badEntry.backgroundColor = .white
        badEntry.textColor = .red
        view.addSubview(badEntry)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            password.heightAnchor.constraint(equalToConstant: 36),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48)
            ])
        NSLayoutConstraint.activate([
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.bottomAnchor.constraint(equalTo: password.topAnchor, constant: -24),
            userName.heightAnchor.constraint(equalToConstant: 36),
            userName.leadingAnchor.constraint(equalTo: password.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: password.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            login.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 24),
            login.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            login.heightAnchor.constraint(equalToConstant: 48),
            login.leadingAnchor.constraint(equalTo: password.leadingAnchor, constant: 48),
            login.trailingAnchor.constraint(equalTo: password.trailingAnchor, constant: -48)
        ])
        NSLayoutConstraint.activate([
            logo.heightAnchor.constraint(equalTo: password.widthAnchor, multiplier: 0.5),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.bottomAnchor.constraint(equalTo: userName.topAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            signUp.heightAnchor.constraint(equalTo: login.heightAnchor, multiplier: 0.5),
            signUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUp.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -96),
        ])
        NSLayoutConstraint.activate([
            badEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            badEntry.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 12),
            badEntry.heightAnchor.constraint(equalTo: login.heightAnchor, multiplier: 0.5)
        ])
    }
    
    @objc func textFieldDidChange() {
        password.isSecureTextEntry = true
    }

    
    @objc func pushLogin() {
        if (userName.text! != "") && (password.text! != "") {
            badEntry.isHidden = true
            NetworkManager.signIn(email: userName.text!, username: userName.text!, password: password.text!) { user in
                User.current = user
            }
        } else {
            badEntry.isHidden = false
        }
        
    }
    
    @objc func pushSignUp() {
        
        let vc = SignUpViewController(delegate: self, titleString: "Sign Up")
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        
       // let vc = SignUpViewController(delegate: self, titleString: "Sign Up")
       // present(vc, animated: true, completion: nil)
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }

}

extension UserViewController: SignUpViewDelegate {
    func saveNewName(newName: String?) {
    }

}
