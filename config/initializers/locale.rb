I18n.config.available_locales = :fr
I18n.default_locale = :fr

require 'date'
require 'active_support/core_ext/date/conversions'
require 'active_support/core_ext/time/conversions'

Date::DATE_FORMATS.merge!(
  default: "%d/%m/%Y",
  short: "%d %b",
  long: "%d %B %Y"
)

Time::DATE_FORMATS.merge!(
  default: "%d/%m/%Y %H:%M",
  short: "%d %b %H:%M",
  long: "%d %B %Y %H:%M"
)
