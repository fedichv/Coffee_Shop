import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let startedLabel: UILabel = {
        let label = UILabel()
        label.text = "Fall in Love with\nCoffee in Blissful\nDelight!"
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to our cozy coffee corner,\nwhere every cup is a delightful treat."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        // Background
        view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "backgroundImage") // Замените на ваше изображение
        getStartedButton.backgroundColor = UIColor(named: "getStartedColor")
        
        // Content Container
        view.addSubview(container)
        container.addSubview(startedLabel)
        container.addSubview(welcomeLabel)
        container.addSubview(getStartedButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Background Image
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Container
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            // Started Label
            startedLabel.topAnchor.constraint(equalTo: container.topAnchor),
            startedLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            startedLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            // Welcome Label
            welcomeLabel.topAnchor.constraint(equalTo: startedLabel.bottomAnchor, constant: 16),
            welcomeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            // Get Started Button
            getStartedButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 24),
            getStartedButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            getStartedButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            getStartedButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupActions() {
        getStartedButton.addTarget(self, action: #selector(transitionHome), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func transitionHome() {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
