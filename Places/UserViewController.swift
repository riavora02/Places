//
//  UserViewController.swift
//  Places
//
//  Created by Ria Vora on 12/5/20.
//

import UIKit
import SnapKit

protocol SignUpViewDelegate: class {
}

class UserViewController: UIViewController {
    
    var userName: UITextField!
    var password: UITextField!
    var login: UIButton!
    var signUp: UIButton!
    var placeImage: UIImageView!
    
    var passwordClicked = false
    //var user: User!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        placeImage = UIImageView()
        placeImage.image = UIImage(named: "place2")
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        view.addSubview(placeImage)
        
        userName = UITextField()
        userName.attributedPlaceholder = NSAttributedString(string: "Enter Cornell Email: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        userName.textColor = darkBlue
        userName.backgroundColor = lightBlue
        userName.layer.cornerRadius = 10
        userName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.userName.frame.height))
        userName.leftViewMode = UITextField.ViewMode.always
        userName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userName)
        
        password = UITextField()
        password.attributedPlaceholder = NSAttributedString(string: "Enter Password: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        password.textColor = darkBlue
        password.backgroundColor = lightBlue
        password.layer.cornerRadius = 10
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.userName.frame.height))
        password.leftViewMode = UITextField.ViewMode.always
        password.translatesAutoresizingMaskIntoConstraints = false
        password.isSecureTextEntry = true
        view.addSubview(password)
        
        login = UIButton()
        login.setTitle("Login", for: .normal)
        login.backgroundColor = darkBlue
        login.setTitleColor(lightBlue, for: .normal)
        login.addTarget(self, action: #selector(pushLogin), for: .touchUpInside)
        login.layer.cornerRadius = 10
        view.addSubview(login)
        
        signUp = UIButton()
        signUp.setTitle("Don't have an account? Sign Up!", for: .normal)
        signUp.backgroundColor = darkBlue
        signUp.setTitleColor(lightBlue, for: .normal)
        signUp.addTarget(self, action: #selector(pushSignUp), for: .touchUpInside)
        signUp.layer.cornerRadius = 10
        view.addSubview(signUp)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        placeImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(300)
            make.top.equalToSuperview().offset(150)
        }
        
        userName.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(40)
            make.centerY.equalToSuperview().offset(100)
        }
        
        password.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(40)
            make.centerY.equalTo(userName.snp.bottom).offset(40)
        }
        
        login.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(30)
            make.top.equalTo(password.snp.bottom).offset(20)
        }
        
        signUp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.2)
            make.height.equalTo(30)
            make.top.equalTo(login.snp.bottom).offset(5)
        }
    }

    
    @objc func pushLogin() {
        if (userName.text! != "") && (password.text! != "") {
            NetworkManager.signIn(email: userName.text!, username: userName.text!, password: password.text!) { valid, user in
                if(valid){
                    User.current = user
                    self.navigationController?.pushViewController(TabBarViewController(), animated: false)
                }
                else {
                    let alert = UIAlertController(title: "Invalid Credentials", message: "Please enter Username and Password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                    self.present(alert, animated: true )
                }
            }
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
