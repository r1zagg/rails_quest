class Quest2StudentService
  class << self
    # @return [String]
    def all_agents
      Agent.order(:codename).pluck(:codename).join("\n")
    end

    # @return [String]
    def all_missions
      Mission.order(:title).pluck(:title).join("\n")
    end

    # @return [String]
    def agents_with_missions
      Agent.order(:codename).map do |agent|
    missions = agent.missions.order(:title).pluck(:title).join(", ")
    "#{agent.codename}: #{missions}"
  end.join("\n")
    end

    # @return [String]
    def agents_with_missions_sorted_by_mission_count
agents = Agent.includes(:missions).all
  sorted = agents.sort_by { |a| [ -a.missions.count, a.codename ] }
  sorted.map do |agent|
    missions = agent.missions.order(:title).pluck(:title).join(", ")
    "#{agent.codename} (#{agent.missions.count}): #{missions}"
  end.join("\n")
    end

    # @return [String]
    def agents_with_skills
      Agent.order(:codename).map do |agent|
    skills = agent.skills.order(:name).pluck(:name).join(", ")
    "#{agent.codename}: #{skills}"
  end.join("\n")
    end

    # @return [String]
    def skills_by_agent_count
      skills = Skill.joins(:agents)
                .group(:id, :name)
                .select("skills.id, skills.name, COUNT(agents.id) AS agents_count")
                .order("agents_count DESC, skills.name ASC")

  skills.map do |skill|
    # Получаем отсортированных по имени агентов для этого навыка
    agents = Agent.joins(:skills)
                  .where(skills: { id: skill.id })
                  .order(:codename)
                  .pluck(:codename)
                  .join(", ")
    "#{skill.name} (#{skill.agents_count}): #{agents}"
  end.join("\n")
    end
  end
end
