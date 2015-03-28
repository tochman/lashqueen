module ApplicationHelper
  
  def active_nav_item(item)
    @active_nav_item = item
  end
  
  def link_to(name, options = nil, html_options = nil, &block)
    if html_options && @active_nav_item && @active_nav_item == html_options[:nav_item] 
      html_options[:class] = 'active'
    end
    super
  end

  def procuct_categories
    Shoppe::ProductCategory.where.not(name: 'Kurser').ordered
  end

  def service_category
    Shoppe::ProductCategory.where(name: 'Kurser').first
  end
  
  def markdown(text)
    return '' if text.blank?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown.render(text).html_safe
  end
  
  def next_delivery_cutoff
    fourpm = Time.now.change(:hour => 16, :minute => 0)
    fourpm = (fourpm + 1.day).change(:hour => 16, :minute => 0) if fourpm < Time.now
    fourpm = (fourpm + 1.day).change(:hour => 16, :minute => 0) if fourpm.sunday?
    fourpm = (fourpm + 2.day).change(:hour => 16, :minute => 0) if fourpm.saturday?
    fourpm
  end
  
  def time_until_next_delivery_cut_off
    minutes = (next_delivery_cutoff - Time.now) / 60
    whole_hours = (minutes / 60).floor
    remaining_minutes = (minutes - (whole_hours * 60)).to_i
    Array.new.tap do |a|
      a << sv_pluralize(whole_hours, 'timme') if whole_hours > 0
      a << sv_pluralize(remaining_minutes, 'minuter') if remaining_minutes > 0
    end.to_sentence
  end
  
  def next_delivery_day
    date = next_delivery_cutoff.to_date + 1.day
    case date
    when Date.tomorrow
      'i morgon'
    else
      'på ' + sv_weekdays(date).to_s
    end
  end

  def sv_weekdays(date)
    case date.strftime('%A')
      when 'Monday'
        'måndag'
      when 'Tuesday'
        'tisdag'
      when 'Wednesday'
        'onsdag'
      when 'Thursday'
        'torsdag'
      when 'Friday'
        'fredag'
      else
        'Vi levererar inte på helgerna'
    end
  end

  def articles_text(order)
    sv_pluralize(order.total_items, 'produkt')
  end

  def shared_meta_keywords
    'singelfransar, fransar, lösfransar, ögonfransförlängning, fransförlängning, flares,' +
        ' silkesfransar, minkfransar, c-fransar, b-fransar, d-fransar, j-fransar.'+
        ' billiga fransar, billiga produkter ögonfransförlängning'
  end

  def default_meta_description
    @default_meta_description ||= '' +
        'Stort utbud av professionella produkter och singelfransar för ögonfransförlängning. '+
        'Vi har allt, C-fransar, B-fransar, J-fransar, D-fransar, silkesfransar. '
  end

  def sv_pluralize(count, singular, plural = nil)
    word = if (count == 1 || count =~ /^1(\.0+)?$/)
             singular
           else
             plural || singular.swedish_pluralize
           end

    "#{count || 0} #{word}"
  end

end