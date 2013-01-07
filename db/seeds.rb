Section.create([{name: 'main', title: 'Main'},
                {name: 'contacts', title: 'Contacts'},
               ])

TextPage.create([
                {name: 'main', section_id: Section.find_by_name('main').id},
                {name: 'contacts', section_id: Section.find_by_name('contacts').id},
                ])

TextPage.find_by_name('main') do |t|
  t.body =<<-END
Main page text. Lorem ipsum dolor sit amet
END
  t.save
end


TextPage.all.each do |t|
  if(t.body.nil? || t.body.empty?)
    t.body = (t.section.title.to_s + ' ') * 5
    t.save
  end
end
