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
    var userNameLabel: UILabel!
    var passwordLabel: UILabel!
    var bottomBorder = UIView()
    var bottomBorder2 = UIView()
    var user: User!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIImage(named: "cornellBackground")
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        userName = UITextField()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.borderStyle = .roundedRect
        userName.backgroundColor = .clear
        userName.textAlignment = .left
        userName.clearsOnBeginEditing = true
        userName.borderStyle = .none
        view.addSubview(userName)
        
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor(hue: 0.5333, saturation: 0.54, brightness: 0.95, alpha: 1.0)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomBorder)
        
        password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.borderStyle = .roundedRect
        password.backgroundColor = .clear
        password.textAlignment = .left
        password.clearsOnBeginEditing = true
        password.isSecureTextEntry = true
        password.borderStyle = .none
        view.addSubview(password)
        
        bottomBorder2.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder2 = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder2.backgroundColor = UIColor(hue: 0.5333, saturation: 0.54, brightness: 0.95, alpha: 1.0)
        bottomBorder2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomBorder2)
        
        login = UIButton()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.setTitle("Login", for: .normal)
        login.backgroundColor = UIColor(hue: 0.5333, saturation: 0.54, brightness: 0.95, alpha: 1.0)
        login.setTitleColor(.white, for: .normal)
        login.addTarget(self, action: #selector(pushLogin), for: .touchUpInside)
        login.layer.cornerRadius = 25
        view.addSubview(login)
        
        signUp = UIButton()
        signUp.translatesAutoresizingMaskIntoConstraints = false
        signUp.setTitle("Don't have an account? Click here to sign up!", for: .normal)
        signUp.backgroundColor = .clear
        signUp.setTitleColor(UIColor(hue: 0.5333, saturation: 0.54, brightness: 0.95, alpha: 1.0), for: .normal)
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
        
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.text = "USERNAME"
        userNameLabel.backgroundColor = .clear
        userNameLabel.textColor = UIColor(hue: 0.5333, saturation: 0.54, brightness: 0.95, alpha: 1.0)
        view.addSubview(userNameLabel)
        
        passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "PASSWORD"
        passwordLabel.backgroundColor = .clear
        passwordLabel.textColor = UIColor(hue: 0.5333, saturation: 0.54, brightness: 0.95, alpha: 1.0)
        view.addSubview(passwordLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            passwordLabel.leadingAnchor.constraint(equalTo: password.leadingAnchor),
            passwordLabel.bottomAnchor.constraint(equalTo: password.topAnchor)
            ])
        NSLayoutConstraint.activate([
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            password.heightAnchor.constraint(equalToConstant: 36),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48)
            ])
        NSLayoutConstraint.activate([
            bottomBorder2.bottomAnchor.constraint(equalTo: password.bottomAnchor),
            bottomBorder2.leadingAnchor.constraint(equalTo: password.leadingAnchor),
            bottomBorder2.trailingAnchor.constraint(equalTo: password.trailingAnchor),
            bottomBorder2.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.bottomAnchor.constraint(equalTo: password.topAnchor, constant: -36),
            userName.heightAnchor.constraint(equalToConstant: 36),
            userName.leadingAnchor.constraint(equalTo: password.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: password.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            bottomBorder.bottomAnchor.constraint(equalTo: userName.bottomAnchor),
            bottomBorder.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: userName.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: userName.topAnchor)
            ])
        NSLayoutConstraint.activate([
            login.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 48),
            login.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            login.heightAnchor.constraint(equalToConstant: 48),
            login.leadingAnchor.constraint(equalTo: password.leadingAnchor, constant: 48),
            login.trailingAnchor.constraint(equalTo: password.trailingAnchor, constant: -48)
        ])
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.bottomAnchor.constraint(equalTo: userName.topAnchor, constant: -96)
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

    
    @objc func pushLogin() {
        if (userName.text! != "") && (password.text! != "") {
            badEntry.isHidden = true
            NetworkManager.signIn(email: userName.text!, username: userName.text!, password: password.text!) { user in
                User.current = user
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
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
