import UIKit

struct CluckQuestChickenDetailedFact {
    let title: String
    let emoji: String
    let description: String
    let extraInfo: String
    let category: CluckQuestChickenFactCategory
}

class CluckQuestChickenFactsViewController: UIViewController {
    
    private let CluckQuestChickenCollectionView: UICollectionView
    private let CluckQuestChickenSegmentedControl = UISegmentedControl()
    private let dataManager = CluckQuestChickenDataManager.shared
    private var CluckQuestChickenAllFacts: [CluckQuestChickenFarmFact] = []
    private var CluckQuestChickenFilteredFacts: [CluckQuestChickenFarmFact] = []
    private var CluckQuestChickenDetailedFacts: [CluckQuestChickenDetailedFact] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let CluckQuestChickenLayout = UICollectionViewFlowLayout()
        CluckQuestChickenLayout.minimumInteritemSpacing = 16
        CluckQuestChickenLayout.minimumLineSpacing = 16
        CluckQuestChickenLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        CluckQuestChickenCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CluckQuestChickenLayout)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CluckQuestChickenSetupUI()
        CluckQuestChickenLoadData()
        CluckQuestChickenAddExtraFacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CluckQuestChickenLoadData()
    }
    
    private func CluckQuestChickenSetupUI() {
        title = "Facts"
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        
        CluckQuestChickenSegmentedControl.insertSegment(withTitle: "All", at: 0, animated: false)
        for CluckQuestChickenCategory in CluckQuestChickenFactCategory.allCases {
            CluckQuestChickenSegmentedControl.insertSegment(withTitle: CluckQuestChickenCategory.rawValue, at: CluckQuestChickenSegmentedControl.numberOfSegments, animated: false)
        }
        CluckQuestChickenSegmentedControl.selectedSegmentIndex = 0
        CluckQuestChickenSegmentedControl.addTarget(self, action: #selector(CluckQuestChickenCategoryChanged), for: .valueChanged)
        CluckQuestChickenSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        CluckQuestChickenCollectionView.backgroundColor = .clear
        CluckQuestChickenCollectionView.delegate = self
        CluckQuestChickenCollectionView.dataSource = self
        CluckQuestChickenCollectionView.register(CluckQuestChickenFactCell.self, forCellWithReuseIdentifier: "CluckQuestChickenFactCell")
        CluckQuestChickenCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(CluckQuestChickenSegmentedControl)
        view.addSubview(CluckQuestChickenCollectionView)
        
        NSLayoutConstraint.activate([
            CluckQuestChickenSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            CluckQuestChickenSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            CluckQuestChickenSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            CluckQuestChickenCollectionView.topAnchor.constraint(equalTo: CluckQuestChickenSegmentedControl.bottomAnchor, constant: 16),
            CluckQuestChickenCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            CluckQuestChickenCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            CluckQuestChickenCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func CluckQuestChickenLoadData() {
        CluckQuestChickenAllFacts = dataManager.CluckQuestChickenLoadFacts()
        CluckQuestChickenFilterFacts()
    }
    
    private func CluckQuestChickenAddExtraFacts() {
        let extraFacts: [CluckQuestChickenDetailedFact] = [
            .init(title: "Golden Egg", emoji: "🥚", description: "A rare egg laid by legendary hens.", extraInfo: "Golden eggs are said to bring good luck and prosperity to the farm.", category: .chickens),
            .init(title: "Red Mite", emoji: "🕷️", description: "A common pest in coops.", extraInfo: "Red mites hide in cracks and feed on chickens at night.", category: .pests),
            .init(title: "Water Trough", emoji: "🚰", description: "Essential for hydration.", extraInfo: "Clean water is vital for healthy chickens.", category: .tools),
            .init(title: "Sunflower Seeds", emoji: "🌻", description: "A favorite treat for chickens.", extraInfo: "Rich in healthy fats and vitamins.", category: .plants),
            .init(title: "Broody Hen", emoji: "🐣", description: "A hen that wants to hatch eggs.", extraInfo: "Broody hens will sit on eggs for 21 days.", category: .chickens),
            .init(title: "Fox", emoji: "🦊", description: "A sneaky predator.", extraInfo: "Foxes are clever and can dig under fences.", category: .pests),
            .init(title: "Egg Basket", emoji: "🧺", description: "Used to collect eggs.", extraInfo: "Traditional baskets are woven from willow.", category: .tools),
            .init(title: "Corn", emoji: "🌽", description: "A staple chicken feed.", extraInfo: "Corn provides energy but should be balanced with protein.", category: .plants),
            .init(title: "Rooster", emoji: "🐓", description: "The farm's alarm clock.", extraInfo: "Roosters protect the flock and fertilize eggs.", category: .chickens),
            .init(title: "Mealworm Farm", emoji: "🪱", description: "Grow your own chicken treats.", extraInfo: "Mealworms are a protein-rich snack.", category: .tools),
            .init(title: "Hawk", emoji: "🦅", description: "Aerial predator.", extraInfo: "Hawks hunt during the day and target small chickens.", category: .pests),
            .init(title: "Grit", emoji: "🪨", description: "Helps chickens digest food.", extraInfo: "Chickens need grit to grind grains in their gizzard.", category: .tools),
            .init(title: "Pumpkin", emoji: "🎃", description: "A seasonal treat.", extraInfo: "Pumpkin seeds are a natural dewormer.", category: .plants),
            .init(title: "Silkie", emoji: "🐥", description: "A fluffy chicken breed.", extraInfo: "Silkies are known for their gentle nature and unique feathers.", category: .chickens),
            .init(title: "Rat", emoji: "🐀", description: "Unwanted guest in the feed room.", extraInfo: "Rats steal eggs and can chew through wood.", category: .pests),
            .init(title: "Worm Castings", emoji: "🌱", description: "Natural fertilizer.", extraInfo: "Worm castings enrich soil and boost plant growth.", category: .plants)
        ]
        CluckQuestChickenDetailedFacts = extraFacts
    }
    
    private func CluckQuestChickenFilterFacts() {
        if CluckQuestChickenSegmentedControl.selectedSegmentIndex == 0 {
            CluckQuestChickenFilteredFacts = CluckQuestChickenAllFacts
        } else {
            let CluckQuestChickenSelectedCategory = CluckQuestChickenFactCategory.allCases[CluckQuestChickenSegmentedControl.selectedSegmentIndex - 1]
            CluckQuestChickenFilteredFacts = CluckQuestChickenAllFacts.filter { $0.CluckQuestChickenFactCategory == CluckQuestChickenSelectedCategory }
        }
        CluckQuestChickenCollectionView.reloadData()
    }
    
    @objc private func CluckQuestChickenCategoryChanged() {
        CluckQuestChickenFilterFacts()
    }
}

extension CluckQuestChickenFactsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CluckQuestChickenFilteredFacts.count + CluckQuestChickenDetailedFacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let CluckQuestChickenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CluckQuestChickenFactCell", for: indexPath) as! CluckQuestChickenFactCell
        if indexPath.item < CluckQuestChickenFilteredFacts.count {
            let CluckQuestChickenFact = CluckQuestChickenFilteredFacts[indexPath.item]
            CluckQuestChickenCell.CluckQuestChickenConfigure(with: CluckQuestChickenFact)
        } else {
            let detailed = CluckQuestChickenDetailedFacts[indexPath.item - CluckQuestChickenFilteredFacts.count]
            CluckQuestChickenCell.CluckQuestChickenConfigureDetailed(with: detailed)
        }
        return CluckQuestChickenCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let CluckQuestChickenWidth = (collectionView.bounds.width - 48) / 2
        return CGSize(width: CluckQuestChickenWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < CluckQuestChickenFilteredFacts.count {
            let fact = CluckQuestChickenFilteredFacts[indexPath.item]
            let detailed = CluckQuestChickenDetailedFact(title: fact.CluckQuestChickenFactTitle, emoji: fact.CluckQuestChickenFactEmoji, description: fact.CluckQuestChickenFactDescription, extraInfo: "More info coming soon!", category: fact.CluckQuestChickenFactCategory)
            let detailVC = CluckQuestChickenFactDetailViewController(fact: detailed)
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let detailed = CluckQuestChickenDetailedFacts[indexPath.item - CluckQuestChickenFilteredFacts.count]
            let detailVC = CluckQuestChickenFactDetailViewController(fact: detailed)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

class CluckQuestChickenFactCell: UICollectionViewCell {
    private let CluckQuestChickenCardView = CluckQuestChickenDesignSystem.CluckQuestChickenCreateCardView()
    private let CluckQuestChickenEmojiLabel = UILabel()
    private let CluckQuestChickenTitleLabel = UILabel()
    private let CluckQuestChickenDescriptionLabel = UILabel()
    private let CluckQuestChickenCategoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CluckQuestChickenSetupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func CluckQuestChickenSetupUI() {
        backgroundColor = .clear
        
        CluckQuestChickenEmojiLabel.font = UIFont.systemFont(ofSize: 50)
        CluckQuestChickenEmojiLabel.textAlignment = .center
        
        CluckQuestChickenTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        CluckQuestChickenTitleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenTitleLabel.textAlignment = .center
        CluckQuestChickenTitleLabel.numberOfLines = 2
        
        CluckQuestChickenDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        CluckQuestChickenDescriptionLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        CluckQuestChickenDescriptionLabel.textAlignment = .center
        CluckQuestChickenDescriptionLabel.numberOfLines = 3
        
        CluckQuestChickenCategoryLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        CluckQuestChickenCategoryLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent
        CluckQuestChickenCategoryLabel.textAlignment = .center
        CluckQuestChickenCategoryLabel.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        CluckQuestChickenCategoryLabel.layer.cornerRadius = 8
        CluckQuestChickenCategoryLabel.layer.masksToBounds = true
        
        let CluckQuestChickenStackView = UIStackView(arrangedSubviews: [
            CluckQuestChickenEmojiLabel,
            CluckQuestChickenTitleLabel,
            CluckQuestChickenDescriptionLabel,
            CluckQuestChickenCategoryLabel
        ])
        CluckQuestChickenStackView.axis = .vertical
        CluckQuestChickenStackView.spacing = 8
        CluckQuestChickenStackView.alignment = .center
        CluckQuestChickenStackView.translatesAutoresizingMaskIntoConstraints = false
        
        CluckQuestChickenCardView.addSubview(CluckQuestChickenStackView)
        contentView.addSubview(CluckQuestChickenCardView)
        
        CluckQuestChickenCardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            CluckQuestChickenCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            CluckQuestChickenCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            CluckQuestChickenCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            CluckQuestChickenCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            CluckQuestChickenStackView.topAnchor.constraint(equalTo: CluckQuestChickenCardView.topAnchor, constant: 16),
            CluckQuestChickenStackView.leadingAnchor.constraint(equalTo: CluckQuestChickenCardView.leadingAnchor, constant: 12),
            CluckQuestChickenStackView.trailingAnchor.constraint(equalTo: CluckQuestChickenCardView.trailingAnchor, constant: -12),
            CluckQuestChickenStackView.bottomAnchor.constraint(equalTo: CluckQuestChickenCardView.bottomAnchor, constant: -16),
            
            CluckQuestChickenCategoryLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func CluckQuestChickenConfigure(with CluckQuestChickenFact: CluckQuestChickenFarmFact) {
        CluckQuestChickenEmojiLabel.text = CluckQuestChickenFact.CluckQuestChickenFactEmoji
        CluckQuestChickenTitleLabel.text = CluckQuestChickenFact.CluckQuestChickenFactTitle
        CluckQuestChickenDescriptionLabel.text = CluckQuestChickenFact.CluckQuestChickenFactDescription
        CluckQuestChickenCategoryLabel.text = " \(CluckQuestChickenFact.CluckQuestChickenFactCategory.rawValue) "
    }
    
    func CluckQuestChickenConfigureDetailed(with fact: CluckQuestChickenDetailedFact) {
        CluckQuestChickenEmojiLabel.text = fact.emoji
        CluckQuestChickenTitleLabel.text = fact.title
        CluckQuestChickenDescriptionLabel.text = fact.description
        CluckQuestChickenCategoryLabel.text = " \(fact.category.rawValue) "
    }
}

class CluckQuestChickenFactDetailViewController: UIViewController {
    private let fact: CluckQuestChickenDetailedFact
    private let openDate: String
    private let source: String
    private let funFact: String
    private let history: String
    private let tip: String
    private let quote: String
    private let related: String
    
    init(fact: CluckQuestChickenDetailedFact) {
        self.fact = fact
        self.openDate = "Discovered: " + ["2021-03-14", "2022-07-01", "2023-01-20", "2020-11-05"].randomElement()!
        self.source = "Source: Farmopedia"
        self.funFact = [
            "Did you know? Chickens can remember over 100 faces!",
            "Fun fact: The world record for most eggs laid in one day is 7.",
            "Interesting: Some chickens purr like cats when they are happy.",
            "Trivia: The oldest chicken lived to be 16 years old!"
        ].randomElement()!
        self.history = [
            "Chickens were first domesticated over 8,000 years ago in Southeast Asia.",
            "The ancient Egyptians considered chickens sacred and used them in rituals.",
            "In medieval Europe, chickens were a symbol of prosperity and good fortune.",
            "The Romans spread chickens throughout their empire as a source of food and eggs."
        ].randomElement()!
        self.tip = [
            "Tip: Always provide fresh water and grit for healthy digestion.",
            "Tip: Rotate your chicken's foraging area to keep them active and happy.",
            "Tip: Add herbs like mint and oregano to the coop for natural pest control.",
            "Tip: Collect eggs daily to prevent breakage and broodiness."
        ].randomElement()!
        self.quote = [
            "\"A chicken is the spirit of the barnyard.\" — Old Farmer's Almanac",
            "\"The key to happiness is a warm coop and a full feeder.\"",
            "\"Chickens teach us patience, persistence, and the joy of simple things.\"",
            "\"Every egg is a little miracle.\""
        ].randomElement()!
        self.related = [
            "Related: Ducks, Quails, and Turkeys are also popular farm birds.",
            "Related: Learn about the different types of chicken coops.",
            "Related: Explore the world of rare chicken breeds.",
            "Related: Discover the best plants for a chicken-friendly garden."
        ].randomElement()!
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let card = CluckQuestChickenDesignSystem.CluckQuestChickenCreateCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 18
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        let emojiLabel = UILabel()
        emojiLabel.text = fact.emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 80)
        emojiLabel.textAlignment = .center
        let titleLabel = UILabel()
        titleLabel.text = fact.title
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        titleLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        titleLabel.textAlignment = .center
        let descLabel = UILabel()
        descLabel.text = fact.description
        descLabel.font = UIFont.systemFont(ofSize: 18)
        descLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        let extraLabel = UILabel()
        extraLabel.text = fact.extraInfo
        extraLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        extraLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent
        extraLabel.textAlignment = .center
        extraLabel.numberOfLines = 0
        let historyTitle = sectionTitle("History")
        let historyLabel = sectionBody(history)
        let tipTitle = sectionTitle("Tip")
        let tipLabel = sectionBody(tip)
        let funFactTitle = sectionTitle("Fun Fact")
        let funFactLabel = sectionBody(funFact)
        let quoteTitle = sectionTitle("Quote")
        let quoteLabel = sectionBody(quote)
        let relatedTitle = sectionTitle("Related")
        let relatedLabel = sectionBody(related)
        let openDateLabel = UILabel()
        openDateLabel.text = openDate
        openDateLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        openDateLabel.textColor = .gray
        openDateLabel.textAlignment = .center
        let sourceLabel = UILabel()
        sourceLabel.text = source
        sourceLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        sourceLabel.textColor = .gray
        sourceLabel.textAlignment = .center
        stack.addArrangedSubview(emojiLabel)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descLabel)
        stack.addArrangedSubview(extraLabel)
        stack.addArrangedSubview(historyTitle)
        stack.addArrangedSubview(historyLabel)
        stack.addArrangedSubview(tipTitle)
        stack.addArrangedSubview(tipLabel)
        stack.addArrangedSubview(funFactTitle)
        stack.addArrangedSubview(funFactLabel)
        stack.addArrangedSubview(quoteTitle)
        stack.addArrangedSubview(quoteLabel)
        stack.addArrangedSubview(relatedTitle)
        stack.addArrangedSubview(relatedLabel)
        stack.addArrangedSubview(openDateLabel)
        stack.addArrangedSubview(sourceLabel)
        card.addSubview(stack)
        contentView.addSubview(card)
        scroll.addSubview(contentView)
        view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scroll.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -24)
        ])
    }
    private func sectionTitle(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        label.textAlignment = .left
        return label
    }
    private func sectionBody(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
} 
