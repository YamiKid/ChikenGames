import UIKit

class CluckQuestImageSelectionViewController: UIViewController {
    private let CluckQuestImages = [
        (name: "CluckQuestChickenImg1", emoji: "🐔🌾"),
        (name: "CluckQuestChickenImg2", emoji: "🐄🍃"),
        (name: "CluckQuestChickenImg3", emoji: "🐖🍯")
    ]
    private let CluckQuestScrollView = UIScrollView()
    private let CluckQuestContentStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Select Image"
        CluckQuestSetupUI()
    }
    
    private func CluckQuestSetupUI() {
        CluckQuestScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CluckQuestScrollView)
        NSLayoutConstraint.activate([
            CluckQuestScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            CluckQuestScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            CluckQuestScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            CluckQuestScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        CluckQuestContentStack.axis = .vertical
        CluckQuestContentStack.spacing = 36
        CluckQuestContentStack.alignment = .center
        CluckQuestContentStack.translatesAutoresizingMaskIntoConstraints = false
        CluckQuestScrollView.addSubview(CluckQuestContentStack)
        NSLayoutConstraint.activate([
            CluckQuestContentStack.topAnchor.constraint(equalTo: CluckQuestScrollView.topAnchor, constant: 32),
            CluckQuestContentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            CluckQuestContentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            CluckQuestContentStack.bottomAnchor.constraint(equalTo: CluckQuestScrollView.bottomAnchor, constant: -32),
            CluckQuestContentStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64)
        ])
        for (i, img) in CluckQuestImages.enumerated() {
            let card = UIView()
            card.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.withAlphaComponent(0.85)
            card.layer.cornerRadius = 20
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowOpacity = 0.1
            card.layer.shadowRadius = 6
            card.layer.shadowOffset = CGSize(width: 0, height: 2)
            card.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent.cgColor
            card.layer.borderWidth = 2
            card.translatesAutoresizingMaskIntoConstraints = false
            card.heightAnchor.constraint(equalToConstant: 240).isActive = true
            let emoji = UILabel()
            emoji.text = img.emoji
            emoji.font = UIFont.systemFont(ofSize: 38)
            emoji.textAlignment = .center
            emoji.translatesAutoresizingMaskIntoConstraints = false
            let imageView = UIImageView(image: UIImage(named: img.name))
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            let title = UILabel()
            title.text = img.name
            title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            title.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
            title.textAlignment = .center
            title.translatesAutoresizingMaskIntoConstraints = false
            let select = UIButton(type: .system)
            select.setTitle("Select", for: .normal)
            select.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            select.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent, for: .normal)
            select.layer.cornerRadius = 14
            select.layer.borderWidth = 2
            select.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent.cgColor
            select.backgroundColor = .white
            select.translatesAutoresizingMaskIntoConstraints = false
            select.widthAnchor.constraint(equalToConstant: 120).isActive = true
            select.heightAnchor.constraint(equalToConstant: 44).isActive = true
            select.tag = i
            select.addTarget(self, action: #selector(CluckQuestSelectTapped(_:)), for: .touchUpInside)
            let vstack = UIStackView(arrangedSubviews: [emoji, imageView, title, select])
            vstack.axis = .vertical
            vstack.alignment = .center
            vstack.spacing = 10
            vstack.translatesAutoresizingMaskIntoConstraints = false
            card.addSubview(vstack)
            NSLayoutConstraint.activate([
                vstack.centerXAnchor.constraint(equalTo: card.centerXAnchor),
                vstack.centerYAnchor.constraint(equalTo: card.centerYAnchor),
                vstack.leadingAnchor.constraint(greaterThanOrEqualTo: card.leadingAnchor, constant: 12),
                vstack.trailingAnchor.constraint(lessThanOrEqualTo: card.trailingAnchor, constant: -12)
            ])
            CluckQuestContentStack.addArrangedSubview(card)
            NSLayoutConstraint.activate([
                card.leadingAnchor.constraint(equalTo: CluckQuestContentStack.leadingAnchor),
                card.trailingAnchor.constraint(equalTo: CluckQuestContentStack.trailingAnchor)
            ])
        }
    }
    
    @objc private func CluckQuestSelectTapped(_ sender: UIButton) {
        let img = CluckQuestImages[sender.tag].name
        let vc = CluckQuestPuzzleDifficultyViewController()
        vc.CluckQuestSelectedImage = img
        navigationController?.pushViewController(vc, animated: true)
    }
} 