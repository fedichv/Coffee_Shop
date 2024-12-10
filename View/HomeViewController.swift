import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate{
    //Отфильтрованные блюда
    private var filteredDishes: [(image: UIImage?, title: String, price: String, descriptionDishes: String?)] = []
    // MARK: - Данные о блюдах
    private var dishes: [(image: UIImage?, title: String, price: String, descriptionDishes: String?)] = [
        (UIImage(named: "Pasta"), "Паста с соусом", "$15.99", "Классическая итальянская паста с насыщенным томатным соусом, свежим базиликом и щедрой порцией пармезана."),
        (UIImage(named: "Pizza"), "Пицца Маргарита", "$12.49", "Легендарная пицца с тонким хрустящим тестом."),
        (UIImage(named: "Salad"), "Салат Цезарь", "$10.99", "Хрустящий салат с курицей на гриле."),
        (UIImage(named: "Soup"), "Суп дня", "$7.99", "Ароматный суп из свежих ингредиентов."),
        (UIImage(named: "PastaBolognese"), "Паста Болоньезе", "$16.99", "Настоящее ощущение итальянского вечера с густым мясным соусом."),
        (UIImage(named: "FourCheesePizza"), "Пицца Четыре сыра", "$14.99", "Идеальный выбор для любителей сыра."),
        (UIImage(named: "GreekSalad"), "Греческий салат", "$11.49", "Свежие овощи с мягким сыром фета и оливковым маслом."),
        (UIImage(named: "CarbonaraPasta"), "Паста Карбонара", "$15.49", "Традиционная паста с беконом, яйцом и пармезаном."),
        (UIImage(named: "PepperoniPizza"), "Пицца Пепперони", "$13.99", "Острая пицца с колбасками пепперони."),
        (UIImage(named: "SaladNicoise"), "Салат Нисуаз", "$12.99", "Французский салат с тунцом, яйцом и оливками."),
        (UIImage(named: "Cream of Mushroom Soup"), "Грибной крем-суп", "$9.99", "Нежный суп с лесными грибами и сливками."),
        (UIImage(named: "AlfredoPasta"), "Паста Альфредо", "$15.99", "Кремовая паста с курицей и грибами."),
        (UIImage(named: "HawaiianPizza"), "Пицца Гавайская", "$12.99", "Сочная пицца с ананасами и ветчиной."),
        (UIImage(named: "ArugulaSalad"), "Салат с рукколой", "$10.49", "Свежая руккола с томатами и сыром пармезан."),
        (UIImage(named: "TomatoSoup"), "Томатный суп", "$7.49", "Суп с томатами и ароматными травами."),
        (UIImage(named: "RicottaRavioli"), "Равиоли с рикоттой", "$16.49", "Ручной работы равиоли с рикоттой и шпинатом."),
        (UIImage(named: "DiabloPizza"), "Пицца Диабло", "$14.49", "Острая пицца с острым соусом и колбасками."),
        (UIImage(named: "SalmonSalad"), "Салат с лососем", "$13.49", "Салат с кусочками слабосолёного лосося и свежими овощами."),
        (UIImage(named: "Chicken Soup"), "Куриный суп", "$6.99", "Традиционный куриный суп с домашними овощами.")
    ]
    
    // MARK: - Данные о промо-акциях
    private var promotions: [(image: UIImage?, title: String)] = [
        (UIImage(named: "Promotion"), "Скидка 20%"),
        (UIImage(named: "Promotion2"), "1+1 на пиццу"),
        (UIImage(named: "Promotion3"), "Кофе в подарок"),
        (UIImage(named: "Promotion4"), "Бесплатная доставка")
    ]
    
    // MARK: - Элементы интерфейса
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            return HomeViewController.createSectionLayout(sectionIndex: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
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
        button.backgroundColor = UIColor(named: "getStartedColor")
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        searchField.delegate = self
        
        filteredDishes = dishes
        collectionView.reloadData()
        
        // Добавление элементов на экран
        view.addSubview(searchField)
        view.addSubview(filterButton)
        view.addSubview(collectionView)
        
        // Установка констрейнтов
        setupConstraints()
        let searchText = searchField.text ?? ""
        search(textDidChange: searchText)
        
        // Настройка коллекций
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: DishCollectionViewCell.identifier)
        collectionView.register(PromotionCollectionViewCell.self, forCellWithReuseIdentifier: PromotionCollectionViewCell.identifier)
        
        // Жест для скрытия клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Настройка констрейнтов
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8),
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            filterButton.widthAnchor.constraint(equalTo: searchField.heightAnchor),
            filterButton.heightAnchor.constraint(equalTo: searchField.heightAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // Ничего не делаем для секции 0 (промо-акции)
            return
        } else if indexPath.section == 1 {
            // Обрабатываем переход только для блюд
            let selectedDish = filteredDishes[indexPath.item]
            
            let detailVC = DetailViewController()
            detailVC.dishImage = selectedDish.image
            detailVC.dishTitle = selectedDish.title
            detailVC.dishPrice = selectedDish.price
            detailVC.dishDescription = selectedDish.descriptionDishes
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 // 0 — Промо, 1 — Блюда
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return promotions.count // Промо-акции
        case 1: return filteredDishes.count // Блюда
        default: return 0
        }
    }
    
    private static func createSectionLayout(sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
        case 0: // Промо-акции (горизонтальный скролл)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(4)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
            return section
            
        case 1: // Блюда (вертикальный скролл)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(250))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(260))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        default:
            return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 { // Промо-акции
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionViewCell.identifier, for: indexPath) as? PromotionCollectionViewCell else {
                return UICollectionViewCell()
            }
            let promotion = promotions[indexPath.item]
            cell.configure(with: promotion.image)
            return cell
        }
        
        // Блюда
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCollectionViewCell.identifier, for: indexPath) as? DishCollectionViewCell else {
            return UICollectionViewCell()
        }
        let dish = filteredDishes[indexPath.item]
        cell.configure(image: dish.image, title: dish.title, price: dish.price)
        return cell
    }
    // MARK: - Методы для работы с клавиатурой
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - Подключение обработки изменений текста
extension HomeViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Обновление фильтрации
        search(textDidChange: updatedText)
        return true
    }
}
// MARK: - Обновление метода поиска
extension HomeViewController {
    func search(textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredDishes = dishes
        } else {
            filteredDishes = dishes.filter { dish in
                dish.title.localizedCaseInsensitiveContains(searchText) ||
                (dish.descriptionDishes?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
        collectionView.reloadData() // Обновление коллекции
    }
    
    // MARK: - Ячейка для UICollectionView
    class DishCollectionViewCell: UICollectionViewCell {
        static let identifier = "DishCollectionViewCell"
        
        private let dishImageView: UIImageView = {
            // Изображение блюда
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 8 // Скругленные углы
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private let titleLabel: UILabel = {
            // Заголовок блюда
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let priceLabel: UILabel = {
            // Цена блюда
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .darkGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let addToCartButton: UIButton = {
            // Кнопка добавления
            let button = UIButton(type: .system)
            button.setTitle("Добавить", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.backgroundColor = UIColor(named: "getStartedColor")
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        var onAddButtonTap: (() -> Void)?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            // Настройка внешнего вида ячейки
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 8
            contentView.layer.borderWidth = 1 // Толщина границы
            contentView.layer.borderColor = UIColor.lightGray.cgColor // Цвет границы
            
            // Добавляем элементы в ячейку
            contentView.addSubview(dishImageView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(priceLabel)
            contentView.addSubview(addToCartButton)
            
            // Устанавливаем констрейнты
            setupConstraints()
            setupActions()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Настройка ячейки
        func configure(image: UIImage?, title: String, price: String) {
            dishImageView.image = image
            titleLabel.text = title
            priceLabel.text = price
        }
        
        // Констрейнты элементов
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                dishImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                dishImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
                
                titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 8),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                
                priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                
                addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                addToCartButton.widthAnchor.constraint(equalToConstant: 80),
                addToCartButton.heightAnchor.constraint(equalToConstant: 32)
            ])
        }
        
        // Настройка действий
        private func setupActions() {
            addToCartButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        }
        
        @objc private func addButtonTapped() {
            onAddButtonTap?()
        }
    }
    class PromotionCollectionViewCell: UICollectionViewCell {
        static let identifier = "PromotionCollectionViewCell"
        private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill // подгоняят под размер
            imageView.clipsToBounds = true // Отключить обрезание
            imageView.layer.cornerRadius = 8
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),      // Отступ сверху
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), // Отступ слева
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), // Отступ справа
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)  // Отступ снизу
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(with image: UIImage?) {
            imageView.image = image
        }
    }
}
