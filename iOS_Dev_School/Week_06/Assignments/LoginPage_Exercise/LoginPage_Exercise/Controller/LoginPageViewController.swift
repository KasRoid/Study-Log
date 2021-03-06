//
//  LoginPageViewController.swift
//  LoginPage_Exercise
//
//  Created by Kas Song on 2020.05.14.
//  Copyright © 2020 Kas Song. All rights reserved.
//

import UIKit

var loginBrain = LoginBrain()

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
    var loginAreaView: UIView = {
        let view = UIView()
        return view
    }()

    // images
    let loginTextImageSize = CGSize(width: 30, height: 30)
    var logoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.frame.size = CGSize(width: 250, height: 200)
        imageView.image = UIImage(named: "fastcampus_logo.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var userImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.frame.size = loginTextImageSize
        imageView.image = UIImage(named: "user.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var passwordImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.frame.size = loginTextImageSize
        imageView.image = UIImage(named: "password.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // redDots 237,34,78
    let redDotsSize = CGSize(width: 30, height: 30)
    let redDotsColor = UIColor(
        red: 237 / 255,
        green: 34 / 255,
        blue: 78 / 255,
        alpha: 1.0
    )
    lazy var firstRedDotView: UIView = {
        let view = UIView()
        view.frame.size = redDotsSize
        view.backgroundColor = redDotsColor
        view.layer.cornerRadius = 5
        return view
    }()
    lazy var secondRedDotView: UIView = {
        let view = UIView()
        view.frame.size = redDotsSize
        view.backgroundColor = redDotsColor
        view.layer.cornerRadius = 5
        return view
    }()
    lazy var thirdRedDotView: UIView = {
        let view = UIView()
        view.frame.size = redDotsSize
        view.backgroundColor = redDotsColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    // loginField bars
    let loginFieldBarSize = CGSize(width: 270, height: 1)
    lazy var idFieldBarView: UIView = {
        let view = UIView()
        view.frame.size = loginFieldBarSize
        view.backgroundColor = .lightGray
        return view
    }()
    lazy var passwordFieldBarView: UIView = {
        let view = UIView()
        view.frame.size = loginFieldBarSize
        view.backgroundColor = .lightGray
        return view
    }()
    
    // textFields
    let textFieldSize = CGSize(width: 250, height: 30)
    lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size = textFieldSize
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.placeholder = "아이디를 입력하세요"
        textField.contentVerticalAlignment = .center
        textField.contentHorizontalAlignment = .center
        textField.keyboardType = .emailAddress
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size = textFieldSize
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.placeholder = "비밀번호를 입력하세요"
        textField.contentVerticalAlignment = .center
        textField.contentHorizontalAlignment = .center
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // button
    let loginButtonSize = CGSize(width: 320, height: 45)
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame.size = loginButtonSize
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame.size = loginButtonSize
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(signupButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Interface
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        [idTextField, passwordTextField].forEach { $0.delegate = self }
        
        updateUI()
        checkLoginStatus()
    }

    func updateUI() {
        loginAreaView.frame.size = CGSize(width: view.frame.width, height: 400)
        loginAreaView.frame.origin = CGPoint(x: 0, y: view.frame.maxY - 400)
        view.addSubview(loginAreaView)
        
        //images
        logoImageView.frame.origin = CGPoint(x: view.frame.midX - 125, y: 30)
        view.addSubview(logoImageView)
        userImageView.frame.origin = CGPoint(x: 50, y: 60)
        passwordImageView.frame.origin = CGPoint(x: 50, y: 130)
        [userImageView, passwordImageView].forEach { loginAreaView.addSubview($0) }
        
        // redDots
        let firstRedDotPosition = CGPoint(x: view.frame.midX - 70, y: 170)
        let secondRedDotPosition = CGPoint(x: view.frame.midX - 15, y: 170)
        let thirdRedDotPosition = CGPoint(x: view.frame.midX + 40, y: 170)
        
        firstRedDotView.frame.origin = firstRedDotPosition
        secondRedDotView.frame.origin = secondRedDotPosition
        thirdRedDotView.frame.origin = thirdRedDotPosition
        [firstRedDotView, secondRedDotView, thirdRedDotView].forEach { view.addSubview($0) }
        
        // textFields
        idTextField.frame.origin = CGPoint(x: 100, y: 60)
        passwordTextField.frame.origin = CGPoint(x: 100, y: 130)
        idFieldBarView.frame.origin = CGPoint(x: 100, y: 100)
        passwordFieldBarView.frame.origin = CGPoint(x: 100, y: 170)
        [idTextField, passwordTextField, idFieldBarView, passwordFieldBarView].forEach { loginAreaView.addSubview($0) }
        
        // buttons
        loginButton.frame.origin = CGPoint(x: 50, y: 210)
        signupButton.frame.origin = CGPoint(x: 50, y: 270)
        [loginButton, signupButton].forEach { loginAreaView.addSubview($0) }
    }
    func checkLoginStatus() {
        let userIsAlreadyLoggedIn = UserDefaults.standard.bool(forKey: UserInfo.loggedIn)
        if userIsAlreadyLoggedIn {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let sceneDelegate = windowScene.delegate as? SceneDelegate
                sceneDelegate?.window?.rootViewController = MainPageViewController()
            }
        }
    }
    
    // MARK: - TextField delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    // textField character limits
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 16
    }
    
    // MARK: button action
    @objc func buttonPressed(_ sender: UIButton) {
        let id = idTextField.text ?? ""
        let pw = passwordTextField.text ?? ""
        let isCorrect = loginBrain.loginCheck(id: id, pw: pw) && id.count >= 4 && pw.count >= 4
        if isCorrect {
            UserDefaults.standard.set(isCorrect, forKey: UserInfo.loggedIn)
            let nextVC = MainPageViewController()
            nextVC.modalPresentationStyle = .fullScreen
            present(nextVC, animated: true)
        }
        else {
            UITextField.animate(withDuration: 0.8) {
                self.idTextField.layer.backgroundColor = UIColor.red.cgColor
                self.passwordTextField.layer.backgroundColor = UIColor.red.cgColor
            }
            UITextField.animate(withDuration: 0.8) {
                self.idTextField.layer.backgroundColor = UIColor.clear.cgColor
                self.passwordTextField.layer.backgroundColor = UIColor.clear.cgColor
            }
        }
    }
    @objc func signupButtonPressed(_ sender: UIButton) {
        let nextVC = SignupViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.loginAreaView.frame.origin.y == view.frame.maxY - 400 {
                self.loginAreaView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.loginAreaView.frame.origin.y != view.frame.maxY - 400 {
            self.loginAreaView.frame.origin.y = view.frame.maxY - 400
        }
    }
}
