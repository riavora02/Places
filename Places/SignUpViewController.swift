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
    var badEntry: UILabel!
    var userNameLabel: UILabel!
    var passwordLabel: UILabel!
    var password2Label: UILabel!
    var bottomBorder = UIView()
    var bottomBorder2 = UIView()
    var bottomBorder3 = UIView()

    
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
        
        password2 = UITextField()
        password2.translatesAutoresizingMaskIntoConstraints = false
        password2.borderStyle = .roundedRect
        password2.backgroundColor = .clear
        password2.textAlignment = .left
        password2.clearsOnBeginEditing = true
        password2.isSecureTextEntry = true
        password2.borderStyle = .none
        view.addSubview(password2)
        
        bottomBorder3.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder3 = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder3.backgroundColor = UIColor(hue: 0.5333, saturation: 0.54, brightness: 0.95, alpha: 1.0)
        bottomBorder3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomBorder3)
        
        login = UIButton()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.setTitle("Sign Up", for: .normal)
        login.backgroundColor = UIColor(hue: 0.5333, saturation: 0.54, brightness: 0.95, alpha: 1.0)
        login.setTitleColor(.white, for: .normal)
        login.addTarget(self, action: #selector(pushSignUp), for: .touchUpInside)
        login.layer.cornerRadius = 25
        view.addSubview(login)
        
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
        
        password2Label = UILabel()
        password2Label.translatesAutoresizingMaskIntoConstraints = false
        password2Label.text = "CONFIRM PASSWORD"
        password2Label.backgroundColor = .clear
        password2Label.textColor = UIColor(hue: 0.5333, saturation: 0.54, brightness: 0.95, alpha: 1.0)
        view.addSubview(password2Label)

        // Do any additional setup after loading the view.
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            password2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password2.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 36),
            password2.heightAnchor.constraint(equalToConstant: 36),
            password2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            password2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48)
            ])
        NSLayoutConstraint.activate([
            password2Label.leadingAnchor.constraint(equalTo: password2.leadingAnchor),
            password2Label.bottomAnchor.constraint(equalTo: password2.topAnchor)
            ])
        NSLayoutConstraint.activate([
            bottomBorder3.bottomAnchor.constraint(equalTo: password2.bottomAnchor),
            bottomBorder3.leadingAnchor.constraint(equalTo: password2.leadingAnchor),
            bottomBorder3.trailingAnchor.constraint(equalTo: password2.trailingAnchor),
            bottomBorder3.heightAnchor.constraint(equalToConstant: 1)
        ])
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
            login.topAnchor.constraint(equalTo: password2.bottomAnchor, constant: 48),
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
            badEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            badEntry.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 12),
            badEntry.heightAnchor.constraint(equalTo: login.heightAnchor, multiplier: 0.5)
        ])
    }
    
    @objc func textFieldDidChange() {
        password.isSecureTextEntry = true
    }
    
    @objc func textField2DidChange() {
        password2.isSecureTextEntry = true
    }
    
    @objc func pushSignUp() {
        print("Signed Up!")
        print(userName.text!)
        print(password2.text!)
        if (userName.text! != "") && (password.text! != "") && (password2.text! != "") {
            badEntry.isHidden = true
            NetworkManager.addUser(email: userName.text!, username: userName.text!, password: password.text!) {_ in
            }
            DispatchQueue.main.async {
                self.dismissViewController()            }
        } else {
            badEntry.isHidden = false
        }
        
    }
    
    @objc func dismissViewController() {
        // To dismiss something modally, we use the dismiss(animated:completion) command.
        dismiss(animated: true, completion: nil)
    }
}
