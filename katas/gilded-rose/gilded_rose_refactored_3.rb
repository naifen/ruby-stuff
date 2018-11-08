class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        update_item(item, AgedBrie)
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_item(item, BackstagePasses)
      when 'Conjured Mana Cake'
        update_item(item, ConjuredManaCake)
      when 'Sulfuras, Hand of Ragnaros'
      else
        update_item(item, DefaultItem)
      end
    end
  end

  private

  def update_item(target, klass)
    tmp = klass.new(target.name, target.sell_in, target.quality)
    tmp.update
    target.sell_in = tmp.sell_in
    target.quality = tmp.quality
  end
end

#DO NOT change Item class
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class DefaultItem < Item
  def update
    update_quality
    update_sell_in
  end

  private

  def update_quality
    if @sell_in > 0
      quality = @quality - 1
    else
      quality = @quality - 2
    end

    @quality = quality if quality >= 0
  end

  def update_sell_in
    @sell_in -= 1
  end
end

class AgedBrie < Item
  def update
    update_quality
    update_sell_in
  end

  private

  def update_quality
    if @sell_in > 0
      quality = @quality + 1
    else
      quality = @quality + 2
    end

    @quality = quality if quality <= 50
  end

  def update_sell_in
    @sell_in -= 1
  end
end

class BackstagePasses < Item
  def update
    update_quality
    update_sell_in
  end

  private

  def update_quality
    quality = if @sell_in > 10
                @quality + 1
              elsif @sell_in > 5
                @quality + 2
              elsif @sell_in > 0
                @quality + 3
              else
                0
              end

    @quality = quality if quality <= 50
    @quality = 50 if quality > 50
  end

  def update_sell_in
    @sell_in -= 1
  end
end

class ConjuredManaCake < Item
  def update
    update_quality
    update_sell_in
  end

  private

  def update_quality
    quality = @quality - 2
    @quality = quality if quality >= 0
  end

  def update_sell_in
    @sell_in -= 1
  end
end

class Sulfuras < Item
end

