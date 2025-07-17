import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()
        
        // Dashboard
        let dashboardVC = DashboardViewController()
        dashboardVC.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "chart.pie.fill"), tag: 0)
        
        // Calculator
        let calculatorVC = CalculatorViewController()
        calculatorVC.tabBarItem = UITabBarItem(title: "Calculator", image: UIImage(systemName: "plusminus.circle.fill"), tag: 1)
        
        // About
        let aboutVC = AboutViewController()
        aboutVC.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "info.circle.fill"), tag: 2)
        
        let dashboardNav = UINavigationController(rootViewController: dashboardVC)
        let calculatorNav = UINavigationController(rootViewController: calculatorVC)
        let aboutNav = UINavigationController(rootViewController: aboutVC)
        
        tabBarController.viewControllers = [dashboardNav, calculatorNav, aboutNav]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

class DashboardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "19 Trillion Solution"
        view.backgroundColor = .systemBackground
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        // Hero Section
        let heroLabel = UILabel()
        heroLabel.text = "Unlocking Australia's Wealth"
        heroLabel.font = .systemFont(ofSize: 24, weight: .bold)
        heroLabel.numberOfLines = 0
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Transform $19 trillion in national assets into prosperity for every Australian"
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(heroLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        // Metrics
        let metricsStack = UIStackView()
        metricsStack.axis = .vertical
        metricsStack.spacing = 16
        
        metricsStack.addArrangedSubview(createMetricView(title: "Total Assets", value: "$19T", color: .systemBlue))
        metricsStack.addArrangedSubview(createMetricView(title: "Unlocked Value", value: "$6.3T", color: .systemGreen))
        metricsStack.addArrangedSubview(createMetricView(title: "Debt Elimination", value: "$1.2T", color: .systemRed))
        metricsStack.addArrangedSubview(createMetricView(title: "UBI per Person", value: "$100K", color: .systemPurple))
        
        stackView.addArrangedSubview(metricsStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
    
    func createMetricView(title: String, value: String, color: UIColor) -> UIView {
        let container = UIView()
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 12
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .secondaryLabel
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 28, weight: .bold)
        valueLabel.textColor = color
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            
            container.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return container
    }
}

class CalculatorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Impact Calculator"
        view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "Calculate your household's UBI impact"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

class AboutViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About"
        view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "The $19 Trillion Solution\nA Tiation & ChaseWhiteRabbit Initiative"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
