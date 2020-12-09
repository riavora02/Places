//
//  SignUpViewController.swift
//  Places
//
//  Created by Neil Madhavani on 12/8/20.
//

import UIKit

class SignUpViewController: UIViewController {
    
    weak var delegate: SignUpViewDelegate?
    var titleString: String?
    
    var userName: UITextField!
    var password: UITextField!
    var password2: UITextField!
    var login: UIButton!
    var signUp: UIButton!
    var logo: UIImageView!
    var passwordClicked = false

    
    init(delegate: SignUpViewDelegate?, titleString: String?) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
        self.titleString = titleString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        userName = UITextField()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Cornell Email"
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
        
        password2 = UITextField()
        password2.translatesAutoresizingMaskIntoConstraints = false
        password2.text = "Confirm Password"
        password2.borderStyle = .roundedRect
        password2.backgroundColor = .white
        password2.textAlignment = .left
        password2.clearsOnBeginEditing = true
        password2.addTarget(self, action: #selector(textField2DidChange), for: UIControl.Event.editingDidBegin)
        view.addSubview(password2)
        
        login = UIButton()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.setTitle("Sign Up", for: .normal)
        login.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1.0)
        login.setTitleColor(.white, for: .normal)
        login.addTarget(self, action: #selector(pushLogin), for: .touchUpInside)
        login.layer.cornerRadius = 10
        view.addSubview(login)
        
        logo = UIImageView(image: UIImage(named: "cornellLogo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)

        // Do any additional setup after loading the view.
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
            password2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password2.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 24),
            password2.heightAnchor.constraint(equalToConstant: 36),
            password2.leadingAnchor.constraint(equalTo: password.leadingAnchor),
            password2.trailingAnchor.constraint(equalTo: password.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.bottomAnchor.constraint(equalTo: password.topAnchor, constant: -24),
            userName.heightAnchor.constraint(equalToConstant: 36),
            userName.leadingAnchor.constraint(equalTo: password.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: password.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            login.topAnchor.constraint(equalTo: password2.bottomAnchor, constant: 24),
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
    }
    
    @objc func textFieldDidChange() {
        password.isSecureTextEntry = true
    }
    
    @objc func textField2DidChange() {
        password2.isSecureTextEntry = true
    }
    
    @objc func pushLogin() {
      //  print("Login pressed")
    }
    
    @objc func pushSignUp() {
      //  print("Sign Up pressed")
    }
    
    @objc func dismissViewController() {
        // To dismiss something modally, we use the dismiss(animated:completion) command.

        dismiss(animated: true, completion: nil)
    }
}
