namespace :one_time do
  task fix_tafsir: :environment do
    Tafsir.includes(:verse).each do |tafsir|
      tafsir.update_attribute :verse_key, tafsir.verse.verse_key
    end
  end
  
  task create_juzs: :environment do
    1.upto(30).each do |juz_number|
      juz = Juz.where(juz_number: juz_number).first_or_create
      
      map = {}
      juz.chapters.each do |chapter|
        juz_verses                  = chapter.verses.where(juz_number: juz_number).order('verse_number asc')
        map[chapter.chapter_number] = "#{juz_verses.first.verse_number}-#{juz_verses.last.verse_number}"
      end
      
      juz.verse_mapping = map
      juz.save
    end
  end
  
  task fix_pause_mark: :environment do
    {
      '6d6' => "ۖ",
      '6da' => "ۚ",
      '6d7' => "ۗ",
      '6d8' => "ۘ",
      '6dc' => "ۜ",
      '6d9' => "ۙ",
      '6db' => "ۛ",
      '6e9' => "۩",
      '6de' => '۞'
      
    }.each_pair do |key, val|
      Word.where(code_hex_v3: key).update_all text_madani: val, text_simple: val
    end
  end
end
