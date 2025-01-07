class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  around_action :switch_locale

  private

  def switch_locale(&action)
    # Lấy locale từ tham số URL, nếu không có thì sử dụng ngôn ngữ mặc định
    locale = params[:locale].presence&.to_sym

    # Kiểm tra nếu locale hợp lệ, nếu không thì dùng locale mặc định
    if locale && I18n.available_locales.include?(locale)
      I18n.with_locale(locale, &action)
    else
      # Nếu locale không hợp lệ, log cảnh báo và dùng locale mặc định
      Rails.logger.warn("Invalid locale '#{locale}', falling back to default locale '#{I18n.default_locale}'")
      I18n.with_locale(I18n.default_locale, &action)
    end
  end
end
