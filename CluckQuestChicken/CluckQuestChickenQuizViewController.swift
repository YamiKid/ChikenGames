import UIKit

struct CluckQuestChickenQuizQuestion {
    let question: String
    let answers: [String]
    let correct: Int
}

class CluckQuestChickenQuizViewController: UIViewController {
    private var questions: [CluckQuestChickenQuizQuestion] = []
    private var current = 0
    private var correctCount = 0
    private let stack = UIStackView()
    private let questionLabel = UILabel()
    private let answersStack = UIStackView()
    private let nextButton = UIButton(type: .system)
    private let dataManager = CluckQuestChickenDataManager.shared
    private var answerOrder: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CluckQuestChickenDesignSystem.CluckQuestChickenMintPasture
        title = "Farm Quiz"
        setupQuestions()
        setupUI()
        showQuestion()
    }

    private func setupQuestions() {
        let pool: [CluckQuestChickenQuizQuestion] = CluckQuestChickenQuizViewController.quizPool
        questions = Array(pool.shuffled().prefix(10))
    }

    private func setupUI() {
        stack.axis = .vertical
        stack.spacing = 32
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        questionLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        questionLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        answersStack.axis = .vertical
        answersStack.spacing = 16
        answersStack.alignment = .center
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nextButton.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenMossAccent, for: .normal)
        nextButton.backgroundColor = .white
        nextButton.layer.cornerRadius = 14
        nextButton.layer.borderWidth = 2
        nextButton.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.cgColor
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        stack.addArrangedSubview(questionLabel)
        stack.addArrangedSubview(answersStack)
        stack.addArrangedSubview(nextButton)
    }

    private func showQuestion() {
        guard current < questions.count else { showResult(); return }
        let q = questions[current]
        questionLabel.text = "Q\(current+1): " + q.question
        answersStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let indices = Array(0..<q.answers.count).shuffled()
        answerOrder = indices
        for (btnIdx, ansIdx) in indices.enumerated() {
            let ans = q.answers[ansIdx]
            let btn = UIButton(type: .system)
            btn.setTitle(ans, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            btn.setTitleColor(CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText, for: .normal)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 12
            btn.layer.borderWidth = 1.5
            btn.layer.borderColor = CluckQuestChickenDesignSystem.CluckQuestChickenPistachioGrove.cgColor
            btn.tag = btnIdx
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
            btn.widthAnchor.constraint(equalToConstant: 220).isActive = true
            btn.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
            answersStack.addArrangedSubview(btn)
        }
        nextButton.isHidden = true
    }

    @objc private func answerTapped(_ sender: UIButton) {
        let q = questions[current]
        let correctTag = answerOrder.firstIndex(of: q.correct) ?? 0
        if sender.tag == correctTag {
            sender.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
            correctCount += 1
        } else {
            sender.backgroundColor = UIColor.systemRed.withAlphaComponent(0.3)
        }
        for (idx, btn) in answersStack.arrangedSubviews.enumerated() {
            guard let btn = btn as? UIButton else { continue }
            btn.isEnabled = false
            if idx == correctTag {
                btn.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
            }
        }
        nextButton.isHidden = false
    }

    @objc private func nextTapped() {
        current += 1
        showQuestion()
    }

    private func showResult() {
        let xp = correctCount * 10
        let coins = correctCount * 5
        dataManager.addXP(xp)
        dataManager.addCoins(coins)
        let alert = UIAlertController(title: "Quiz Complete!", message: "Correct: \(correctCount)/10\n+\(xp) XP, +\(coins) Coins", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }


    static let quizPool: [CluckQuestChickenQuizQuestion] = [
        .init(question: "What do chickens lay?", answers: ["Eggs", "Milk", "Wool", "Corn"], correct: 0),
        .init(question: "What is a baby chicken called?", answers: ["Chick", "Duckling", "Calf", "Piglet"], correct: 0),
        .init(question: "Which animal says 'cluck'?", answers: ["Chicken", "Cow", "Sheep", "Horse"], correct: 0),
        .init(question: "What color are most chicken eggs?", answers: ["White or Brown", "Blue", "Green", "Red"], correct: 0),
        .init(question: "What do chickens eat?", answers: ["Grain", "Fish", "Grass", "Meat"], correct: 0),
        .init(question: "Which part of the chicken lays eggs?", answers: ["Hen", "Rooster", "Chick", "Duck"], correct: 0),
        .init(question: "What is a group of chickens called?", answers: ["Flock", "Herd", "Pack", "School"], correct: 0),
        .init(question: "What do you call a male chicken?", answers: ["Rooster", "Hen", "Chick", "Duck"], correct: 0),
        .init(question: "Which of these is NOT a chicken breed?", answers: ["Golden Retriever", "Leghorn", "Silkie", "Rhode Island Red"], correct: 0),
        .init(question: "What do chickens use to peck food?", answers: ["Beak", "Claws", "Wings", "Tail"], correct: 0),
        .init(question: "What is the red flap on a chicken's head called?", answers: ["Comb", "Wattle", "Crest", "Crown"], correct: 0),
        .init(question: "What is the red skin under a chicken's beak called?", answers: ["Wattle", "Comb", "Crest", "Crown"], correct: 0),
        .init(question: "Which sense is strongest in chickens?", answers: ["Sight", "Smell", "Taste", "Hearing"], correct: 0),
        .init(question: "How many legs does a chicken have?", answers: ["2", "4", "6", "8"], correct: 0),
        .init(question: "What do chickens do to keep clean?", answers: ["Dust bathe", "Swim", "Lick fur", "Roll in mud"], correct: 0),
        .init(question: "What is a chicken's home called?", answers: ["Coop", "Barn", "Kennel", "Stable"], correct: 0),
        .init(question: "Which of these is a chicken predator?", answers: ["Fox", "Cow", "Sheep", "Goat"], correct: 0),
        .init(question: "What do chickens need to make eggs?", answers: ["Calcium", "Salt", "Sugar", "Pepper"], correct: 0),
        .init(question: "What is the process of sitting on eggs to hatch them?", answers: ["Brooding", "Molting", "Roosting", "Pecking"], correct: 0),
        .init(question: "What do chickens sleep on?", answers: ["Roost", "Nest", "Ground", "Water"], correct: 0),
        .init(question: "What is a chicken's main food?", answers: ["Grain", "Fish", "Fruit", "Meat"], correct: 0),
        .init(question: "Which vitamin is found in eggs?", answers: ["Vitamin D", "Vitamin C", "Vitamin K", "Vitamin B12"], correct: 0),
        .init(question: "What is the outer covering of an egg called?", answers: ["Shell", "Yolk", "White", "Membrane"], correct: 0),
        .init(question: "What is the yellow part of an egg?", answers: ["Yolk", "White", "Shell", "Membrane"], correct: 0),
        .init(question: "What is the white part of an egg?", answers: ["Albumen", "Yolk", "Shell", "Membrane"], correct: 0),
        .init(question: "How long does it take to hatch a chicken egg?", answers: ["21 days", "7 days", "14 days", "28 days"], correct: 0),
        .init(question: "What is it called when chickens lose feathers?", answers: ["Molting", "Brooding", "Roosting", "Pecking"], correct: 0),
        .init(question: "What do chickens use their wings for?", answers: ["Balance", "Flying long distances", "Swimming", "Digging"], correct: 0),
        .init(question: "What is a chicken's favorite treat?", answers: ["Corn", "Fish", "Cheese", "Chocolate"], correct: 0),
        .init(question: "What is the best bedding for a chicken coop?", answers: ["Straw", "Sand", "Leaves", "Plastic"], correct: 0),
        .init(question: "What is a chicken's main defense?", answers: ["Running", "Biting", "Hiding", "Swimming"], correct: 0),
        .init(question: "What is a pullet?", answers: ["Young hen", "Old hen", "Male chick", "Rooster"], correct: 0),
        .init(question: "What is a cockerel?", answers: ["Young rooster", "Old rooster", "Female chick", "Hen"], correct: 0),
        .init(question: "What is the process of changing feathers called?", answers: ["Molting", "Brooding", "Roosting", "Pecking"], correct: 0),
        .init(question: "What is the main reason for keeping chickens?", answers: ["Eggs", "Milk", "Wool", "Honey"], correct: 0),
        .init(question: "What is the best way to protect chickens from predators?", answers: ["Fencing", "Swimming", "Digging", "Flying"], correct: 0),
        .init(question: "What is a chicken's beak used for?", answers: ["Eating", "Flying", "Swimming", "Sleeping"], correct: 0),
        .init(question: "What is the best time to collect eggs?", answers: ["Morning", "Evening", "Night", "Afternoon"], correct: 0),
        .init(question: "What is a chicken's favorite weather?", answers: ["Mild", "Snowy", "Rainy", "Windy"], correct: 0),
        .init(question: "What is the main color of a Rhode Island Red chicken?", answers: ["Red", "White", "Black", "Yellow"], correct: 0),
        .init(question: "What is the main color of a Leghorn chicken?", answers: ["White", "Red", "Black", "Brown"], correct: 0),
        .init(question: "What is the main color of a Silkie chicken?", answers: ["White", "Red", "Black", "Brown"], correct: 0),
        .init(question: "What is the main color of a Plymouth Rock chicken?", answers: ["Barred", "Red", "White", "Black"], correct: 0),
        .init(question: "What is the main use of a rooster?", answers: ["Fertilizing eggs", "Laying eggs", "Brooding", "Molting"], correct: 0),
        .init(question: "What is the best way to keep chickens healthy?", answers: ["Clean coop", "Dirty coop", "No water", "No food"], correct: 0),
        .init(question: "What is the best way to keep chickens cool?", answers: ["Shade", "Fire", "Blanket", "Heater"], correct: 0),
        .init(question: "What is the best way to keep chickens warm?", answers: ["Heater", "Fan", "Ice", "Water"], correct: 0),
        .init(question: "What is the best way to feed chickens?", answers: ["Balanced diet", "Only corn", "Only bread", "Only grass"], correct: 0),
        .init(question: "What is the best way to water chickens?", answers: ["Clean water", "Dirty water", "No water", "Juice"], correct: 0),
        .init(question: "What is the best way to collect eggs?", answers: ["Gently", "Quickly", "Roughly", "Loudly"], correct: 0),
        .init(question: "What is the best way to handle chickens?", answers: ["Gently", "Roughly", "Quickly", "Loudly"], correct: 0)
    ]
} 
