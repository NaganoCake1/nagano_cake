module ApplicationHelper
  def number_to_currency(price)
    "#{price.to_formatted_s(:delimited, delimiter: ',')}"
  end
end
