class CoronavirusLocalRestrictionsConstraint
  def matches?(*)
    return true unless Rails.env.production?

    false
  end
end
