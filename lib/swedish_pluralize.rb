module SwedishPluralize
  def self.inflections_plural(i)
    # declination 1 -or
    i.plural /a$/i, 'or' # flicka, flickor

    # declination 2 -ar
    i.plural /e$/i, 'ar' # pojke, pojkar
    i.plural /g$/i, 'gar'
    i.plural /el$/i, 'ar' # fågel, fåglar
    i.plural /l$/i, 'lar' # bil, bilar

    # declination 3 -er
    i.plural /([tmnslpr])$/i, '\1er' # produkt, produkter
    i.plural /kel$/i, 'kler' # muskel, muskler
    i.plural /tel$/i, 'tlar' # titel, titlar

    # declination 4 -r
    i.plural /de$/i, 'der' # fiende, fiender

    # declination 5 -n
    i.plural /le$/i, 'lem' # muskel, muskler

    i.plural /ö$/i, 'ön' #frö, frön
    i.plural /ok$/i, 'öcker' #bok, böcker
    i.plural /um$/i, 'a' #faktum, fakta
    i.plural /o$/i, 'or' #sko, skor
    i.plural /and$/i, 'änder' #hand, händer
    i.plural /s$/i, 'sor' #ros, rosor
    i.plural /man$/i, 'män' #man, män
    i.plural /mus$/i, 'möss' #mus, möss
    i.plural /d$/i, 'den' #huvud, huvuden
    i.plural /ne$/i, 'nen' #vittne, vittnen

    # Own hack
    i.plural /i$/i, 'ier' #kategori, kategorier
  end

  def self.inflections_singular(i)
    # declination 1 -or
    i.singular /or$/i, 'a' # flicka, flickor

    # declination 2 -ar
    i.singular /kar$/i, 'ke' # pojke, pojkar
    i.singular /gar$/i, 'g'
    i.singular /glar$/i, 'gel' # fågel, fåglar
    i.singular /lar$/i, '' # bil, bilar

    # declination 3 -er
    i.singular /([tmnslpr])er$/i, '\1' # produkt, produkter
    i.singular /ler$/i, 'el' # muskel, muskler

    # declination 4 -r
    i.singular /der$/i, 'de' # fiende, fiender

    # declination 5 -n
    i.singular /kler$/i, 'kel' # muskel, muskler
    i.singular /tlar$/i, 'tel' # titel, titlar

    i.singular /en$/i, 'e' #vittne, vittnen
    i.singular /ön$/i, 'ö' #frö, frön
    i.singular /öcker$/i, 'ok' #bok, böcker
    i.singular /a$/i, 'um' #faktum, fakta
    i.singular /män$/i, 'man' #man, män
    i.singular /möss$/i, 'mus' #mus, möss
    i.singular /den$/i, 'd' #huvud, huvuden
    i.singular /kor$/i, 'ko' #sko, skor
    i.singular /änder$/i, 'and' #hand, händer
    i.singular /sor$/i, 's' #ros, rosor

  end

  def self.inflections_uncountable(i)
    i.uncountable %w(hus kar träd får brev namn nummer kön)
  end

  def self.inflections_irregular(i)
  end

  def self.ordinalize(number)
    if (11..12).include?(number.to_i % 100)
      "#{number}:e"
    else
      case number.to_i % 10
        when 1
          "#{number}:a"
        when 2
          "#{number}:a"
        else
          "#{number}:e"
      end
    end
  end

  def self.inflections
    if block_given?
      yield ActiveSupport::Inflector.inflections(:sv)
    else
      ActiveSupport::Inflector.inflections(:sv)
    end
  end

  def self.pluralize(word)
    result = word.to_s.dup
    if inflections.uncountables.include?(result.downcase)
      result
    else
      inflections.plurals.each do |(rule, replacement)|
        break if result.gsub!(rule, replacement)
      end
      result
    end
  end
end

SwedishPluralize.inflections do |i|
  SwedishPluralize::inflections_plural(i)
  SwedishPluralize::inflections_singular(i)
  SwedishPluralize::inflections_irregular(i)
  SwedishPluralize::inflections_uncountable(i)
end
