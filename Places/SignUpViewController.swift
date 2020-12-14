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
    var signUp: UIButton!
    var placeImage: UIImageView!
    var smallRect: UIView!
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
        
        smallRect = UIView()
        smallRect.backgroundColor = .white
        smallRect.layer.cornerRadius = 15
        view.addSubview(smallRect)

        userName = UITextField()
        userName.attributedPlaceholder = NSAttributedString(string: "Enter Username: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        userName.textColor = darkBlue
        userName.backgroundColor = lightBlue
        userName.layer.cornerRadius = 10
        userName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.userName.frame.height))
        userName.leftViewMode = UITextField.ViewMode.always
        userName.translatesAutoresizingMaskIntoConstraints = false
        smallRect.addSubview(userName)
        
        password = UITextField()
        password.attributedPlaceholder = NSAttributedString(string: "Enter Password: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        password.textColor = darkBlue
        password.backgroundColor = lightBlue
        password.layer.cornerRadius = 10
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.userName.frame.height))
        password.leftViewMode = UITextField.ViewMode.always
        password.translatesAutoresizingMaskIntoConstraints = false
        password.isSecureTextEntry = true
        smallRect.addSubview(password)
        
        password2 = UITextField()
        password2.attributedPlaceholder = NSAttributedString(string: "Enter Password Again: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        password2.textColor = darkBlue
        password2.backgroundColor = lightBlue
        password2.layer.cornerRadius = 10
        password2.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.userName.frame.height))
        password2.leftViewMode = UITextField.ViewMode.always
        password2.translatesAutoresizingMaskIntoConstraints = false
        password2.isSecureTextEntry = true
        smallRect.addSubview(password2)
        
        signUp = UIButton()
        signUp.setTitle("Sign Up", for: .normal)
        signUp.backgroundColor = darkBlue
        signUp.setTitleColor(lightBlue, for: .normal)
        signUp.addTarget(self, action: #selector(pushSignUp), for: .touchUpInside)
        signUp.layer.cornerRadius = 10
        smallRect.addSubview(signUp)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        smallRect.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3.5)
            make.width.equalToSuperview().dividedBy(1.2)
            
        }
        
        userName.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(20)
        }
        
        password.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(40)
            make.top.equalTo(userName.snp.bottom).offset(10)
        }
        
        password2.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(40)
            make.top.equalTo(password.snp.bottom).offset(10)
        }
        
        
        signUp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(30)
            make.top.equalTo(password2.snp.bottom).offset(5)
        }
    }
    
    @objc func textFieldDidChange() {
        password.isSecureTextEntry = true
    }
    
    @objc func textField2DidChange() {
        password2.isSecureTextEntry = true
    }
    
    @objc func pushSignUp() {
        if (userName.text! != "") && (password.text! != "") && (password2.text! != "") {
            NetworkManager.addUser(email: userName.text!, username: userName.text!, password: password.text!) {_ in
            }
            DispatchQueue.main.async {
                self.dismissViewController()
            }
        }
        
    }
    
    @objc func dismissViewController() {
        // To dismiss something modally, we use the dismiss(animated:completion) command.
        dismiss(animated: true, completion: nil)
    }
}
