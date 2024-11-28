import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // MARK: - Данные о блюдах
    private var dishes: [(image: UIImage?, title: String, price: String, descriptionDishes: String?)] = [
        (UIImage(named: "backgroundImage"), "Паста с соусом", "$15.99","Классическая итальянская паста с насыщенным томатным соусом, свежим базиликом и щедрой порцией пармезана. Это блюдо подарит вам настоящее ощущение итальянского вечера."),
        (UIImage(named: "backgroundImage"), "Пицца Маргарита", "$12.49","Легендарная пицца с тонким хрустящим тестом, ароматным томатным соусом, свежей моцареллой и базиликом. Идеальный выбор для любителей минимализма и изысканного вкуса."),
        (UIImage(named: "backgroundImage"), "Салат Цезарь", "$10.99","Хрустящий салат с листьями ромена, нежной курицей на гриле, чесночными крутонами и классической заправкой Цезарь. Сверху посыпан пармезаном для идеального вкусового баланса."),
        (UIImage(named: "backgroundImage"), "Суп дня", "$7.99","Ароматный суп, приготовленный из свежих ингредиентов сезона. Вкусное и питательное блюдо, которое согреет и подарит энергию на весь день."),
        (UIImage(named: "backgroundImage"), "Паста с соусом", "$15.99","Классическая итальянская паста с насыщенным томатным соусом, свежим базиликом и щедрой порцией пармезана. Это блюдо подарит вам настоящее ощущение итальянского вечера."),
        (UIImage(named: "backgroundImage"), "Пицца Маргарита", "$12.49","Легендарная пицца с тонким хрустящим тестом, ароматным томатным соусом, свежей моцареллой и базиликом. Идеальный выбор для любителей минимализма и изысканного вкуса."),
        (UIImage(named: "backgroundImage"), "Салат Цезарь", "$10.99","Хрустящий салат с листьями ромена, нежной курицей на гриле, чесночными крутонами и классической заправкой Цезарь. Сверху посыпан пармезаном для идеального вкусового баланса."),
        (UIImage(named: "backgroundImage"), "Суп дня", "$7.99","Ароматный суп, приготовленный из свежих ингредиентов сезона. Вкусное и питательное блюдо, которое согреет и подарит энергию на весь день.")
       
    ]
    
    // MARK: - Элементы интерфейса
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let searchField: UITextField = {
        let field = UITextField()
        field.placeholder = "Найти"
        field.backgroundColor = .lightGray
        field.textColor = .white
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "line.3.horizontal.decrease.circle"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "getStartedColor")
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(searchField)
        view.addSubview(filterButton)
        view.addSubview(tableView)
        
        setupConstraints()
        
        // Настройка делегатов
        searchField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // Регистрация ячейки
        tableView.register(DishTableViewCell.self, forCellReuseIdentifier: DishTableViewCell.identifier)
        tableView.allowsSelection = true // Включаем выбор ячеек
        
        // Жест для скрытия клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Настройка констрейнтов
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Поле поиска
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8),
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            
            // Кнопка фильтра
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            filterButton.widthAnchor.constraint(equalTo: searchField.heightAnchor),
            filterButton.heightAnchor.constraint(equalTo: searchField.heightAnchor),
            
            // Таблица
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Методы UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = dishes[indexPath.row]
        let detailVC = DetailViewController()
        // Передача данных в detailVC при необходимости
        detailVC.dishImage = row.image
        detailVC.dishTitle = row.title
        detailVC.dishPrice = row.price
        detailVC.dishDescription = row.descriptionDishes
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier, for: indexPath) as? DishTableViewCell else {
            return UITableViewCell()
        }
        let dish = dishes[indexPath.row]
        cell.configure(image: dish.image, title: dish.title, price: dish.price)
        
        // Устанавливаем обработчик кнопки "Добавить"
        cell.onAddButtonTap = {
            print("Добавлено: \(dish.title)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Высота ячейки
    }
    
    // MARK: - Методы для работы с клавиатурой
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
class DishTableViewCell: UITableViewCell {
    static let identifier = "DishTableViewCell"
    
    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor(named: "getStartedColor")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Замыкание для обработки нажатия кнопки "Добавить"
    var onAddButtonTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Отключаем стиль выделения
        selectionStyle = .none
        
        contentView.addSubview(dishImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?, title: String, price: String) {
        dishImageView.image = image
        titleLabel.text = title
        priceLabel.text = price
        selectionStyle = .none
        
        contentView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dishImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            dishImageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: addToCartButton.leadingAnchor, constant: -8),
            
            priceLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addToCartButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: 80),
            addToCartButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupActions() {
        addToCartButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        onAddButtonTap?()
    }
}
