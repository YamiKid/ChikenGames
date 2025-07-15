private func CluckQuestChickenSetupUI() {
    backgroundColor = .clear
    selectionStyle = .none
    // ... existing code ...
    CluckQuestChickenDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
    CluckQuestChickenDescriptionLabel.textColor = CluckQuestChickenDesignSystem.CluckQuestChickenBarnwoodText
    CluckQuestChickenDescriptionLabel.numberOfLines = 0
    // ... existing code ...
}

extension CluckQuestChickenAchievementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CluckQuestChickenAchievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CluckQuestChickenCell = tableView.dequeueReusableCell(withIdentifier: "CluckQuestChickenAchievementCell", for: indexPath) as! CluckQuestChickenAchievementCell
        let CluckQuestChickenAchievement = CluckQuestChickenAchievements[indexPath.row]
        CluckQuestChickenCell.CluckQuestChickenConfigure(with: CluckQuestChickenAchievement)
        return CluckQuestChickenCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
} 