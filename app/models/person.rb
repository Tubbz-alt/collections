require "active_model"

class Person
  include ActiveModel::Model

  attr_reader :content_item

  def initialize(content_item)
    @content_item = content_item
  end

  def self.find!(base_path)
    content_item = ContentItem.find!(base_path)
    new(content_item)
  end

  def base_path
    @content_item.content_item_data["base_path"]
  end

  def title
    @content_item.content_item_data["title"]
  end

  def current_roles_title
    current_roles.map { |role| role["title"] }.to_sentence
  end

  def image_url
    details.dig("image", "url")
  end

  def image_alt_text
    details.dig("image", "alt_text")
  end

  def biography
    details["body"]
  end

  def previous_appointments
    ordered_previous_appointments.map do |role|
      {
        link: {
          text: role["title"],
          path: role["base_path"],
        },
        metadata: {
          appointment_duration: "#{role['start_year']} to #{role['end_year']}",
        },
      }
    end
  end

private

  def current_roles
    links.fetch("ordered_current_appointments", [])
      .map { |appointment| appointment["links"]["role"].first }
  end

  def links
    @content_item.content_item_data["links"]
  end

  def details
    @content_item.content_item_data["details"]
  end

  def ordered_previous_appointments
    links["ordered_previous_appointments"].map do |previous_appointment|
      role = previous_appointment["links"]["role"].first
      role["start_year"] = Time.parse(previous_appointment["details"]["started_on"]).strftime("%Y")
      role["end_year"] = Time.parse(previous_appointment["details"]["ended_on"]).strftime("%Y")
      role
    end
  end
end
