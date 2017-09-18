namespace :one_time do
  task update_language_priorities: :environment do
    Translation.where.not(language_id: Language.default.id).update_all language_priority: 2
    Translation.where(language_id: Language.default.id).update_all language_priority: 1

    TranslatedName.where.not(language_id: Language.default.id).update_all language_priority: 2
    TranslatedName.where(language_id: Language.default.id).update_all language_priority: 2
  end
  
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
        juz_verses = chapter.verses.where(juz_number: juz_number).order('verse_number asc')
        map[chapter.chapter_number] = "#{juz_verses.first.verse_number}-#{juz_verses.last.verse_number}"
      end

      juz.verse_mapping = map
      juz.save
    end
  end
end
