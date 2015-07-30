class Spell
  def self.correct(word)
    s = SpellingBee.new  :source_text => "#{Rails.root}/data/words.txt"
    s.correct(word).first
  end

  def self.correct_para(para)
    para.split(' ').map{ |word| correct(word)}.join(' ')
  end
end
