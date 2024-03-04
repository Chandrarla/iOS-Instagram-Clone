import UIKit
import SafariServices

class LoginViewController: UIViewController{
    
    struct Constants{
        static let cornerRadius: CGFloat =  8.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "User name or Email..."
        field.returnKeyType = .next //UIReturnKeyType 열거형, 키보드에 "Next" 라벨이 붙은 버튼이 표시되어, 사용자가 해당 버튼을 누르면 다음 입력 필드로 포커스가 이동
        field.leftViewMode = .always //텍스트 필드의 내부 왼쪽에 아이콘, 버튼, 로더 등 다양한 UI 요소를 배치
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //텍스트 필드가 활성화되어 있든 아니든 항상 표시
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true // 레이어의 경계를 넘어서는 내용을 잘라낼지 여부를 결정, 서리가 둥글게 처리된 뷰에서 내부 콘텐츠가 뷰의 둥근 경계 밖으로 나가지 않도록
        field.layer.cornerRadius = Constants.cornerRadius // 모서리의 둥근 정도를 결정
        field.layer.borderWidth = 1.0 //테두리
        field.layer.borderColor = UIColor.secondaryLabel.cgColor //테두리 색깔
        field.backgroundColor = .secondarySystemBackground

        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.returnKeyType = .continue //다음 입력 필드 tap, delegate에 선언
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Serviced", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an account", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named:"Gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        
        createAccountButton.addTarget(self,
                              action: #selector(didTapCreateAccount),
                              for: .touchUpInside)
        
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton),
                              for: .touchUpInside)
        
        privacyButton.addTarget(self,
                              action: #selector(didTapPrivacyButton),
                              for: .touchUpInside)
        
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        addSubviews() // 뷰 추가
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        //assign frames
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height/3.0)
        
        usernameEmailField.frame = CGRect(x: 25,
                                          y: headerView.bottom + 10,
                                          width: view.width - 50,
                                          height: 52.0)
        
        passwordField.frame = CGRect(x: 25,
                                     y: usernameEmailField.bottom + 10,
                                     width: view.width - 50,
                                     height: 52.0)
        
        loginButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom + 10,
                                     width: view.width - 50,
                                     height: 52.0)
        
        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButton.bottom + 10,
                                     width: view.width - 50,
                                     height: 52.0)
        
        termsButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom-100,
                                   width: view.width - 20,
                                   height: 50)
        
        privacyButton.frame = CGRect(x: 10,
                                     y: view.height - view.safeAreaInsets.bottom - 50,
                                     width: view.width-20,
                                     height: 50)
        
        configureHeaderView()
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else{
            return
        }
        
        guard let backgroundView = headerView.subviews.first else{
            return
        }
        backgroundView.frame = headerView.bounds
        //add instagram logo
        let imageView = UIImageView(image: UIImage(named: "Instagram"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubviews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, password.count >= 8, !password.isEmpty else{
            return
        }
        //login functionality
        
    }
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccount() {
        let vc = RegistrationViewController()
        present(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField == usernameEmailField{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTapLoginButton()
        }
        return true
    }

}
